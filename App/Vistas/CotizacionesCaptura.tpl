<incluir archivo="Header">
  <menu>
<div class="container">
  <h3>Cotizar</h3>

  <div class="row">
    <div class="col-md-6">
      <label>Cliente</label>
      <select id="cliente" name="cliente" class="form-control">
        <option value="0" correo="contacto@nats.com.mx">Selecciona uno</option>
        <ciclo clientes>
          <option value="{cliente}" correo="{correo}">{razonSocial}</option>
        </ciclo clientes>
      </select>
    </div>
    <div class="col-md-6">
      <label>Vendedor</label>
      <select id="vendedor" name="vendedor" class="form-control">
        <ciclo vendedores>
          <option value="{vendedor}">{nombre}</option>
        </ciclo vendedores>
      </select>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <label>Lista de precios</label>
      <select id="lista" name="lista" class="form-control">
        <option value="" selected>Precio</option>
        <option value="2">Mayorista 1</option>
        <option value="3">Mayorista 2</option>
        <option value="4">Detalle</option>
      </select>
    </div>
    <div class="col-md-6">
      <div class="alert alert-info" role="alert">Total: <span class="glyphicon glyphicon-usd" aria-hidden="true"></span><span id="totalVenta">0.000</span></div>
    </div>
  </div>

  <input type="hidden" id="vendedor" name="vendedor" class="form-control" value="{vendedor}">
  <input type="hidden" id="estatus" name="estatus" class="form-control" value="Pago"><br>
  <input type="hidden" value="{ivaPorcentaje}" id="ivaPorcentaje">
  <input type="hidden" value="{iepsPorcentaje}" id="iepsPorcentaje">

  <div class="row">
    <div class="col-sm-6">
      <label>Captura / Escanea el producto</label>
      <input type="text" id="claveProducto" name="claveProducto" class="form-control" value="">
    </div>
    <div class="col-sm-6">
      <p><span id="guardar"><a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button">Guardar</a></span><span id="notificar"></span></p>
    </div>
  </div>

  <br>
  <div id="errores"></div>
  <div id="gridVenta" class="handsontable"></div>

</div>

<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Notificar al cliente</h4>
            </div>
            <div class="modal-body">
              <div id="errorCobro"></div>
              <label>Correo</label>
              <input type="text" id="correo" class="form-control">
              <input type="hidden" id="venta" class="form-control" disabled="true">
              <p><a class="btn btn-success btn-md" href="#" onclick="enviar()" role="button">Enviar</a><a class="btn btn-info btn-md" href="#" onclick="window.location = '{BASE_URL}cotizaciones'" role="button">Regresar</a></p>
            </div>
        </div>
    </div>
</div>

<div id="buscarProducto" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 id="titulo" class="modal-title">Buscar producto</h4>
            </div>
            <div class="modal-body">
              <label>Por descripcion</label>
              <input type="text" name="buscar" id="buscar" class="form-control">
              <table id="productos"></table>
            </div>
        </div>
    </div>
</div>

<script>
$(function() {
  $("#claveProducto").keypress(function(event) {
    if(event.which == 13) {
      if(hot.getDataAtCell(hot.countRows()-2,1) == 'NO EXISTE')
        hot.setDataAtCell(hot.countRows()-2,0,$(this).val())
      else
        hot.setDataAtCell(hot.countRows()-1,0,$(this).val())
      $(this).val('')
      $(this).focus()
    }
  })

  $("#cliente").change(function(event) {
    $("#cliente option:selected" ).each(function() {
       $("#correo").val($(this).attr("correo"))
    })
  })

  $("#buscar").keypress(function(event) {
    if(event.which == 13) {
      $("#productos").bootstrapTable('destroy') 
      sincco.consumirAPI('POST','{BASE_URL}productos/apiDescripcion', {descripcion: $("#buscar").val()})
        .done(function(data) {
            $('#productos').bootstrapTable({
              data: data.respuesta,
              columns: [{
                field: 'clave',
                title: 'Clave'
              }, {
                field: 'descripcionCorta',
                title: 'Descripcion'
              },  {
                field: 'precio',
                title: 'Precio'
              }, ]
            })
        })
    }
  })

  $("#productos").on("click-row.bs.table", function (e, row, $element) {
    $("#claveProducto").val(row.clave)
    $("#claveProducto").focus()
    $("#buscarProducto").modal('hide')
  })

  $("#claveProducto").keydown(function(event) {
    if(event.keyCode == 113) {
      $("#buscar").val('')
      $("#productos").bootstrapTable('destroy') 
      $('#buscarProducto').modal('show')
      $('#buscar').focus()
      $('#buscar').select()
      $('#buscar').focus()
    }
  })
})

