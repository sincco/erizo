<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Reportes personalizados</h3>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<script type="text/javascript">
function editarElemento(registro) {
	console.log(registro)
	$.redirect('{BASE_URL}querys/ejecutar', {'id': registro.Query})
}
</script>
<incluir archivo="Footer">