<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Nueva venta</h3>
  <label>Cliente</label>
	<select id="cliente" name="cliente" class="form-control">
    <ciclo clientes>
      <option value="{cliente}">{razonSocial}</option>
    </ciclo clientes>
  </select><br>
  <label>Vendedor</label>
  <select id="vendedor" name="vendedor" class="form-control">
    <option value="0">Selecciona un vendedor</option>
    <ciclo vendedores>
      <option value="{vendedor}">{nombre}</option>
    </ciclo vendedores>
  </select><br>
  <label>Estatus de la venta</label>
  <select id="estatus" name="estatus" class="form-control">
    <option value="Cotizacion">Cotización</option>
    <option value="En Proceso">En Proceso</option>
    <option value="Pago">Finalizada</option>
    <option value="Cancelada">Cencelada</option>
  </select><br>
  <p><a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button">Guardar</a></p><br>
  <input type="hidden" value="{ivaPorcentaje}" id="ivaPorcentaje">
  <input type="hidden" value="{iepsPorcentaje}" id="iepsPorcentaje">

  <div id="errores"></div>
	<div id="gridVenta" class="handsontable"></div>

</div>

<script>
var
data = [],
grid = document.getElementById('gridVenta'),
hot;

hot = new Handsontable(grid, {
  data: data,
  minSpareRows: 1,
  colHeaders: true,
  rowHeaders: true,
  fixedRowsTop: 0,
  startCols: 4,
  colHeaders: ['Clave', 'Descripcion', 'Unidad', 'Precio', 'Cantidad', 'IVA', 'IEPS', 'Subtotal', 'Grava IVA', 'Grava IEPS', 'Producto'],
  columns: [
    {data:'clave'},
    {data:'descripcionCorta',readOnly: true},
    {data:'unidad', readOnly: true},
    {data:'precio', type: 'numeric', format: '0,0.00', language: 'en', readOnly: true},
    {data:'cantidad', type: 'numeric', format: '0,0.00', language: 'en'},
    {data:'iva', type: 'numeric', format: '0,0.00', language: 'en', readOnly: true},
    {data:'ieps', type: 'numeric', format: '0,0.00', language: 'en', readOnly: true},
    {data:'subtotal', type: 'numeric', format: '0,0.00', language: 'en', readOnly: true},
    {data:'gravaIVA', readOnly: true},
    {data:'gravaIEPS', readOnly: true},
    {data:'producto', readOnly: true},
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
            hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio)
            hot.setDataAtCell(changes[0][0],8,data.respuesta[0].iva)
            hot.setDataAtCell(changes[0][0],9,data.respuesta[0].ieps)
            hot.setDataAtCell(changes[0][0],10,data.respuesta[0].producto)
          } else {
            hot.setDataAtCell(changes[0][0],1,'NO EXISTE')
          }
        }).fail(function(jqXHR, textStatus, errorThrown) {
          console.log(errorThrown)
        })
      }
      if(changes[0][1] == "cantidad") {
        var subtotal = parseFloat(hot.getDataAtCell(changes[0][0],4))*parseFloat(hot.getDataAtCell(changes[0][0],3))
        var iva = parseInt(hot.getDataAtCell(changes[0][0],8)) * (parseInt($("#ivaPorcentaje").val())/100)
        iva = subtotal * iva
        ieps = subtotal * ieps
        var ieps = parseInt(hot.getDataAtCell(changes[0][0],9)) * (parseInt($("#iepsPorcentaje").val())/100)
        hot.setDataAtCell(changes[0][0],5, iva)
        hot.setDataAtCell(changes[0][0],6, ieps)
        hot.setDataAtCell(changes[0][0],7, subtotal + iva + ieps)
      }
      $('#gridVenta td:nth-child(10),th:nth-child(10)').hide()
      $('#gridVenta td:nth-child(11),th:nth-child(11)').hide()
      $('#gridVenta td:nth-child(12),th:nth-child(12)').hide()
    }
  }
})

function guardar() {
  if(parseInt($("#vendedor").val()) == 0) {
    $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Selecciona al vendedor</div>')
    return
  }
  if(parseInt($("#estatus").val()) == 0) {
    $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Selecciona el estatus</div>')
    return
  }
  sincco.consumirAPI('POST','{BASE_URL}ventas/apiPost', {cliente: $("[name='cliente']").val(), vendedor: $("[name='vendedor']").val(), estatus: $("[name='estatus']").val(), productos: hot.getData()} )
  .done(function(data) {
    if(data.respuesta.venta)
      window.location = '{BASE_URL}ventas'
    else
       $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Hubo un error al guardar los datos, intenta de nuevo</div>')
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown)
  })
}
</script>

<incluir archivo="Footer">