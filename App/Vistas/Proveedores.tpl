<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Proveedores</h3>
	<p><a class="btn btn-primary btn-md" href="{BASE_URL}proveedores/nuevo" role="button">Agregar</a></p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<script type="text/javascript">
function editarElemento(registro) {
	$.redirect('{BASE_URL}proveedores/editar', {'clave': registro.Clave})
}
</script>
<incluir archivo="Footer">