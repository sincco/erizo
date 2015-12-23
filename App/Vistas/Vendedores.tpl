<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Vendedores</h3>
	<p><a class="btn btn-primary btn-md" href="{BASE_URL}vendedores/nuevo" role="button">Agregar</a></p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>

<script type="text/javascript">
function editarElemento(registro) {
	console.log(registro)
	$.redirect('{BASE_URL}vendedores/editar', {'vendedor': registro.Vendedor})
}
</script>

<incluir archivo="Footer">