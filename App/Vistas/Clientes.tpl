<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Clientes</h3>
	<p>
		<a class="btn btn-primary btn-lg" href="{BASE_URL}clientes/nuevo" role="button"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Agregar</a>
		<div class="btn-group">
			<button type="button" class="btn btn-danger" onclick="window.location='{BASE_URL}clientes/mapa'">Mapa</button>
			<button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul class="dropdown-menu">
			<li><a href="{BASE_URL}rutas/trazar">Trazar ruta</a></li>
			</ul>
		</div>
		<a class="btn btn-info btn-lg" href="{BASE_URL}clientes/mapa" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Mapas</a>
		<a class="btn btn-info btn-lg" href="{BASE_URL}clientes/mapa" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Trazar ruta</a>
	</p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">