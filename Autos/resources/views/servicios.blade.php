@extends('adminlte::page')

@section('title', 'Servicios')

@section('content')
<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title text-center" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-weight: 600; font-size: 30px; padding:10px;">Lista de Servicios</h3>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table id="table-data" class="table table-bordered table-striped rounded text-center">
                        <thead>
                            <tr class="bg-primary">
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Descripcion</th>
                                <th>Precio</th>
                                <th>Opcion</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($servicios as $servicio)
                            <tr>
                                <td>{{ $servicio['codigo'] }}</td>
                                <td>{{ $servicio['nombre'] }}</td>
                                <td>{{ $servicio['descripcion'] }}</td>
                                <td>{{ $servicio['precio'] }}</td>
                                <td>
                                    <a href="{{ route('servicio.nuevo', ['id' => $servicio['id']]) }}" class="btn btn-primary btn-sm" data-toggle="tooltip" title="Editar servicio">
                                        <i class="fas fa-edit"></i>
                                    </a>

                                    <form action="{{ route('servicio.eliminar', ['id' => $servicio['id']]) }}" method="POST" class="d-inline">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar este servicio?')" data-toggle="tooltip" title="Eliminar auto">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>

                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
@stop
