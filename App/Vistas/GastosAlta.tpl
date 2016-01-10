<incluir archivo="Header">
<menu>
<div class="container">
<h3>Alta de gastos</h3>
<form id="gastos">
	<label>Descripcion</label>
	<input type="text" class="form-control" name="descripcion" id="descripcion">
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
</div>
<script type="text/javascript">
function guardar() {
	sincco.consumirAPI('POST','{BASE_URL}gastos/apiPost',$("#gastos").serializeJSON())
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}gastos'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}

$(function(){
    $("#descripcion").keypress(function(event) {
        if(event.which == 13) {
            guardar()
        }
    })
})
</script>
<incluir archivo="Footer">