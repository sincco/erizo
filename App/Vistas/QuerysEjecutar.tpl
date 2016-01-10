<incluir archivo="Header">
<menu>
<div class="container">
<ciclo query>
<h3>{descripcion}</h3>
</ciclo query>
<form id="query">
	{filtros}
</form>
<br>
<p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardarLinea()">Guardar</a></p>
</div>
<script type="text/javascript">
$(function() {
	$('.input-daterange input').each(function() {
		$(this).datepicker();
	})
})
var productos = {jsonProductos}
</script>
<incluir archivo="Footer">