<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Capturar mermas del día</h3>
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
    colHeaders: ['Motivo', 'Producto', 'Cantidad'],
    colWidths: [150,350,75],
    columns: [
      {data:'motivo', type: 'dropdown', source: ['Robo', 'Degustacion', 'Caducidad', 'Daño']},
      {data:'producto', type: 'dropdown', source: [{productos}]},
      {data:'cantidad', format: '0,0.00', language: 'en'}
    ], 
    contextMenu: false
  })
})

function guardar() {
  var mermas = hot.getData()
  $(mermas).each(function( index ) {
    console.log(this)
    if(this[2]) {
      var devolucion = {
        motivo:this[0],
        producto:this[1],
        cantidad:this[2]
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