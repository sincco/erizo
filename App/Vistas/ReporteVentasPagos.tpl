<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <h3>Ventas por tipo de pago</h3>
  <div class="row">
    <form id="filtro">
      <div class="input-group input-daterange">
        <span class="input-group-addon">desde</span>
        <input type="text" class="form-control" value="" id="desde" data-date-format="yyyy-mm-dd">
        <span class="input-group-addon">hasta</span>
        <input type="text" class="form-control" value="" id="hasta" data-date-format="yyyy-mm-dd">
      </div>
      <label>Tipo</label>
        <select id="tipo" name="tipo" class="form-control">
          <option value="Efectivo">Efectivo</option>
          <option value="Tarjeta">Tarjeta</option>
          <option value="Crédito">Crédito</option>
        </select>
    </form>
  </div>
  <br>
  <p><a class="btn btn-primary btn-md" href="#" role="button" onclick="genera()"><span class="glyphicon glyphicon-print" aria-hidden="true"></span> Generar</a></p>
  <div class="row">
    <table id="reporte" data-mobile-responsive="true" data-show-export="true" data-page-size="25" data-pagination="true" data-show-pagination-switch="true"></table>
  </div>
</div>
<script type="text/javascript">
function genera() {
  sincco.consumirAPI('POST','{BASE_URL}reportes/ventaspagos/accion/csv/desde/' + $("#desde").val() + '/hasta/' + $("#hasta").val() + '/tipo/' + $("#tipo").val())
  .done(function(respuesta) {
    $("#reporte").bootstrapTable('destroy') 
    $('#reporte').bootstrapTable({
      columns:[
        {field:'fecha',title:'Fecha',sortable:true, visible:true},
        {field:'nombre',title:'Vendedor',sortable:false, visible:true},
        {field:'tipo',title:'Tipo',sortable:false, visible:true},
        {field:'monto',title:'Monto',sortable:false, visible:true},
        {field:'venta',title:'Total Venta',sortable:false, visible:true},
      ],
      data:respuesta.respuesta
    })
  }).fail(function(jqXHR, textStatus, errorThrown) {
     console.log(errorThrown)
  })
}
$('.input-daterange input').each(function() {
    $(this).datepicker("clearDates");
});
</script>
<incluir archivo="Footer">