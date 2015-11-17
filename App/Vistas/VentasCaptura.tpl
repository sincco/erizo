<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Punto de venta</h3>

  <div class="row">
    <div class="col-md-6">
      <label>Cliente</label>
      <select id="cliente" name="cliente" class="form-control">
        <ciclo clientes>
          <option value="{cliente}">{razonSocial}</option>
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
        <option value="" selected>Lista de precio 1</option>
        <option value="2">Lista de precio 2</option>
        <option value="3">Lista de precio 3</option>
        <option value="4">Lista de precio 4</option>
      </select>
    </div>
    <div class="col-md-6">
      <div class="alert alert-info" role="alert">Total: <span class="glyphicon glyphicon-usd" aria-hidden="true"></span><span id="totalVenta">0.00</span></div>
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
      <p><a class="btn btn-primary btn-md" href="#" onclick="cobrar()" role="button">Cobrar</a></p>
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
                <h4 id="titulo" class="modal-title">Pago</h4>
            </div>
            <div class="modal-body">
              <div id="errorCobro"></div>
              <label>Total a pagar</label>
              <input type="text" id="total" class="form-control" disabled="true">
              <label>En efectivo</label>
              <input type="text" name="efectivo" id="efectivo" class="form-control">
              <label>Con tarjeta</label>
              <input type="text" name="tarjeta" id="tarjeta" class="form-control">
              <label>A crédito</label>
              <input type="text" name="monedero" id="monedero" class="form-control">
              <div class="alert alert-info" role="alert">Cambio: <span class="glyphicon glyphicon-usd" aria-hidden="true"></span><span id="cambio">0.00</span></div>
              <hr>
              <p><a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button">Pago</a></p>
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

  $("#buscar").keypress(function(event) {
    if(event.which == 13) {
      $("#productos").bootstrapTable('destroy') 
      sincco.consumirAPI('POST','{BASE_URL}productos/apiDescripcion', {descripcion: $("#buscar").val()})
        .done(function(data) {
            console.log(data.respuesta)
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
  $("#efectivo").focusout(function(){ actualizaCambio() })
  $("#tarjeta").focusout(function(){ actualizaCambio() })
  $("#monedero").focusout(function(){ actualizaCambio() })
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
            if($("#lista").val() == "")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio)
            if($("#lista").val() == "2")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio2)
            if($("#lista").val() == "3")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio3)
            if($("#lista").val() == "4")
              hot.setDataAtCell(changes[0][0],3,data.respuesta[0].precio4)
            hot.setDataAtCell(changes[0][0],8,data.respuesta[0].iva)
            hot.setDataAtCell(changes[0][0],9,data.respuesta[0].ieps)
            hot.setDataAtCell(changes[0][0],10,data.respuesta[0].producto)
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
      actualizaTotal()
    }
  }
})

function actualizaCambio() {
  var total = parseFloat($('#efectivo').val()) + parseFloat($('#tarjeta').val()) + parseFloat($('#monedero').val())
  var cambio = total - parseFloat($('#total').val())
  cambio = (Math.round(cambio * 100) / 100)
  $("#cambio").html(cambio)
}

function actualizaTotal() {
  var totalVenta = 0
  hot.getData().forEach(function(element, index, array) {
    console.log(element)
    if(!isNaN(parseFloat(element.subtotal))) {
      totalVenta = totalVenta + parseFloat(element.subtotal)
    }
  })
  $('#totalVenta').html(Math.round(totalVenta * 100) /100)
  $('#total').val(Math.round(totalVenta * 100) /100)
  $('#efectivo').val(Math.round(totalVenta * 100) /100)
  $('#tarjeta').val('0.00')
  $('#monedero').val('0.00')
  $('#cambio').val('0.00')
  return true
}

function cobrar() {
  $('#myModal').modal('show')
  $('#efectivo').select()
  $('#efectivo').focus()
}

function guardar() {
  var total = parseFloat($('#efectivo').val()) + parseFloat($('#tarjeta').val()) + parseFloat($('#monedero').val()) - parseFloat($('#cambio').html())
  if(total !== parseFloat($('#total').val())) {
    $("#errorCobro").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>La suma de pagos no cubre el total</div>')
  } else {
    sincco.consumirAPI('POST','{BASE_URL}ventas/apiPost', {cliente: $("[name='cliente']").val(), vendedor: $("[name='vendedor']").val(), estatus: $("[name='estatus']").val(), pagos: {efectivo: $("#efectivo").val(), tarjeta: $("#tarjeta").val(), monedero: $("#monedero").val()}, productos: hot.getData()} )
    .done(function(data) {
      if(data.respuesta.venta) {
        limpiarDatos()
      }
      else
         $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Hubo un error al guardar los datos, intenta de nuevo</div>')
    }).fail(function(jqXHR, textStatus, errorThrown) {
      console.log('Error',errorThrown)
    })
  }
}

function limpiarDatos() {
  totalVenta = 0
  total = 0
  $("#efectivo").val('0.00')
  $("#tarjeta").val('0.00')
  $("#monedero").val('0.00')
  $("#cambio").html('0.00')
  $("#total").html('0.00')
  hot.loadData({})
  actualizaTotal()
  $('#myModal').modal('toggle')
  $("#claveProducto").focus()
}
</script>

<incluir archivo="Footer">