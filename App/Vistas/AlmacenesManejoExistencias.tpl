<incluir archivo="Header">
  <menu>
<div class="container">
	<h3>Existencia en rutas</h3>
	<select id="almacen" class="form-control">
		<option value="0">Selecciona una ruta</option>
		<ciclo almacenes>
			<option value="{almacen}">{descripcion}</option>
		</ciclo almacenes>
	</select>
  <br><p><a class="btn btn-primary btn-md" href="{BASE_URL}almacenes/existencias" role="button">Terminar</a></p><br>
  <div id="errores"></div>
	<div id="grid_movements" class="handsontable"></div>
</div>
<script>
$(function() {
  var result = document.location.pathname.split('/')
  $("#almacen").val(result[4])
  $("#almacen").trigger("change")
})

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
  colHeaders: ['Id','Clave', 'Descripcion', 'Existencias', 'Costo'],
  columns: [
    {data:'almacenProducto',readOnly: true},
    {data:'clave'},
    {data:'descripcionCorta',readOnly: true},
    {data:'existencias', type: 'numeric', format: '0,0.000', language: 'en'},
    {data:'costo', type: 'numeric', format: '$0,0.000', language: 'en'},
  ], 
  contextMenu: true,
  afterChange: function (changes, source) {
    if(parseInt($("#almacen").val()) > 0) {
      if ((source == 'edit' || source == 'paste')) {
        if(changes[0][1] == "clave") {
          sincco.consumirAPI('POST','{BASE_URL}productos/apiClave/clave/'+changes[0][3])
          .done(function(data) {
            if(data.respuesta.length) {
              hot.setDataAtCell(changes[0][0],2,data.respuesta[0].descripcionCorta)
            } else {
              hot.setDataAtCell(changes[0][0],2,'NO EXISTE, REVISA')
            }
          }).fail(function(jqXHR, textStatus, errorThrown) {
            console.log(errorThrown)
          })
        }
        if(changes[0][1] == "existencias") {
          var fila = hot.getDataAtRow(changes[0][0])
          var data = {
            almacen:$("#almacen").val(),
            id:parseInt(fila[0]), clave:fila[1],
            existencias:fila[3], costo:fila[4],
          }
          if(typeof data.costo == "undefined") {
            hot.setDataAtCell(changes[0][0],4, 1)
            data.costo = 1
          }
          sincco.consumirAPI('POST','{BASE_URL}almacenes/apiPostExistencia',data)
          .done(function(data) {
            if(parseInt(data.respuesta) > 0) {
              hot.setDataAtCell(changes[0][0],0, data.respuesta)
              $("#errores").html('<div class="alert alert-success" role="alert">Guardado</div>')
            } else {
              $("#errores").html('<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><span class="sr-only">Error:</span>No se pudo guardar tu cambio, edita de nuevo la existencia</div>')
            }
          }).fail(function(jqXHR, textStatus, errorThrown) {
            console.log(errorThrown)
          })
        }
      }
    } else {
      $("#errores").html('<div class="alert alert-danger" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><span class="sr-only">Error:</span>Selecciona un almacen</div>')
    }
  }
})

$("#almacen").change(function() {
	sincco.consumirAPI('POST','{BASE_URL}almacenes/apiHot/almacen/'+$("#almacen").val())
	.done(function(data) {
    $("#errores").html('')
		hot.loadData(data.respuesta)
	}).fail(function(jqXHR, textStatus, errorThrown) {
		$("#errores").html('<div class="alert alert-warning" role="alert"><span class="sr-only">Error:</span>No se pudieron cargar los datos de este almacen, intenta de nuevo</div>')
	})
})
</script>
<incluir archivo="Footer">