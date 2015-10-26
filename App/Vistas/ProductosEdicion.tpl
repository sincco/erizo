<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
<h3>Editar producto</h3>
<div id="errores"></div>
<form id="productos">
	<ciclo producto>
		<label>Clave</label>
		<input type="text" class="form-control" name="clave1" disabled value="{clave}">
		<input type="hidden" class="form-control" name="clave" value="{clave}">
		<label>Descripcion</label>
		<input type="text" class="form-control" name="descripcion" value="{descripcion}">
		<label>Descripcion Corta</label>
		<input type="text" class="form-control" name="descripcionCorta" value="{descripcionCorta}">
		<label>Precio</label>
		<input type="text" class="form-control" name="precio" value="{precio}">
	</ciclo producto>
</form>
<br>
<p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="guardar()">Guardar</a> <a class="btn btn-danger btn-lg" href="#" role="button" onclick="dasactivar()">Borrar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}productos/apiActualizar',$("#productos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}productos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}

function dasactivar() {
	sincco.consumirAPI('POST','{BASE_URL}productos/apiDesactivar',$("#productos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}productos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">