<?php
// App\Models\Carpetas\Carpetas.php
namespace App\Models\Carpetas;

use App\Models\Tag;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;

class Carpetas extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'autos', 'nro_carpeta', 'fecha_inicio', 'ultimo_movimiento',
        'tipo_proceso_id', 'estado', 'descripcion', 'abogado_id',
        'contrarios_id', 'tercero_id', 'cliente_id'
    ];

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'carpeta_tag', 'carpeta_id', 'tag_id');
    }
}
