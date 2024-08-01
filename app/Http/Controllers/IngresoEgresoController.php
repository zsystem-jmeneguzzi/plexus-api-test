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

        // $ingresosEgresos = IngresoEgreso::with('carpeta')->get(); // Linea modificada

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
                'autos' => $item->carpeta ? $item->carpeta->autos : null, // Linea modificada
                'concepto' => $item->concepto,
            ];
        });

        return response()->json($ingresosEgresos);
    }

        public function store(Request $request)
        {
            $validator = Validator::make($request->all(), [
                'concepto' => 'required|string|max:255',
                'monto' => 'required|numeric',
                'tipo' => 'required|in:ingreso,egreso',
            ]);

            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }

            $carpetaId = $request->input('carpeta_id', 1); // Usar la carpeta predeterminada si no se proporciona

            $ingresoEgreso = IngresoEgreso::create([
                'carpeta_id' => $carpetaId,
                'user_id' => auth('api')->user()->id,
                'concepto' => $request->input('concepto'),
                'monto' => $request->input('monto'),
                'tipo' => $request->input('tipo'),
                'fecha' => now()
            ]);

            return response()->json($ingresoEgreso, 201);
        }

    public function destroy($id)
    {
        $ingresoEgreso = IngresoEgreso::find($id);
        if ($ingresoEgreso) {
            $ingresoEgreso->delete();
            return response()->json(null, 204);
        }
        return response()->json(['message' => 'Not found'], 404);
    }
}
