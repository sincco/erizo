<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <h3>Reporte de utlidades</h3>
  <form id="filtro">
    <label>Desde</label><br>
    <input data-provide="datepicker" data-date-format="yyyy-mm-dd" name="desde" id="desde"><br>
    <label>Hasta</label><br>
    <input data-provide="datepicker" data-date-format="yyyy-mm-dd" name="hasta" id="hasta"><br>
  </form>
  <br>
  <p><a class="btn btn-primary btn-md" href="#" role="button" onclick="genera()">Generar</a></p>
</div>
<iframe id="frame" style="width:0px;height:0px;border:0px;"></iframe>
<script type="text/javascript">
function genera() {
  console.log('generar')
  $("#frame").attr('src','{BASE_URL}reportes/utilidades/accion/csv/desde/' + $("#desde").val() + '/hasta/' + $("#hasta").val())
}
</script>
<incluir archivo="Footer">