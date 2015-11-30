<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <h3>Cuentas por cobrar</h3>
  <div class="row">
    <form id="filtro">
      <div class="input-group input-daterange">
        <span class="input-group-addon">desde</span>
        <input type="text" class="form-control" value="" id="desde" data-date-format="yyyy-mm-dd">
        <span class="input-group-addon">hasta</span>
        <input type="text" class="form-control" value="" id="hasta" data-date-format="yyyy-mm-dd">
      </div>
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
  sincco.consumirAPI('POST','{BASE_URL}reportes/cxc/accion/csv/desde/' + $("#desde").val() + '/hasta/' + $("#hasta").val())
  .done(function(respuesta) {
    $("#reporte").bootstrapTable('destroy') 
    $('#reporte').bootstrapTable({
      columns:[
        {field:'fecha',title:'Fecha',sortable:true, visible:true},
        {field:'vigencia',title:'Vigencia',sortable:false, visible:true},
        {field:'razonSocial',title:'Cliente',sortable:false, visible:true},
        {field:'venta',title:'Monto',sortable:false, visible:true},
        {field:'saldo',title:'Saldo',sortable:false, visible:true},
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