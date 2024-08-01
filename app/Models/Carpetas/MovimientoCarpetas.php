<?php

namespace App\Models\Carpetas;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class MovimientoCarpetas extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'carpeta_id',
        'abogado_id',
        'comentario',
        'archivo',
        'archivo_nombre',
        'created_at',
        'updated_at',
        'deleted_at',
        'fecha_vencimiento',
        'hora_vencimiento',
        'tipo_evento',
    ];

    public function setCreatedAtAttribute($value)
    {
    	date_default_timezone_set('America/Argentina/Buenos_Aires');
        $this->attributes["created_at"]= Carbon::now();
    }

    public function setUpdatedAtAttribute($value)
    {
    	date_default_timezone_set("America/Argentina/Buenos_Aires");
        $this->attributes["updated_at"]= Carbon::now();
    }

   // public function movimientos() {
   //     return $this->hasOne(MovimientoCarpetas::class,"patient_id");
   // }
   public function getComentarioAttribute($value)
    {
        return $value;
    }

    // Si estás utilizando un mutador para comentario, asegúrate de que esté correcto
    public function setComentarioAttribute($value)
    {
        $this->attributes['comentario'] = $value;
    }

}
