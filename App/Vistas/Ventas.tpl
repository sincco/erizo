<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Ventas</h3>
	<div class="btn-group">
		<a class="btn btn-primary btn-md" href="{BASE_URL}ventas/nuevo" role="button">Agregar</a>
		<button type="button" class="btn btn-primary dropdown-toggle btn-md" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<span class="caret"></span>
			<span class="sr-only">Toggle Dropdown</span>
		</button>
		<ul class="dropdown-menu">
			<li><a href="{BASE_URL}ventas/pos">POS</a></li>
		</ul>
	</div>
	<tabla datos="ventas" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>

<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Detalle</h4>
            </div>
            <div class="modal-body">
            	<div id="acciones"></div>
                <table id="detalle" data-show-columns="true" data-mobile-responsive="true" data-search="true" data-show-export="true" data-page-size="5" data-pagination="true" data-show-pagination-switch="true"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function editarElemento(fila) {
	sincco.consumirAPI('POST','{BASE_URL}ventas/apiDetalleVenta',{venta:fila.Venta})
	.done(function(respuesta) {
		if(fila.Estatus == "Solicitud") {
			$("#acciones").html("<a href='#'>Cotizar</a>")
		}
		$("#titulo").html("Detalle de venta "+fila.Venta + ' - ' + fila.Cliente)
		$("#detalle").bootstrapTable('destroy')	
		$('#detalle').bootstrapTable({
			columns:[
				{field:'clave',title:'Clave',sortable:true, visible:true},
				{field:'descripcionCorta',title:'Producto',sortable:false, visible:true},
				{field:'cantidad',title:'Cantidad',sortable:false, visible:true},
				{field:'precio',title:'Precio',sortable:false, visible:true},
				{field:'iva',title:'IVA',sortable:false, visible:true},
				{field:'ieps',title:'IEPS',sortable:false, visible:true},
				{field:'subtotal',title:'Subtotal',sortable:false, visible:true}	
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
