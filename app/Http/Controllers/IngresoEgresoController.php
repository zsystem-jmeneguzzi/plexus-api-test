<?php
namespace App\Http\Controllers;

use App\Models\IngresoEgreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class IngresoEgresoController extends Controller
{
    public function index(Request $request, $carpeta_id = null)
    {
        $this->authorize('viewAny', IngresoEgreso::class);

        if ($carpeta_id) {
            $ingresosEgresos = IngresoEgreso::where('carpeta_id', $carpeta_id)->with('carpeta')->get();
        } else {
            $ingresosEgresos = IngresoEgreso::with('carpeta')->get();
        }

        $ingresosEgresos = $ingresosEgresos->map(function ($item) {
            return [
                'id' => $item->id,
                'monto' => $item->monto,
                'tipo' => $item->tipo,
                'fecha' => $item->fecha,
                'autos' => $item->carpeta ? $item->carpeta->autos : '',
                'concepto' => $item->concepto,
                'carpeta_id' => $item->carpeta_id, // Asegúrate de incluir el carpeta_id
            ];
        });

        return response()->json($ingresosEgresos);
    }

    public function show($id)
    {
        $carpeta = Carpeta::find($id);

        // Verifica si la carpeta está asignada al abogado logueado
        if ($carpeta->abogado_id !== auth()->user()->id) {
            return response()->json(['error' => 'No es posible acceder porque esta carpeta está asignada a otro abogado.'], 403);
        }

        return response()->json($carpeta);
    }


    public function store(Request $request)
    {
        $this->authorize('create', IngresoEgreso::class);

        $validator = Validator::make($request->all(), [
            'concepto' => 'required|string|max:255',
            'monto' => 'required|numeric',
            'tipo' => 'required|in:ingreso,egreso,deuda',
            'patient_id' => 'required_if:tipo,deuda|nullable|exists:patients,id'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $ingresoEgreso = IngresoEgreso::create([
            'carpeta_id' => $request->input('carpeta_id'),
            'user_id' => auth('api')->user()->id,
            'concepto' => $request->input('concepto'),
            'monto' => $request->input('monto'),
            'tipo' => $request->input('tipo'),
            'fecha' => now(),
            'patient_id' => $request->input('patient_id') // Esto puede ser nulo si no es deuda
        ]);

        return response()->json($ingresoEgreso, 201);
    }

    public function payDebt(Request $request, $deudaId)
{
    $deuda = IngresoEgreso::findOrFail($deudaId);
    $this->authorize('update', $deuda); // Autorizar con el usuario y el modelo

    $validator = Validator::make($request->all(), [
        'monto' => 'required|numeric'
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 422);
    }

    if ($deuda->tipo !== 'deuda') {
        return response()->json(['error' => 'Invalid type, must be debt'], 422);
    }

    $pago = $request->input('monto');
    $deuda->monto -= $pago;
    $deuda->save();

    $ingreso = IngresoEgreso::create([
        'carpeta_id' => $deuda->carpeta_id,
        'user_id' => auth('api')->user()->id,
        'concepto' => 'Pago de deuda: ' . $deuda->concepto,
        'monto' => $pago,
        'tipo' => 'ingreso',
        'fecha' => now(),
        'patient_id' => $deuda->patient_id
    ]);

    return response()->json(['deuda' => $deuda, 'ingreso' => $ingreso], 200);
    }
    public function destroy($id)
    {
        $ingresoEgreso = IngresoEgreso::findOrFail($id);

        // Verifica si la carpeta está asignada al abogado logueado
        $carpeta = $ingresoEgreso->carpeta;
        if ($carpeta->abogado_id !== auth()->user()->id) {
            return response()->json(['error' => 'No es posible eliminar este item porque la carpeta está asignada a otro abogado.'], 403);
        }

        $this->authorize('delete', $ingresoEgreso);

        $ingresoEgreso->delete();

        return response()->json(['message' => 'Item eliminado correctamente.'], 200);
    }

}
