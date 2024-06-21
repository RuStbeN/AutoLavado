@extends('adminlte::page')

@section('title', 'Servicio')
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

<h1 class="text-center">Servicio</h1>
<div class="text-center">
    <img src="{{ asset('div.jpg') }}" alt="Imagen" style="border-radius: 50%; width: 200px; height: 200px;">
</div>
@stop

@section('content')

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card">
            <div class="card-body">
                <form id="servicioForm" action="{{ route('servicio.guardar')}}" method="POST">
                    @csrf
                    <input type="hidden" name="id" value="{{ $servicio->id }}">
                    
                    <div class="mb-3">
                        <label for="codigo" class="form-label">Código:</label>
                        <input type="text" name="codigo" value="{{ $servicio->codigo }}" class="form-control" placeholder="Ingrese el código" required autofocus>
                    </div>
                    
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" name="nombre" value="{{ $servicio->nombre }}" class="form-control" placeholder="Ingrese el nombre" required>
                    </div>

                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción:</label>
                        <input type="text" name="descripcion" value="{{ $servicio->descripcion }}" class="form-control" placeholder="Ingrese la descripción" required>
                    </div>

                    <div class="mb-3">
                        <label for="precio" class="form-label">Precio:</label>
                        <input type="text" name="precio" value="{{ $servicio->precio }}" class="form-control" placeholder="Ingrese el precio" required>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </form>


                <!-- Formulario para añadir etapas -->
                <form method="POST" action="{{ route('etapa.store') }}">
                @if($servicio->id)
                    @csrf

                    <input type="hidden" name="id_servicios" value="{{ $servicio->id }}">

                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="duracion">Duración:</label>
                        <input type="number" name="duracion" id="duracion" class="form-control" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Guardar Etapa</button>
                </form>
                @endif




                <!-- Listado de etapas -->
                @if($servicio->etapas->count())
                    <h5 class="mt-4">Etapas</h5>
                    <ul class="list-group">
                        @foreach($servicio->etapas as $etapa)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span>
                                    <strong>{{ $etapa->nombre }}</strong> - {{ $etapa->duracion }} días
                                </span>
                                <div class="btn-group" role="group">
                                    <!-- Botón para eliminar etapa -->
                                    <form action="{{ route('etapa.eliminar', $etapa->id) }}" method="POST">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                    </form>

                                    <!-- Botón para editar etapa -->
                                    <button type="button" class="btn btn-primary btn-sm" onclick="editarEtapa({{ $etapa->id }})">
                                        Editar
                                    </button>
                                    
                                    <!-- Formulario de edición de etapa -->
                                    <form id="formEditarEtapa{{ $etapa->id }}" class="d-none" action="{{ route('etapa.update', $etapa->id) }}" method="POST">
                                        @csrf
                                        @method('PUT')

                                        <div class="form-group">
                                            <label for="nombre{{ $etapa->id }}">Nombre:</label>
                                            <input type="text" name="nombre" id="nombre{{ $etapa->id }}" class="form-control" value="{{ $etapa->nombre }}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="duracion{{ $etapa->id }}">Duración:</label>
                                            <input type="number" name="duracion" id="duracion{{ $etapa->id }}" class="form-control" value="{{ $etapa->duracion }}" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-sm">Guardar Cambios</button>
                                    </form>
                                </div>
                            </li>
                        @endforeach
                    </ul>
                @endif
            </div>
        </div>
    </div>
</div>

<script>
    function editarEtapa(id) {
        // Ocultar otros formularios de edición
        document.querySelectorAll('[id^="formEditarEtapa"]').forEach(form => {
            form.classList.add('d-none');
        });

        // Mostrar el formulario de edición correspondiente
        document.getElementById(`formEditarEtapa${id}`).classList.remove('d-none');
    }
</script>

@stop
