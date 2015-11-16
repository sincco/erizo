<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <h3>Detalle de ventas por vendedor</h3>
  <div class="row">
    <form id="filtro">
      <div class="input-group input-daterange">
        <span class="input-group-addon">desde</span>
        <input type="text" class="form-control" value="" id="desde" data-date-format="yyyy-mm-dd">
        <span class="input-group-addon">hasta</span>
        <input type="text" class="form-control" value="" id="hasta" data-date-format="yyyy-mm-dd">
      </div>
      <label>Vendedor</label>
        <select id="vendedor" name="vendedor" class="form-control">
          <ciclo vendedores>
            <option value="{vendedor}">{nombre}</option>
          </ciclo vendedores>
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
  $.redirect('{BASE_URL}reportes/detalleventasvendedor', {accion: 'csv', desde:$("#desde").val(), hasta:$("#hasta").val(), vendedor: $("#vendedor").val()},'POST','_blank')
}
$('.input-daterange input').each(function() {
    $(this).datepicker("clearDates");
});
</script>
<incluir archivo="Footer">