<?php
//CarpetaController.php
namespace App\Http\Controllers\Carpeta;

use Carbon\Carbon;

use App\Models\Tag;
use Illuminate\Http\Request;
use App\Models\Patient\Patient;
use App\Models\Carpetas\Carpetas;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Http\Resources\Carpeta\CarpetaResource;
use App\Http\Resources\Carpeta\CarpetaCollection;

class CarpetaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $this->authorize('viewAny',Carpetas::class);
        $search = $request->search;



        $carpetas = Carpetas::where(DB::raw("(carpetas.autos)"),"like","%".$search."%")
                        ->orderBy("id","desc")
                        ->paginate(20);

        return response()->json([
            "total" => $carpetas->total(),
            "carpetas" => CarpetaCollection::make($carpetas),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $this->authorize('create',Carpetas::class);
        $carpeta_is_valid = Carpetas::where("autos",$request->autos)
                                        ->orWhere("nro_carpeta",$request->nro_carpeta)
                                        ->first();

        if($carpeta_is_valid){
            return response()->json([
                "message" => 403,
                "message_text" => "El AUTO O NRO DE CARPETA YA EXISTE"
            ]);
        }

        if($request->fecha_inicio){
            $date_clean = preg_replace('/\(.*\)|[A-Z]{3}-\d{4}/', '', $request->fecha_inicio);

            $request->request->add(["fecha_inicio" => Carbon::parse($date_clean)->format("Y-m-d h:i:s")]);
        }

        $carpetas = Carpetas::create($request->all());

        // $request->request->add(["patient_id" => $patient->id]);
        // PatientPerson::create($request->all());

        return response()->json([
            "message" => 200
        ]);
    }

    public function config() {

        $n_document = $request->get("n_document");

        $patient = Patient::where("n_document",$n_document)->first();
        if(!$patient){
            return response()->json([
                "message" => 403,
            ]);
        }
        return response()->json([
            "message" => 200,
            "name" => $patient->name,
            "surname" => $patient->surname,
            "mobile" => $patient->mobile,
            "n_document" => $patient->n_document,
        ]);
    }

    public function query_patient(Request $request){
        $n_document = $request->get("n_document");

        $patient = Patient::where("n_document",$n_document)->first();
        if(!$patient){
            return response()->json([
                "message" => 403,
            ]);
        }
        return response()->json([
            "message" => 200,
            "name" => $patient->name,
            "surname" => $patient->surname,
            "mobile" => $patient->mobile,
            "n_document" => $patient->n_document,
        ]);
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $this->authorize('view',Carpetas::class);
        $carpetas = Carpetas::findOrFail($id);

        return response()->json([
            "carpetas" => CarpetaResource::make($carpetas),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $carpeta = Carpeta::findOrFail($id);
        $carpeta->update($request->all());
        return response()->json($carpeta);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $this->authorize('delete',Carpetas::class);
        $carpetas = Carpetas::findOrFail($id);
        // if($carpetas->avatar){
        //     Storage::delete($carpetas->avatar);
        // }
        $carpetas->delete();
        return response()->json([
            "message" => 200
        ]);
    }

    public function updateEstado(Request $request, $id)
    {
        // Autorizar la acción, si aplicas políticas de autorización
        $this->authorize('update', Carpetas::class);

        // Validar los datos del request
        $request->validate([
            'estado' => 'required|integer',
        ]);

        // Encontrar la carpeta por ID
        $carpeta = Carpetas::findOrFail($id);

        // Actualizar el estado de la carpeta
        $carpeta->estado = $request->estado;
        $carpeta->save();

        // Devolver la respuesta
        return response()->json([
            'message' => 'Estado actualizado exitosamente',
            'carpeta' => new CarpetaResource($carpeta),
        ]);
    }

    public function getTags($id)
    {
        $carpeta = Carpetas::with('tags')->find($id);
        if (!$carpeta) {
            return response()->json(['message' => 'Carpeta not found'], 404);
        }

        $tags = $carpeta->tags;

        if ($tags === null) {
            Log::error('Tags es null para la carpeta con ID: ' . $id);
            return response()->json([]);
        }

        Log::info('Tags obtenidos:', $tags->toArray()); // Registro de depuración
        return response()->json($tags); // Ajuste aquí
    }




    public function updateTags(Request $request, $id)
    {
        $carpeta = Carpetas::find($id);
        if (!$carpeta) {
            return response()->json(['message' => 'Carpeta not found'], 404);
        }
        $carpeta->tags()->sync($request->tag_ids);
        return response()->json(['message' => 'Tags updated successfully']);
    }



    public function getArchivosAdjuntos($carpetaId)
{
    $carpeta = Carpetas::find($carpetaId);

    if (!$carpeta) {
        return response()->json(['error' => 'Carpeta not found'], 404);
    }

    $archivos = MovimientoCarpetas::where('carpeta_id', $carpetaId)
        ->whereNotNull('archivo')
        ->get(['archivo', 'archivo_nombre']);

    return response()->json(['archivos' => $archivos]);
}



}

