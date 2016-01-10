<incluir archivo="Header">
  <menu>
<div class="container">
	<h3>Transferencia entre almacenes</h3>
  <label>Almacén Origen</label>
	<select id="almacenOrigen" class="form-control">
		<option value="0">Selecciona un almacen</option>
		<ciclo almacenes>
			<option value="{almacen}">{descripcion}</option>
		</ciclo almacenes>
	</select><br>
  <label>Almacén Destino</label>
  <select id="almacenDestino" class="form-control">
    <option value="0">Selecciona un almacen</option>
    <ciclo almacenes>
      <option value="{almacen}">{descripcion}</option>
    </ciclo almacenes>
  </select><br>
  <p><a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button">Guardar</a></p><br>
  <div id="errores"></div>
	<div id="grid_movements" class="handsontable"></div>
</div>
<script>
var
data = [],
grid = document.getElementById('grid_movements'),
hot;

hot = new Handsontable(grid, {
  data: data,
  minSpareRows: 1,
  colHeaders: true,
  rowHeaders: true,
  fixedRowsTop: 0,
  colHeaders: ['Clave', 'Descripcion', 'Existencias', 'Unidad', 'Cantidad a transferir'],
  columns: [
    {data:'clave'},
    {data:'descripcionCorta',readOnly: true},
    {data:'existencias', type: 'numeric', format: '0,0.00', language: 'en', readOnly:true},
    {data:'unidad', readOnly: true},
    {data:'cantidad', type: 'numeric', format: '0,0.00', language: 'en'},
  ], 
  contextMenu: true,
  afterChange: function (changes, source) {
    if(parseInt($("#almacenOrigen").val()) > 0 & parseInt($("#almacenDestino").val()) > 0) {
      $("#almacenOrigen").prop('disabled', true)
      $("#almacenDestino").prop('disabled', true)
      if ((source == 'edit' || source == 'paste')) {
        if(changes[0][1] == "clave") {
          sincco.consumirAPI('POST','{BASE_URL}transferencias/apiProductoExistencia/clave/'+changes[0][3]+'/almacen/'+$("#almacenOrigen").val())
          .done(function(data) {
            if(data.respuesta.length) {
              $("#errores").html('')
              hot.setDataAtCell(changes[0][0],1,data.respuesta[0].descripcionCorta)
              hot.setDataAtCell(changes[0][0],2,data.respuesta[0].existencias)
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].unidadMedida)
            } else {
              hot.setDataAtCell(changes[0][0],1,'SIN EXISTENCIAS EN EL AMACEN')
              hot.setDataAtCell(changes[0][0],2,0)
              hot.setDataAtCell(changes[0][0],3,'')
            }
          }).fail(function(jqXHR, textStatus, errorThrown) {
            console.log(errorThrown)
          })
        }
      }
      if(changes[0][1] == "cantidad") {
        if(parseFloat(changes[0][3]) > parseFloat(hot.getDataAtCell(changes[0][0], 2))) {
          hot.setDataAtCell(changes[0][0],4,0)
          $("#errores").html('<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><span class="sr-only">Error:</span>No puedes ttransferir más de lo que dispones</div>')
        } else {
          if(parseFloat(changes[0][3]) > 1)
          $("#errores").html('')
        }
      }
    } else {
      $("#errores").html('<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><span class="sr-only">Error:</span>Selecciona los almacenes de la Transferencia</div>')
    }
  }
})

function guardar() {
  sincco.consumirAPI('POST','{BASE_URL}transferencias/apiPost/origen/'+$("#almacenOrigen").val()+'/destino/'+$("#almacenDestino").val(), hot.getData())
  .done(function(data) {
    window.location = '{BASE_URL}transferencias'
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown)
  })
}

</script>
<incluir archivo="Footer">