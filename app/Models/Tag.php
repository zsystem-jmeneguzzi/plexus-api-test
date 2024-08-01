<?php
// App\Models\Tag.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    public function carpetas()
    {
        return $this->belongsToMany(Carpeta::class, 'carpeta_tag', 'tag_id', 'carpeta_id');
    }
}
