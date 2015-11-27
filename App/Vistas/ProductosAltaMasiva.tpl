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
  <input type="hidden" id="almacen" value="{almacen}">

</div>

<script>
var
data = [],
grid = document.getElementById('gridProductos'), hot

$(function() {
  hot = new Handsontable(grid, {
    data: data,
    minSpareRows: 1,
    colHeaders: true,
    rowHeaders: true,
    fixedRowsTop: 0,
    colHeaders: ['Clave', 'Descripción', 'Descripción Corta', 'Categoria', 'Unidad', 'Grava Iva', 'Costo', 'Precio Venta', 'Mayorista 1', 'Mayorista 2', 'Detalle', 'Existencias'],
    columns: [
      {data:'clave'},
      {data:'descripcion'},
      {data:'descripcionCorta'},
      {data:'lineaProducto', type: 'dropdown', source: [{lineasProductos}]},
      {data:'unidadMedida', type: 'dropdown', source: ['NA','PZA','KG','TON','LT']},
      {data:'iva', type: 'dropdown', source: ['1','0']},
      {data:'costo'},
      {data:'precioVenta', format: '0,0.000', language: 'en'},
      {data:'precio2', format: '0,0.000', language: 'en'},
      {data:'precio3', format: '0,0.000', language: 'en'},
      {data:'precio4', format: '0,0.000', language: 'en'},
      {data:'existencias', format: '0,0.000', language: 'en'}
    ], 
    contextMenu: false
  })
})

function guardar() {
  var productos = hot.getData()
  $(productos).each(function( index ) {
    if(typeof(this.precioVenta) != "undefined" ) {
      if(this.iva == 1) {
        this.precioVenta = this.precioVenta / (1+($("#iva").val()/100))
      }
      if(parseInt($("#almacen").val()) > 0) {
        var producto = {
          clave:this.clave,
          descripcion:this.descripcion,
          descripcionCorta:this.descripcionCorta,
          lineaProducto:this.lineaProducto,
          unidadMedida:this.unidadMedida,
          iva:this.iva,
          costo:this.costo,
          precio:this.precioVenta,
          precio2:this.precio3,
          precio3:this.precio2,
          precio4:this.precio4,
          existencias:this.existencias,
          almacen:$("#almacen").val()
        }
      } else {
        var producto = {
          clave:this.clave,
          descripcion:this.descripcion,
          descripcionCorta:this.descripcionCorta,
          lineaProducto:this.lineaProducto,
          unidadMedida:this.unidadMedida,
          iva:this.iva,
          costo:this.costo,
          precio:this.precioVenta,
          precio2:this.precio3,
          precio3:this.precio2,
          precio4:this.precio4,
          existencias:this.existencias
        }
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