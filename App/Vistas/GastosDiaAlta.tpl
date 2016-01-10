<incluir archivo="Header">
  <menu>
<div class="container">
	<h3>Registro de gastos</h3>
  <div class="row">
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
    <div class="col-lg-6 col-md-6 col-sm-12">
      <h5>Gastos</h5>
      <ul id="recetas" class="recetas ruta list-group"></ul>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-12">
      <ul id="productos" class="productos ruta list-group">
      <ciclo gastos>
        <li class="list-group-item" data-clave="{gasto}" data-descr="{descripcion}">
          {descripcion}
        </li>
      </ciclo gastos>
      </ul>
    </div>
  </div>

  <div class="row">
    <p><a class="btn btn-primary btn-md" href="#" role="button" onclick="guardar()">Guardar</a></p>
  </div>
</div>


<script type="text/javascript">
$(function () {
  Sortable.create(productos, {
    group: "conceptos",
    onAdd: function (evt) {
      var itemEl = evt.item
      var clave = $(itemEl).attr('data-clave')
      $("[name=cantidad_" + clave + "]").remove()
    }
  })
  Sortable.create(recetas, { 
    group: "conceptos", 
    onAdd: function (evt) {
      var itemEl = evt.item
      var clave = $(itemEl).attr('data-clave')
      var costo = parseFloat($(itemEl).attr('data-costo'))
      $(itemEl).html($(itemEl).html() + '<input type="text" name="cantidad_' + clave + '" class="form-control cantidad" placeholder="cantidad" data-clave="' + clave + '" />')
      $("[name=cantidad_" + clave + "]").focus()
    }
  })
})

function guardar() {
  var detalles = []
  $("[name^='cantidad_']").each(function() {
    detalle = new Object()
    detalle.gasto = $(this).attr('data-clave')
    detalle.monto = $(this).val()
    detalle.vendedor = $("#vendedor").val()
    detalles.push(detalle)
  })
  sincco.consumirAPI('POST','{BASE_URL}gastosdia/apiPost',{vendedor:$("#vendedor").val(), detalle:detalles })
  .done(function(data) {
    if(data.respuesta > 0)
      window.location = '{BASE_URL}gastosdia'
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown)
  })
}
</script>

<incluir archivo="Footer">