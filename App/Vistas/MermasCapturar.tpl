<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Capturar muestras del día</h3>
  <label>Vendedor</label>
  <select id="vendedor" name="vendedor" class="form-control">
    <ciclo vendedores>
      <option value="{vendedor}">{nombre}</option>
    </ciclo vendedores>
  </select><br>
  <span id="boton">
    <a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Guardar</a>
  </span>
  <br><br>
  <div id="errores"></div>
  <div id="gridMermas" class="handsontable"></div>
</div>

<script>
var
data = [],
grid = document.getElementById('gridMermas'), hot

$(function() {
  hot = new Handsontable(grid, {
    data: data,
    minSpareRows: 1,
    colHeaders: true,
    rowHeaders: true,
    fixedRowsTop: 0,
    colHeaders: ['Producto', 'Cantidad'],
    colWidths: [350,75],
    columns: [
      {data:'producto', type: 'dropdown', source: [{productos}]},
      {data:'cantidad', format: '0,0.00', language: 'en'}
    ], 
    contextMenu: false
  })
})

function guardar() {
  var mermas = hot.getData()
  $(mermas).each(function( index ) {
    if(this[1]) {
      var devolucion = {
        vendedor:$("#vendedor").val(),
        motivo:'Degustacion',
        producto:this[0],
        cantidad:this[1]
      }
      sincco.consumirAPI('POST','{BASE_URL}mermas/apiPost', devolucion )
      .done(function(data) {
        if(data.respuesta)
          salir = 1
      }).fail(function(jqXHR, textStatus, errorThrown) {
        console.log('Error',errorThrown)
      })
    }
  })
  $("#boton").html('<a class="btn btn-success btn-md" href="{BASE_URL}mermas" role="button">Regresar</a>')
}
</script>

<incluir archivo="Footer">
