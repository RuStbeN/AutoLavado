@extends('adminlte::page')

@section('title', 'Cita')
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

    <h1 class="text-center">Cita</h1>
    <div class="text-center">
    <img src="{{ asset('div.jpg') }}" alt="Imagen" style="border-radius: 50%; width: 200px; height: 200px;">
    
    </div>
@stop
@section('content')

    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">

                    <form id="citaForm" action="{{ route('cita.guardar')}}" method="POST">

                        @csrf
                        <input type="hidden" name="id" value="{{$cita->id}}">

                        <div class="mb-3">
                            <label for="id_usuario" class="form-label">Usuario:</label>
                            <select name="id_usuario" class="form-control">
                                <option value="">Seleccione un usuario</option>
                                @foreach ($users as $user)
                                    <option value="{{$user->id}}">{{$user->name}}</option>
                                @endforeach
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="id_servicio" class="form-label">Servicio:</label>
                            <select name="id_servicio" class="form-control">
                                <option value="">Seleccione un servicio</option>
                                @foreach ($servicios as $servicio)
                                    <option value="{{$servicio->id}}">{{$servicio->nombre}}</option>
                                @endforeach
                            </select>
                        </div>
                        

                        <div class="mb-3">
                            <label for="id_auto" class="form-label">Autos:</label>
                            <select name="id_auto" class="form-control">
                                <option value="">Seleccione un Auto</option>
                                @foreach ($autos as $auto)
                                    <option value="{{$auto->id}}">{{$auto->matricula}}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="fecha" class="form-label">Fecha:</label>
                            <input type="date" name="fecha" value="{{$cita->fecha}}" class="form-control" placeholder="Ingrese la fecha" required>
                        </div>

                        <div class="mb-3">
                            <label for="hora_cita" class="form-label">Hora cita:</label>
                            <input type="text" name="hora_cita" value="{{$cita->hora_cita}}" class="form-control" placeholder="Ingrese la hora" required>
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

