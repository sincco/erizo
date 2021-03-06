<incluir archivo="Header">
<incluir archivo="Menu">

<div class="container">
	<h3>Editar de Cliente</h3>
	<ciclo clientes>
		<div class="bs-example">
		    <ul class="nav nav-tabs" id="tabs">
		        <li><a data-toggle="tab" href="#generales">Generales</a></li>
		        <li><a data-toggle="tab" href="#direcciones">Direcciones</a></li>
		        <li><a data-toggle="tab" href="#contactos">Contactos</a></li>
		    </ul>
		    <div class="tab-content">
		        <div id="generales" class="tab-pane fade in active">
		            <h5>Datos generales</h5>
		            <form id="clientesGenerales">
		            	<input type="hidden" name="cliente" value="{cliente}">
						<label>Razón Social</label>
						<input type="text" class="form-control" name="razonSocial" value="{razonSocial}">
						<label>RFC</label>
						<input type="text" class="form-control" name="rfc" value="{rfc}">
						<label>Dirección Fiscal</label>
						<input type="text" class="form-control" name="direccionFiscal" value="{direccionFiscal}">
						<label>Días de Cŕedito</label>
						<input type="text" class="form-control" name="diasCredito" value="{diasCredito}">
		            </form>
		        </div>
		        <div id="direcciones" class="tab-pane fade">
		            <h5>Direcciones</h5>
		            <form id="clientesDirecciones">
						<label>Alias</label>
						<input type="hidden" name="clienteDireccion" value="{clienteDireccion}">
						<input type="text" class="form-control" name="alias" value="{alias}">
						<label>Domicilio</label>
						<input type="text" class="form-control" name="domicilio" value="{domicilio}">
						<label>Telefono</label>
						<input type="text" class="form-control" name="telefono" value="{telefono}">
		            </form>
		        </div>
		        <div id="contactos" class="tab-pane fade">
		            <h5>Contactos</h5>
		            <form id="clientesContactos">
						<label>Nombre</label>
						<input type="hidden" class="form-control" name="clienteContacto" value="{clienteContacto}">
						<input type="text" class="form-control" name="nombre" value="{nombre}">
						<label>Correo</label>
						<input type="text" class="form-control" name="correo" value="{correo}">
						<label>Telefono</label>
						<input type="text" class="form-control" name="telefono" value="{telefono}">
		            </form>
		        </div>
		    </div>
		    <br>
		    <p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardarCliente()">Guardar</a> <a class="btn btn-danger btn-md" href="#" role="button" onclick="borrarCliente()">Borrar</a></p>
		</div>
	</ciclo clientes>
</div>
<script type="text/javascript">
$(document).ready(function(){ 
	$("#tabs li:eq(0) a").tab('show')
})

function guardarCliente() {
	var cliente = {cliente:$("#clientesGenerales").serializeJSON(), direcciones:$("#clientesDirecciones").serializeJSON(), contactos:$("#clientesContactos").serializeJSON()}
	sincco.consumirAPI('POST','{BASE_URL}clientes/apiPost',cliente)
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}clientes'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})	
}

function borrarCliente() {
	var cliente = {cliente:$("#clientesGenerales").serializeJSON(), direcciones:$("#clientesDirecciones").serializeJSON(), contactos:$("#clientesContactos").serializeJSON()}
	sincco.consumirAPI('POST','{BASE_URL}clientes/apiDel',cliente)
	.done(function(data) {
		if(data.respuesta)
			window.location = '{BASE_URL}clientes'
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})	
}
</script>
<incluir archivo="Footer">