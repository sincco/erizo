<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <h3>Reporte de utlidades</h3>
  <form id="filtro">
    <div class="input-group input-daterange">
      <span class="input-group-addon">desde</span>
      <input type="text" class="form-control" value="" id="desde" data-date-format="yyyy-mm-dd">
      <span class="input-group-addon">hasta</span>
      <input type="text" class="form-control" value="" id="hasta" data-date-format="yyyy-mm-dd">
    </div>
  </form>
  <br>
  <p><a class="btn btn-primary btn-md" href="#" role="button" onclick="genera()"><span class="glyphicon glyphicon-print" aria-hidden="true"></span> Generar</a></p>
  <div class="row">
    <table id="reporte" data-mobile-responsive="true" data-show-export="true" data-page-size="25" data-pagination="true" data-show-pagination-switch="true"></table>
  </div>
</div>
<script type="text/javascript">
function genera() {
  sincco.consumirAPI('POST','{BASE_URL}reportes/utilidades/accion/csv/desde/' + $("#desde").val() + '/hasta/' + $("#hasta").val())
  .done(function(respuesta) {
    $("#reporte").bootstrapTable('destroy') 
    $('#reporte').bootstrapTable({
      columns:[
        {field:'fecha',title:'Fecha',sortable:true, visible:true},
        {field:'nombre',title:'Vendedor',sortable:false, visible:true},
        {field:'venta',title:'Venta',sortable:false, visible:true},
        {field:'gasto',title:'Gasto',sortable:false, visible:true},
        {field:'costo',title:'Costo',sortable:false, visible:true},
        {field:'utilidad',title:'Utilidad',sortable:false, visible:true},
        {field:'socio1',title:'Socio 1',sortable:false, visible:true},
        {field:'socio2',title:'Socio 2',sortable:false, visible:true},
        {field:'socio3',title:'Socio 3',sortable:false, visible:true},
        {field:'socio4',title:'Socio 4',sortable:false, visible:true}
      ],
      data:respuesta.respuesta
    }).fail(function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown)
    })
  })
}
$('.input-daterange input').each(function() {
    $(this).datepicker("clearDates");
});
</script>
<incluir archivo="Footer">