<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Impuestos</h3>
	<p><a class="btn btn-primary btn-md" href="#" onclick="$('#modal').modal('show')" role="button">Agregar</a></p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>

<div id="modal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Detalle del impuesto</h4>
            </div>
            <div class="modal-body">
				<form id="impuestos">
					<label>Impuesto</label><br>
					<select id="impuesto" name="impuesto" class="form-control">
						<ciclo impuestosDefinicion>
						<option value="{impuesto}">{descripcion}</option>
						</ciclo impuestosDefinicion>
					</select>
					<label>Desde</label><br>
					<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="desde"><br>
					<label>Hasta (en blanco para evitar vigencia)</label><br>
					<input data-provide="datepicker" data-date-format="dd/mm/yyyy" name="hasta"><br>
					<label>Porcentaje</label><br>
					<input type="text" class="form-control" name="ivaPorcentaje"><br>
					<p><a class="btn btn-primary btn-md" href="#" onclick="save()" role="button">Guardar</a></p>
				</form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function save() {
	sincco.consumirAPI('POST','{BASE_URL}config/impuestos/api',$("#impuestos").serializeJSON())
	.done(function(data) {
		//if(data.respuesta)
		//	window.location.reload()
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>

<incluir archivo="Footer">