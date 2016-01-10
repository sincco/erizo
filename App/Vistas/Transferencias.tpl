<incluir archivo="Header">
<menu>
<div class="container">
	<h3>Transferencias entre almacenes</h3>
	<p><a class="btn btn-primary btn-md" href="{BASE_URL}transferencias/captura" role="button">Agregar</a></p>
	<tabla datos="catalogo" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>

<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Detalle</h4>
            </div>
            <div class="modal-body">
                <table id="detalle" data-show-columns="true" data-mobile-responsive="true" data-search="true" data-show-export="true" data-page-size="5" data-pagination="true" data-show-pagination-switch="true"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function editarElemento(fila) {
	sincco.consumirAPI('POST','{BASE_URL}transferencias/apiConsulta',{id:fila.ID})
	.done(function(respuesta) {
		console.log(respuesta)
		$("#titulo").html("Detalle de transferencia "+fila.ID)
		$("#detalle").bootstrapTable('destroy')	
		$('#detalle').bootstrapTable({
			columns:[
				{field:'fecha',title:'Fecha',sortable:true, visible:true},
				{field:'almacenOrigen',title:'Origen',sortable:true, visible:true},
				{field:'almacenDestino',title:'Destino',sortable:true, visible:true},
				{field:'clave',title:'Clave',sortable:true, visible:true},
				{field:'descripcionCorta',title:'Producto',sortable:false, visible:true},
				{field:'cantidad',title:'Cantidad',sortable:false, visible:true}
			],
			data:respuesta.respuesta
		})
		$('#myModal').modal('show')
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
}
</script>
<incluir archivo="Footer">