<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cita extends Model
{
    use HasFactory;

    protected $table = "citas";

    public function user()
    {
        return $this->belongsTo(User::class, 'id_usuario');
    }

    public function auto()
    {
        return $this->belongsTo(Auto::class, 'id_auto');
    }

    public function servicio()
    {
        return $this->belongsTo(Servicio::class, 'id_servicio');
    }
}
