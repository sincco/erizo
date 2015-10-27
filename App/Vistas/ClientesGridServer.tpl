<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h3>Clientes</h3>
	<p><a class="btn btn-primary btn-md" href="{BASE_URL}clientes/nuevo" role="button">Agregar</a></p>


<table data-toggle="table" data-url="{BASE_URL}clientes/apiGrid" data-show-columns="true" data-mobile-responsive="true"
					data-search="true" data-show-export="true" data-page-size="10" data-pagination="true" data-show-pagination-switch="true">
<thead>
<tr>
<th data-field="Clave" data-align="right">Clave</th>
<th data-field="Razon Social" data-align="right">Razón Social</th>
<th data-field="RFC" data-align="right">RFC</th>
<th data-field="Domicilio Fiscal" data-align="right">Domicilio</th>
</tr>
</thead>
</table>

</div>
<incluir archivo="Footer">