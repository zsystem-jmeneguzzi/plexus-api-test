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
                'autos' => $item->carpeta ? $item->carpeta->autos : 'N/A',
                'concepto' => $item->concepto,
            ];
        });

        return response()->json($ingresosEgresos);
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
}
