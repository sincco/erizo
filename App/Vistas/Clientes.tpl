<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Clientes</h3>
	<p>
		<a class="btn btn-primary btn-lg" href="{BASE_URL}clientes/nuevo" role="button"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Agregar</a>
		<a class="btn btn-info btn-lg" href="{BASE_URL}clientes/mapa" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Mapa de clientes</a>
	</p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">