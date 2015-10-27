<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
	<h3>Solicitud de compra</h3>
  <label>Descripción</label>
	<input type="text" name="descripcionCorta" value=""><br>
  <p><a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button">Guardar</a></p><br>
  <div id="errores"></div>
	<div id="gridCompra" class="handsontable"></div>
</div>
<script>
var
data = [],
grid = document.getElementById('gridCompra'),
hot;

hot = new Handsontable(grid, {
  data: data,
  minSpareRows: 1,
  colHeaders: true,
  rowHeaders: true,
  fixedRowsTop: 0,
  colHeaders: ['Clave', 'Descripcion', 'Unidad', 'Cantidad'],
  columns: [
    {data:'clave'},
    {data:'descripcionCorta',readOnly: true},
    {data:'unidad', readOnly: true},
    {data:'cantidad', type: 'numeric', format: '0,0.00', language: 'en'},
  ], 
  contextMenu: true,
  afterChange: function (changes, source) {
    if ((source == 'edit' || source == 'paste')) {
      if(changes[0][1] == "clave") {
        sincco.consumirAPI('POST','{BASE_URL}productos/apiClave', {clave: changes[0][3]})
        .done(function(data) {
          if(data.respuesta.length) {
            $("#errores").html('')
            hot.setDataAtCell(changes[0][0],1,data.respuesta[0].descripcionCorta)
            hot.setDataAtCell(changes[0][0],2,data.respuesta[0].unidadMedida)
          } else {
            hot.setDataAtCell(changes[0][0],1,'NO EXISTE')
          }
        }).fail(function(jqXHR, textStatus, errorThrown) {
          console.log(errorThrown)
        })
      }
    }
  }
})

function guardar() {
  sincco.consumirAPI('POST','{BASE_URL}compras/apiPostSolicitud', {descripcionCorta: $("[name='descripcionCorta']").val(), productos: hot.getData()} )
  .done(function(data) {
    if(data.respuesta.solicitud)
      window.location = '{BASE_URL}compras'
    else
       $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Hubo un error al guardar los datos, intenta de nuevo</div>')
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown)
  })
}

</script>
<incluir archivo="Footer">