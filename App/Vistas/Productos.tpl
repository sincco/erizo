<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Productos</h3>
	<p><a class="btn btn-primary btn-lg" href="{BASE_URL}productos/nuevo" role="button">Agregar</a></p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">

<script type="text/javascript">
function editarElemento(registro) {
	window.location = "{BASE_URL}productos/edicion/clave/" + registro.Producto
}
</script>