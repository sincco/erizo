<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Existencias</h3>
	<select id="almacen">
		<option value="0">Selecciona</option>
		<ciclo almacenes>
			<option value="{almacen}">{descripcion}</option>
		</ciclo almacenes>
	</select>
	<div id="grid_movements" class="handsontable"></div>
    <div id="errores"></div>
</div>
<script>
var
data = [],
grid = document.getElementById('grid_movements'),
hot;

hot = new Handsontable(grid, {
data: data,
minSpareRows: 1,
colHeaders: true,
rowHeaders: true,
fixedRowsTop: 0,
colHeaders: ['Clave', 'Descripcion', 'Existencias', 'Costo'],
columns: [
  {data:'clave'},
  {data:'descripcion',readOnly: true},
  {data:'existencias', type: 'numeric', format: '$0,0.00', language: 'en'},
  {data:'costo', type: 'numeric', format: '$0,0.00', language: 'en'},
], 
contextMenu: true,
afterChange: function (changes, source) {
  if ((source == 'edit' || source == 'paste')) {
  //Escucha de cambios
    var fila = hot.getDataAtRow(changes[0][0])
    if(fila[0]) { //Si el registro ya tiene un ID, se actualiza el camhio de la cuenta contable
      if(fila[1]) {
        $.ajax({
          type: "POST",
          url: "php/productos.php",
          data: {
            "clave":fila[0],
            "descripcion":fila[1],
            "existencias":fila[2],
            "costo":fila[3]
          },
          success: function (data) {
            //console.log(data)
          },
          error: function (xhr) {
            console.log(xhr)
          }
        })
      }
    }
  }
}
})

$("#almacen").change(function() {
	sincco.consumirAPI('POST','{BASE_URL}almacenes/hot')
	.done(function(data) {
		hot.data(data)
	}).fail(function(jqXHR, textStatus, errorThrown) {
		console.log(errorThrown)
	})
})
</script>
<incluir archivo="Footer">