$("#claveProducto").focus()

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
  colHeaders: ['Clave', 'Descripcion', 'Unidad', 'Precio', 'Cantidad', 'Subtotal', 'Grava IVA', 'Grava IEPS', 'Producto'],
  columns: [
    {data:'clave'},
    {data:'descripcionCorta',readOnly: true},
    {data:'unidad', readOnly: true},
    {data:'precio', type: 'numeric', format: '0,0.000', language: 'en', readOnly: true},
    {data:'cantidad', type: 'numeric', format: '0,0.000', language: 'en'},
    {data:'subtotal', type: 'numeric', format: '0,0.000', language: 'en', readOnly: true},
    {data:'gravaIVA', readOnly: true},
    {data:'gravaIEPS', readOnly: true},
    {data:'producto', readOnly: true},
    {data:'iva', readOnly: true},
    {data:'ieps', readOnly: true},
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
            if($("#lista").val() == "")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio)
            if($("#lista").val() == "2")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio2)
            if($("#lista").val() == "3")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio3)
            if($("#lista").val() == "4")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio4)
            hot.setDataAtCell(changes[0][0],8,data.respuesta[0].producto)
            hot.setDataAtCell(changes[0][0],7,data.respuesta[0].ieps)
            hot.setDataAtCell(changes[0][0],6,data.respuesta[0].iva)
            hot.setDataAtCell(changes[0][0],4,1)
          } else {
            hot.setDataAtCell(changes[0][0],1,'NO EXISTE')
          }
        }).fail(function(jqXHR, textStatus, errorThrown) {
          console.log(errorThrown)
        })
      }
      if(changes[0][1] == "cantidad") {
        var subtotal = parseFloat(hot.getDataAtCell(changes[0][0],4))*parseFloat(hot.getDataAtCell(changes[0][0],3))
        var iva = parseInt(hot.getDataAtCell(changes[0][0],6)) * (parseInt($("#ivaPorcentaje").val())/100)
        iva = subtotal * iva
        ieps = subtotal * ieps
        var ieps = parseInt(hot.getDataAtCell(changes[0][0],7)) * (parseInt($("#iepsPorcentaje").val())/100)
        hot.setDataAtCell(changes[0][0],9, iva)
        hot.setDataAtCell(changes[0][0],10, ieps)
        hot.setDataAtCell(changes[0][0],5, subtotal + iva + ieps)
      }
      $('#gridVenta td:nth-child(6),th:nth-child(6)').hide()
      $('#gridVenta td:nth-child(7),th:nth-child(7)').hide()
      $('#gridVenta td:nth-child(8),th:nth-child(8)').hide()
      $('#gridVenta td:nth-child(9),th:nth-child(9)').hide()
      $('#gridVenta td:nth-child(10),th:nth-child(10)').hide()
      $('#gridVenta td:nth-child(11),th:nth-child(11)').hide()
      $('#gridVenta td:nth-child(12),th:nth-child(12)').hide()
      actualizaTotal()
    }
  }
})

function actualizaTotal() {
  var totalVenta = 0
  hot.getData().forEach(function(element, index, array) {
    if(!isNaN(parseFloat(element.subtotal))) {
      totalVenta = totalVenta + parseFloat(element.subtotal)
    }
  })
  $('#totalVenta').html(Math.round(totalVenta * 100) /100)
  $('#total').val(Math.round(totalVenta * 100) /100)
  $('#efectivo').val(Math.round(totalVenta * 100) /100)
  $('#tarjeta').val('0.000')
  $('#monedero').val('0.000')
  $('#cambio').val('0.000')
  return true
}

function notificar() {
  $('#myModal').modal('show')
}

function guardar() {
  loader.show()
  sincco.consumirAPI('POST','{BASE_URL}cotizaciones/apiPost', {cliente: $("[name='cliente']").val(), vendedor: $("[name='vendedor']").val(), estatus: $("[name='estatus']").val(), pagos: {efectivo: parseFloat($("#efectivo").val()) - parseFloat($("#cambio").html()), tarjeta: $("#tarjeta").val(), monedero: $("#monedero").val()}, productos: hot.getData()} )
  .done(function(data) {
    if(data.respuesta.venta) {
      $("#venta").val(data.respuesta.venta)
      $("#guardar").html(" ")
      $("#notificar").html('&nbsp;<a class="btn btn-success btn-md" href="#" onclick="notificar()" role="button">Notificar</a>')
      loader.hide()
    }
    else{
       $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Hubo un error al guardar los datos, intenta de nuevo</div>')
       loader.hide()
     }
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log('Error',errorThrown)
    loader.hide()
  })
}

function enviar() {
  loader.show()
  sincco.consumirAPI('POST','{BASE_URL}cotizaciones/enviar', { id: $("#venta").val(), correo: $("#correo").val() } )
  .done(function(data) {
    loader.hide()
    msgModal.show('info','Correo enviado')
  }).fail(function(jqXHR, textStatus, errorThrown) {
    loader.hide()
    console.log('Error',errorThrown)
  })
}

</script>

<incluir archivo="Footer">