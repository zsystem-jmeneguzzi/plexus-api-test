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
        if ($carpeta_id) {
            $ingresosEgresos = IngresoEgreso::where('carpeta_id', $carpeta_id)->get();
        } else {
            $ingresosEgresos = IngresoEgreso::with('carpeta')
                ->when($request->input('fecha_inicio'), function($query, $fechaInicio) {
                    return $query->where('fecha', '>=', $fechaInicio);
                })
                ->when($request->input('fecha_fin'), function($query, $fechaFin) {
                    return $query->where('fecha', '<=', $fechaFin);
                })
                ->when($request->input('nombre_carpeta'), function($query, $nombreCarpeta) {
                    return $query->whereHas('carpeta', function($query) use ($nombreCarpeta) {
                        return $query->where('nombre', 'like', "%$nombreCarpeta%");
                    });
                })
                ->when($request->input('nombre_abogado'), function($query, $nombreAbogado) {
                    return $query->whereHas('carpeta.abogado', function($query) use ($nombreAbogado) {
                        return $query->where('nombre', 'like', "%$nombreAbogado%");
                    });
                })
                ->get();
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
        $validator = Validator::make($request->all(), [
            'carpeta_id' => 'nullable|exists:carpetas,id',
            'concepto' => 'required|string|max:255',
            'monto' => 'required|numeric',
            'tipo' => 'required|in:Ingreso,Egreso',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $ingresoEgreso = IngresoEgreso::create([
            'carpeta_id' => $request->input('carpeta_id'), // Puede ser null
            'user_id' => auth('api')->user()->id,
            'concepto' => $request->input('concepto'),
            'monto' => $request->input('monto'),
            'tipo' => $request->input('tipo'),
            'fecha' => now()
        ]);

        return response()->json($ingresoEgreso, 201);
    }
}
