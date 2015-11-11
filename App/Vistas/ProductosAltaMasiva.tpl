<incluir archivo="Header">
  <incluir archivo="Menu">
<div class="container">
  <h3>Alta masiva de productos</h3>
  <span id="boton">
    <a class="btn btn-primary btn-md" href="#" onclick="guardar()" role="button"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> Guardar</a>
  </span>
  <br><br>
  <div id="errores"></div>
  <div id="gridProductos" class="handsontable"></div>
  <input type="hidden" id="iva" value="{iva}">

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
    {data:'clave'},
    {data:'descripcion'},
    {data:'descripcionCorta'},
    {data:'lineaProducto', type: 'dropdown', source: [{lineasProductos}]},
    {data:'unidadMedida', type: 'dropdown', source: ['NA','PZA','KG','TON','LT']},
    {data:'iva', type: 'dropdown', source: ['1','0']},
    {data:'costo'},
    {data:'precioVenta', format: '0,0.00', language: 'en'}
  ], 
  contextMenu: true
})

function guardar() {
  var productos = hot.getData()
  $(productos).each(function( index ) {
    if(typeof(this.precioVenta) != "undefined" ) {
      if(this.iva == 1) {
        this.precioVenta = this.precioVenta / (1+($("#iva").val()/100))
      }
      var producto = {
        clave:this.clave,
        descripcion:this.descripcion,
        descripcionCorta:this.descripcionCorta,
        lineaProducto:this.lineaProducto,
        unidadMedida:this.unidadMedida,
        iva:this.iva,
        costo:this.costo,
        precio:this.precioVenta
      }
      sincco.consumirAPI('POST','{BASE_URL}productos/apiPost', producto )
      .done(function(data) {
        if(data.respuesta)
          salir = 1
      }).fail(function(jqXHR, textStatus, errorThrown) {
        console.log('Error',errorThrown)
      })
    }
  })
  $("#boton").html('<a class="btn btn-success btn-md" href="{BASE_URL}productos" role="button">Regresar</a>')
}
</script>

<incluir archivo="Footer">