<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Clientes</h3>
	<p>
		<div class="btn-group">
			<a class="btn btn-primary btn-md" href="{BASE_URL}clientes/nuevo" role="button"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Agregar</a>
			<a class="btn btn-success btn-md" href="{BASE_URL}clientes/mapa" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Mapa</a>
			<button type="button" class="btn btn-success dropdown-toggle btn-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul class="dropdown-menu">
			<li><a href="{BASE_URL}rutas/trazar">Trazar ruta</a></li>
			</ul>
		</div>
	</p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<script type="text/javascript">
function editarElemento(registro) {
	console.log(registro)
	$.redirect('{BASE_URL}clientes/editar', {'clave': registro.Clave})
}
</script>
<incluir archivo="Footer">