<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Servicio extends Model
{
    use HasFactory;

    protected $table = 'servicios'; // Nombre de la tabla

    public function etapas()
    {
        return $this->hasMany(Etapa::class, 'id_servicios'); // Relación uno a muchos con Etapa
    }
}
