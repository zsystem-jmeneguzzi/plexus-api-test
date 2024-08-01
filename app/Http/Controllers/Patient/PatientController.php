<?php

namespace App\Http\Controllers\Patient;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\Patient\Patient;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class PatientController extends Controller
{

    public function index(Request $request)
    {
        $this->authorize('viewAny', Patient::class);
        $search = $request->search;

        $patients = Patient::where(DB::raw("CONCAT(patients.name,' ',IFNULL(patients.surname,''),' ',patients.email)"), "like", "%" . $search . "%")
                        ->orderBy("id", "desc")
                        ->paginate(20);

        return response()->json([
            "total" => $patients->total(),
            "patients" => $patients->items()
        ]);
    }
    public function store(Request $request)
    {
        $this->authorize('create', Patient::class);
        $patient_is_valid = Patient::where('n_document', $request->n_document)->first();

        if ($patient_is_valid) {
            return response()->json([
                'message' => 403,
                'message_text' => 'EL PACIENTE YA EXISTE'
            ]);
        }

        if ($request->birth_date) {
            $date_clean = preg_replace('/\(.*\)|[A-Z]{3}-\d{4}/', '', $request->birth_date);
            $request->request->add(['birth_date' => Carbon::parse($date_clean)->format('Y-m-d h:i:s')]);
        }

        $patient = Patient::create($request->except('education')); // Ignorar education aquí

        return response()->json([
            'message' => 200
        ]);
    }

    public function show($id)
    {
        $this->authorize('view', Patient::class);
        $patient = Patient::findOrFail($id);

        return response()->json([
            'patient' => $patient,
            'message' => 200
        ]);
    }

    public function update(Request $request, $id)
    {
        $this->authorize('update', Patient::class);
        $patient_is_valid = Patient::where('id', '<>', $id)->where('n_document', $request->n_document)->first();

        if ($patient_is_valid) {
            return response()->json([
                'message' => 403,
                'message_text' => 'EL PACIENTE YA EXISTE'
            ]);
        }

        $patient = Patient::findOrFail($id);

        if ($request->birth_date) {
            $date_clean = preg_replace('/\(.*\)|[A-Z]{3}-\d{4}/', '', $request->birth_date);
            $request->merge(['birth_date' => Carbon::parse($date_clean)->format('Y-m-d h:i:s')]);
        }

        $patient->update($request->all());

        return response()->json([
            'message' => 200
        ]);
    }



    public function destroy($id)
    {
        $this->authorize('delete', Patient::class);

        $patient = Patient::findOrFail($id);

        $patient->delete(); // Esto ahora usará soft delete

        return response()->json([
            'message' => 200
        ]);
    }

}
