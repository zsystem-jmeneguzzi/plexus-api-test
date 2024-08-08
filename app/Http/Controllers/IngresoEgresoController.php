<?php
// app/Http/Controllers/IngresoEgresoController.php
namespace App\Http\Controllers;

use App\Models\IngresoEgreso;
use Illuminate\Http\Request;
use Validator;

class IngresoEgresoController extends Controller
{
    public function index(Request $request, $carpeta_id = null)
    {
        $this->authorize('viewAny', IngresoEgreso::class);

        if ($carpeta_id) {
            $ingresosEgresos = IngresoEgreso::where('carpeta_id', $carpeta_id)->get();
        } else {
            $ingresosEgresos = IngresoEgreso::all();
        }

        $ingresosEgresos = $ingresosEgresos->map(function ($item) {
            return [
                'id' => $item->id,
                'monto' => $item->monto,
                'tipo' => $item->tipo,
                'fecha' => $item->fecha,
                'autos' => $item->carpeta ? $item->carpeta->autos : null,
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
            'tipo' => 'required|in:ingreso,egreso',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $carpetaId = $request->input('carpeta_id', 1);

        $ingresoEgreso = IngresoEgreso::create([
            'carpeta_id' => $carpetaId,
            'user_id' => auth('api')->user()->id,
            'concepto' => $request->input('concepto'),
            'monto' => $request->input('monto'),
            'tipo' => $request->input('tipo'),
            'fecha' => now(),
        ]);

        return response()->json($ingresoEgreso, 201);
    }

    public function destroy($id)
    {
        $ingresoEgreso = IngresoEgreso::findOrFail($id);
        $this->authorize('delete', $ingresoEgreso);

        $ingresoEgreso->delete();
        return response()->json(null, 204);
    }
}

