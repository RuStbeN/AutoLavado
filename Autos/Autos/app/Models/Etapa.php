<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Etapa extends Model
{
    protected $table = 'etapas'; // Especificar el nombre de la tabla
    protected $primaryKey = 'id'; // Especificar la clave primaria
    protected $foreignKey = 'id_servicios'; // Especificar la clave foránea

    public function servicio()
    {
        return $this->belongsTo(Servicio::class, 'id_servicios'); // Especificar la columna de la clave foránea
    }
}

