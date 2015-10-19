<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Detalle de transferencia</h3>
	<label>Fecha</label>
	<input type="text" value="{fecha}"><br>
	<label>Almacen Origen</label>
	<input type="text" value="{almacenOrigen}"><br>
	<label>Almacen Destino</label>
	<input type="text" value="{almacenDestino}"><br>
	<tabla datos="transferencia" pagina="10" exportar="true" buscar="true" clic="editarElemento">
</div>
<incluir archivo="Footer">