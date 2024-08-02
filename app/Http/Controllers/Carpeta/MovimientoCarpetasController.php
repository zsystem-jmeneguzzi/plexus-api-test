<?php

namespace App\Http\Controllers\Carpeta;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\Carpetas\Carpetas;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use App\Models\Carpetas\MovimientoCarpetas;

class MovimientoCarpetasController extends Controller
{
    public function update(Request $request, $id)
    {
        $movimiento = MovimientoCarpetas::findOrFail($id);

        if ($request->hasFile('archivo')) {
            // Eliminar archivo antiguo si existe
            if ($movimiento->archivo) {
                Storage::delete($movimiento->archivo);
            }

            $path = $request->file('archivo')->store('archivos');
            $request->merge(['archivo' => $path]);
        }

        $movimiento->update($request->all());

        return response()->json(['message' => 'Movimiento updated successfully.', 'movimiento_carpetas' => $movimiento]);
    }

    public function store(Request $request)
{
    $carpetas = Carpetas::findOrFail($request->carpeta_id);
    $archivoUrl = null;
    $archivoNombre = null;

    DB::beginTransaction();

    try {
        if ($request->hasFile('archivo')) {
            $file = $request->file('archivo');
            $filename = time() . '_' . $file->getClientOriginalName();
            $path = $file->storeAs('archivos', $filename);
                // Generar la URL completa del archivo
                $archivoUrl = env('APP_URL') . 'storage/archivos/' . $filename;
            $archivoNombre = $file->getClientOriginalName();
        }

        $movimiento_carpetas = MovimientoCarpetas::create($request->all());

        $carpetas->update(["ultimo_movimiento" => now()]);

        if ($archivoUrl && $archivoNombre) {
            $movimiento_carpetas->update(['archivo' => $archivoUrl, 'archivo_nombre' => $archivoNombre]);
        }

        DB::commit();

        return response()->json([
            "message" => 200,
            "movimiento_carpetas" => $movimiento_carpetas,
        ]);
    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json([
            "message" => "Error: " . $e->getMessage(),
        ], 500);
    }
}

public function show(string $carpeta_id)
{
    $movimientos_carpetas = MovimientoCarpetas::where('carpeta_id', $carpeta_id)->get();

    if ($movimientos_carpetas->isNotEmpty()) {
        $response = $movimientos_carpetas->map(function ($movimiento_carpetas) {
            $comentario = $movimiento_carpetas->comentario;
            $decodedComentario = $this->isJson($comentario) ? json_decode($comentario, true) : $comentario;

            return [
                "id" => $movimiento_carpetas->id,
                "carpeta_id" => $movimiento_carpetas->carpeta_id,
                "abogado_id" => $movimiento_carpetas->abogado_id,
                "comentario" => $decodedComentario,
                "created_at" => $movimiento_carpetas->created_at->format("Y-m-d h:i A"),
                "archivo" => $movimiento_carpetas->archivo,  // La URL completa ya está guardada en la base de datos
                "archivo_nombre" => $movimiento_carpetas->archivo_nombre,  // El nombre original del archivo
                "fecha_vencimiento" => $movimiento_carpetas->fecha_vencimiento, // La fecha de vencimiento

                "hora_vencimiento" => $movimiento_carpetas->hora_vencimiento, // La hora de vencimiento
                "tipo_evento" => $movimiento_carpetas->tipo_evento // El tipo de evento
            ];
        });

        return response()->json([
            "movimientos_carpetas" => $response
        ]);
    } else {
        return response()->json([
            "movimientos_carpetas" => []
        ]);
    }
}

// Función para verificar si una cadena es JSON
private function isJson($string)
{
    json_decode($string);
    return (json_last_error() == JSON_ERROR_NONE);
}


    public function destroy($id)
    {
        DB::beginTransaction();

        try {
            $movimiento = MovimientoCarpetas::findOrFail($id);
            // Eliminar el archivo del almacenamiento
            if ($movimiento->archivo) {
                $filename = str_replace(env('APP_URL') . '/storage/archivos/', '', $movimiento->archivo);
                Storage::delete('public/archivos/' . $filename);
            }
            $movimiento->delete();

            DB::commit();

            return response()->json(['message' => 'Movimiento eliminado correctamente.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                "message" => "Error: " . $e->getMessage(),
            ], 500);
        }
    }

    public function getMovimientos()
{
    $movimientos = MovimientoCarpetas::whereNotNull('fecha_vencimiento')->get();

    return response()->json([
        'movimientos_carpetas' => $movimientos->map(function ($movimiento) {
            $hora_vencimiento = $movimiento->hora_vencimiento;
            if ($hora_vencimiento) {
                try {
                    $hora_vencimiento = \Carbon\Carbon::createFromFormat('H:i:s', $hora_vencimiento)->format('H:i');
                } catch (\Exception $e) {
                    // Handle the exception if the format is incorrect
                    $hora_vencimiento = null;
                }
            }
            return [
                'id' => $movimiento->id,
                'carpeta_id' => $movimiento->carpeta_id,
                'abogado_id' => $movimiento->abogado_id,
                'comentario' => $movimiento->comentario,
                'fecha_vencimiento' => $movimiento->fecha_vencimiento,
                'hora_vencimiento' => $hora_vencimiento,
                'tipo_evento' => $movimiento->tipo_evento,
                'archivo' => $movimiento->archivo,
                'archivo_nombre' => $movimiento->archivo_nombre
            ];
        })
    ]);
}

public function getArchivosAdjuntos($carpeta_id)
{
    $archivos = MovimientoCarpetas::where('carpeta_id', $carpeta_id)
        ->whereNotNull('archivo')
        ->get(['archivo', 'archivo_nombre']);

    return response()->json([
        'archivos' => $archivos,
    ]);
}





}
