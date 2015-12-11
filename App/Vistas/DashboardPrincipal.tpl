<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h2>Tablero de información</h2>
	<div class="jumbotron">
		<div class="row">
			<h3>Plan de ventas</h3>
			<div id="planVentas" style="width: 100%"></div>
		</div>
	</div>

	<div class="jumbotron">
		<div class="row">
			<h3>Ventas</h3>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Últimas ventas</h4>
				<ul class="list-group">
				<ciclo ventasRecientes>
					<li class="list-group-item list-group-item-success" onclick="window.location='{BASE_URL}ventas'">
						{Fecha} - {Cliente} - ${Monto}
					</li>
				</ciclo ventasRecientes>
				</ul>
			</div>
		</div>
	</div>

	<div class="jumbotron">
		<div class="row">
			<h3>Gastos</h3>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Últimos gastos</h4>
				<ul class="list-group">
				<ciclo gastosRecientes>
					<li class="list-group-item list-group-item-success" onclick="window.location='{BASE_URL}gastosdia'">
						{fecha} - {descripcion} - {monto}
					</li>
				</ciclo gastosRecientes>
				</ul>
			</div>
		</div>
	</div>

	<div class="jumbotron">
		<div class="row">
			<h3>Productos</h3>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Los más vendidos</h4>
				<div id="productosPopulares" style="width: 100%"></div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]})
    google.setOnLoadCallback(chartPlanVentas)
    function chartPlanVentas() {
		var data = google.visualization.arrayToDataTable([
		["", "Monto", { role: "style" } ],
		["Plan", {montoPlan}, "#ff851b"],
		["Ventas", {montoVentas}, "#28b62c"]
		])

		var view = new google.visualization.DataView(data)
		view.setColumns([0, 1,
		               { calc: "stringify",
		                 sourceColumn: 1,
		                 type: "string",
		                 role: "annotation" },
		               2])

		var options = {
		title: "Cumplimiento de plan de ventas de {planDesde} a {planHasta}",
		bar: {groupWidth: "95%"},
		legend: { position: "none" },
		}
		var chart = new google.visualization.ColumnChart(document.getElementById("planVentas"))
		chart.draw(view, options)
  	}

  	google.setOnLoadCallback(chartProductosPopulares)
    function chartProductosPopulares() {
		var data = google.visualization.arrayToDataTable([
		["Producto", "Pedidos", { role: "style" } ],
		<ciclo masVendidos>
			["{descripcionCorta}", {ventas}, "#0066FF"],
		</ciclo masVendidos>
		])

		var view = new google.visualization.DataView(data)
		view.setColumns([0, 1,
		               { calc: "stringify",
		                 sourceColumn: 1,
		                 type: "string",
		                 role: "annotation" },
		               2])

		var options = {
		title: "Productos más pedidos",
		bar: {groupWidth: "95%"},
		legend: { position: "none" },
		}
		var chart = new google.visualization.ColumnChart(document.getElementById("productosPopulares"))
		chart.draw(view, options)
  	}

  	$(window).resize(function(){
		chartPlanVentas()
		chartProductosPopulares()
	})

  </script>

<incluir archivo="Footer">