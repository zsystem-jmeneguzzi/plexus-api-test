<?php
// App\Models\Carpetas\Carpetas.php

namespace App\Models\Carpetas;

use App\Models\Tag;
use App\Models\User;
use App\Models\Patient\Patient;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Carpetas extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'autos',
        'cliente_id',
        'nro_carpeta',
        'fecha_inicio',
        'ultimo_movimiento',
        'tipo_proceso_id',
        'estado',
        'descripcion',
        'abogado_id',
        'contrarios_id',
        'tercero_id'
    ];

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'carpeta_tag', 'carpeta_id', 'tag_id');
    }
    public function abogado()
    {
        return $this->belongsTo(User::class, 'abogado_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Patient::class, 'cliente_id');
    }

}
