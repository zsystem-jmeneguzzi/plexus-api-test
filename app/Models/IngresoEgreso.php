<?php

namespace App\Models;

use App\Models\Patient\Patient;
use App\Models\Carpetas\Carpetas;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class IngresoEgreso extends Model
{
    use HasFactory, HasRoles;

    protected $table = 'ingresos_egresos';

    protected $fillable = [
        'carpeta_id',
        'user_id',
        'concepto',
        'monto',
        'tipo',
        'fecha',
        'patient_id'
    ];

    public function patient()
    {
        return $this->belongsTo(Patient::class, 'patient_id', 'id');
    }
    public function show($id)
    {
        $carpeta = Carpetas::find($id);

        // Verifica si la carpeta está asignada al abogado logueado
        if ($carpeta->abogado_id !== auth()->user()->id) {
            return response()->json(['error' => 'No es posible acceder porque esta carpeta está asignada a otro abogado.'], 403);
        }

        return response()->json($carpeta);
    }



    public function carpeta()
    {
        return $this->belongsTo(Carpetas::class, 'carpeta_id');
    }
}
