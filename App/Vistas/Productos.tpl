<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Productos</h3>
	<div class="btn-group">
		<a class="btn btn-primary btn-md" href="{BASE_URL}productos/nuevo" role="button"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Agregar</a>
		<button type="button" class="btn btn-primary dropdown-toggle btn-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<span class="caret"></span>
			<span class="sr-only">Toggle Dropdown</span>
		</button>
		<ul class="dropdown-menu">
			<li><a href="{BASE_URL}productos/masivo">Edicion masiva</a></li>
			<li><a href="{BASE_URL}productos/masiva">Alta masiva</a></li>
		</ul>
	</div>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">

<script type="text/javascript">
function editarElemento(registro) {
	window.location = "{BASE_URL}productos/edicion/clave/" + registro.Producto
}
</script>