<?php

// app/Models/IngresoEgreso.php
namespace App\Models;

use App\Models\Carpetas\Carpetas;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Spatie\Permission\Traits\HasRoles;

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
        'fecha'
    ];

    public function carpeta()
    {
        return $this->belongsTo(Carpetas::class, 'carpeta_id', 'id');
    }
}
