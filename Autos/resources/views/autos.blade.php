@extends('adminlte::page')

@section('title', 'Autos')

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

    <h1 class="text-center">Auto</h1>
    <div class="text-center">
    <img src="{{ asset('div.jpg') }}" alt="Imagen" style="border-radius: 50%; width: 200px; height: 200px;">
    
    </div>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title text-center" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-weight: 600; font-size: 30px; padding:10px;">Lista de Autos</h3>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table id="table-data" class="table table-bordered table-striped rounded text-center">
                        <thead>
                            <tr class="bg-primary">
                                <th>Matricula</th>
                                <th>Color</th>
                                <th>Modelo</th>
                                <th>Marca</th>
                                <th>Opcion</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($autos as $auto)
                            <tr>
                                <td>{{ $auto['matricula'] }}</td>
                                <td>{{ $auto['color'] }}</td>
                                <td>{{ $auto['modelo'] }}</td>
                                <td>{{ $auto['marca'] }}</td>
                                <td>
                                    <a href="{{ route('auto.nuevo', ['id' => $auto['id']]) }}" class="btn btn-primary btn-sm" data-toggle="tooltip" title="Editar auto">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="{{ route('auto.eliminar', ['id' => $auto['id']]) }}" method="POST" class="d-inline">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar esta división?')" data-toggle="tooltip" title="Eliminar auto">
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