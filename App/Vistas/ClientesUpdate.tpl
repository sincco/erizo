<incluir archivo="Header">
<incluir archivo="Menu">
<h3>Edicion de Clientes</h3>
<div class="container">
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
					<label>Razón Social</label>
					<input type="text" class="form-control" name="razonSocial">
					<label>RFC</label>
					<input type="text" class="form-control" name="rfc">
					<label>Dirección Fiscal</label>
					<input type="text" class="form-control" name="direccionFiscal">
	            </form>
	        </div>
	        <div id="direcciones" class="tab-pane fade">
	            <h5>Direcciones</h5>
	            <div class="list-group">
					<a href="#" class="list-group-item">
					Direccion 1
					</a>
					<a href="#" class="list-group-item">
					Direccion 2
					</a>
				</div>
	            <form id="clientesDirecciones">
					<label>Alias</label>
					<input type="text" class="form-control" name="alias">
					<label>Domicilio</label>
					<input type="text" class="form-control" name="domicilio">
					<label>Telefono</label>
					<input type="text" class="form-control" name="telefono">
	            </form>
	        </div>
	        <div id="contactos" class="tab-pane fade">
	            <h5>Contactos</h5>
	            <div class="list-group">
					<a href="#" class="list-group-item">
					Contacto 1
					</a>
					<a href="#" class="list-group-item">
					Contacto 2
					</a>
				</div>
	            <form id="clientesContactos">
					<label>Nombre</label>
					<input type="text" class="form-control" name="nombre">
					<label>Correo</label>
					<input type="text" class="form-control" name="correo">
					<label>Telefono</label>
					<input type="text" class="form-control" name="telefono">
	            </form>
	        </div>
	    </div>
	    <br>
	    <p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="guardarCliente()">Guardar</a></p>
	</div>
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
</script>
<incluir archivo="Footer">