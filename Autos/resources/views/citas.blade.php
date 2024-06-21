@extends('adminlte::page')

@section('title', 'Citas')

@section('content')

@if ($errors->any())
    <div class="alert alert-danger">
        <ul>
        <p><strong>Por favor corrija los siguientes errores e intente de nuevo:</strong></p>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif

@if (session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif

    <h1 class="text-center">Citas</h1>
    <div class="text-center">
    <img src="{{ asset('div.jpg') }}" alt="Imagen" style="border-radius: 50%; width: 200px; height: 200px;">
    
    </div>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title text-center" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-weight: 600; font-size: 30px; padding:10px;">Lista de Citas</h3>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table id="table-data" class="table table-bordered table-striped rounded text-center">
                        <thead>
                            <tr class="bg-primary">
                                <th>Usuario</th>
                                <th>Servicio</th>
                                <th>Autos</th>
                                <th>Fecha</th>
                                <th>Hora cita</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($citas as $cita)
                            <tr>
                                <td>{{ $cita->user->name }}</td>
                                <td>{{ $cita->auto->matricula }}</td>
                                <td>{{ $cita->auto->color }}</td>
                                <td>{{ $cita->fecha }}</td>
                                <td>{{ $cita->hora_cita }}</td>
                                <td>
                                    <a href="{{ route('cita.nuevo', ['id' => $cita['id']]) }}" class="btn btn-primary btn-sm" data-toggle="tooltip" title="Editar cita">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="{{ route('cita.eliminar', ['id' => $cita['id']]) }}" method="POST" class="d-inline">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar esta división?')" data-toggle="tooltip" title="Eliminar cita">
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