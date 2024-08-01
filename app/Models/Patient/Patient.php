<?php
namespace App\Models\Patient;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Patient extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'name',
        'surname',
        'mobile',
        'email',
        'birth_date',
        'gender',
        'n_tramite',
        'n_document',
        'address',
        'observations',
        'cuil',
        'clave_seguridad_social',
        'clave_fiscal',
    ];


    public function setCreatedAtAttribute($value)
    {
        date_default_timezone_set('America/Argentina/Buenos_Aires');
        $this->attributes['created_at'] = Carbon::now();
    }

    public function setUpdatedAtAttribute($value)
    {
        date_default_timezone_set('America/Argentina/Buenos_Aires');
        $this->attributes['updated_at'] = Carbon::now();
    }
}
