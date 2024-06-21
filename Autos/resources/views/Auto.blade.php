@extends('adminlte::page')

@section('title', 'Auto')
@section('content_header')

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
@stop
@section('content')

    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">

                    <form id="autoForm" action="{{ route('auto.guardar')}}" method="POST">

                        @csrf
                        <input type="hidden" name="id" value="{{$auto->id}}">
                        
                        <div class="mb-3">
                            <label for="matricula" class="form-label">Matricula:</label>
                            <input type="text" name="matricula" value="{{$auto->matricula}}" class="form-control" placeholder="Ingrese la matricula" required autofocus>
                        </div>
                        
                        <div class="mb-3">
                            <label for="color" class="form-label">Color:</label>
                            <input type="text" name="color" value="{{$auto->color}}" class="form-control" placeholder="Ingrese el color" required>
                        </div>

                        <div class="mb-3">
                            <label for="modelo" class="form-label">Modelo:</label>
                            <input type="text" name="modelo" value="{{$auto->modelo}}" class="form-control" placeholder="Ingrese el modelo" required>
                        </div>

                        <div class="mb-3">
                            <label for="marca" class="form-label">Marca:</label>
                            <input type="text" name="marca" value="{{$auto->marca}}" class="form-control" placeholder="Ingrese la marca" required>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

@stop

