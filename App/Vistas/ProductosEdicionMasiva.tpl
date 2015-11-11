<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Edicion masiva de productos</h3>

  <div class="row">
    <div class="col-sm-6">
      <label>Encuentra un producto</label>
      <input type="text" id="claveProducto" name="claveProducto" class="form-control" value="">
      <input type="hidden" id="iva" value="{iva}">
    </div>
  </div>

  <br>
  <div id="errores"></div>
  <div id="gridProductos" class="handsontable"></div>

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
data = {productos},
grid = document.getElementById('gridProductos'),
hot;

hot = new Handsontable(grid, {
  data: data,
  minSpareRows: 1,
  colHeaders: true,
  rowHeaders: true,
  fixedRowsTop: 0,
  startCols: 4,
  colHeaders: ['Clave', 'Descripcion', 'Descripcion Corta', 'Categoria', 'Unidad', 'Grava Iva', 'Costo', 'Precio', 'Precio Venta'],
  columns: [
    {data:'clave', readOnly: true},
    {data:'descripcion'},
    {data:'descripcionCorta'},
    {data:'lineaProducto', type: 'dropdown', source: [{lineasProductos}]},
    {data:'unidadMedida', type: 'dropdown', source: ['NA','PZA','KG','TON','LT']},
    {data:'iva', type: 'checkbox', checkedTemplate: '1', uncheckedTemplate: '0'},
    {data:'costo'},
    {data:'precioVenta', format: '0,0.00', language: 'en'}
  ], 
  contextMenu: true,
  afterChange: function (changes, source) {
    if ((source == 'edit' || source == 'paste')) {
      var registro = hot.getDataAtRow(changes[0][0])
      if(registro[5] == 1) {
        registro[7] = registro[7] / (1+($("#iva").val()/100))
      }
      var producto = {
        clave:registro[0],
        descripcion:registro[1],
        descripcionCorta:registro[2],
        lineaProducto:registro[3],
        unidadMedida:registro[4],
        iva:registro[5],
        costo:registro[6],
        precio:registro[7]
      }
      actualiza(producto)
    }
  }
})

function actualiza(producto) {
  sincco.consumirAPI('POST','{BASE_URL}productos/apiUpd', producto )
  .done(function(data) {
    console.log(data)
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log('Error',errorThrown)
  })
}
</script>

<incluir archivo="Footer">