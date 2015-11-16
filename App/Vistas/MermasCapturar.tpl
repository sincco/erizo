<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Capturar mermas del día</h3>
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
var productos = {productos}

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
    colHeaders: ['Motivo', 'Producto', 'Descripcion', 'Cantidad'],
    colWidths: [150,100, 350,75],
    columns: [
      {data:'motivo', type: 'dropdown', source: ['Robo', 'Degustacion', 'Caducidad', 'Daño']},
      {data:'producto'},
      {data:'descripcion'},
      {data:'cantidad', format: '0,0.00', language: 'en'}
    ], 
    contextMenu: false,
    afterChange: function (changes, source) {
      if ((source == 'edit' || source == 'paste')) {
        if(changes[0][1] == 'producto') {
          var producto = buscarJSON(productos, 'clave', changes[0][3])
          if(producto)
            hot.setDataAtCell(changes[0][0], 2, producto.descripcionCorta)
        }
      }
    }
  })
})

function buscarJSON(arreglo, elemento, valor) {
  var respuesta = false
  $(arreglo).each(function() {
    if(this[elemento] == valor) {
      respuesta = this
    }
  })
  return respuesta
}

function guardar() {
  var mermas = hot.getData()
  $(mermas).each(function( index ) {
    if(this[2]) {
      var devolucion = {
        vendedor:$("#vendedor").val(),
        motivo:this[0],
        producto:this[1],
        cantidad:this[3]
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
