<?php

namespace App\Models\Doctor;

use Carbon\Carbon;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use App\Models\Doctor\DoctorScheduleJoinHour;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class DoctorScheduleDay extends Model
{
    use HasFactory;
    // use SoftDeletes;
    protected $fillable = [
        "user_id",
        "day",
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

    public function schedule_hours() {
        return $this->hasMany(DoctorScheduleJoinHour::class);
    }
    public function doctor() {
        return $this->belongsTo(User::class,"user_id");
    }
}
