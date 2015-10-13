<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
	<h2>Tablero de información</h2>
	<div class="jumbotron">
		<div class="row">
			<h3>Ventas</h3>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Últimas ventas</h4>
				<ul class="list-group">
				<ciclo facturasRecientes>
					<li class="list-group-item list-group-item-success">
						{CVE_DOC} - {RFC} - ${IMPORTE}
					</li>
				</ciclo facturasRecientes>
				</ul>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Últimas ventas canceladas</h4>
				<ul class="list-group">
					<ciclo facturasCanceladas>
						<li class="list-group-item list-group-item-success list-group-item-warning">
							{CVE_DOC} - ${IMPORTE}
						</li>
					</ciclo facturasCanceladas>
				</ul>
			</div>
		</div>
		<div class="row">
			<h3>Resumen</h3>
			<div class="progress">
				<div class="progress-bar progress-bar" style="width: {VENTAS_FACTURADAS}%">
					{VENTAS_FACTURADAS}% Facturadas
				</div>
				<div class="progress-bar progress-bar-warning" style="width: {VENTAS_CANCELACIONES}%">
					{VENTAS_CANCELACIONES}% Canceladas
				</div>
				<div class="progress-bar progress-bar-info" style="width: {VENTAS_ENPROCESO}%">
					{VENTAS_ENPROCESO}% En proceso
				</div>
			</div>
		</div>
	</div>
	<div class="jumbotron">
		<div class="row">
			<h3>Inventarios</h3>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Baja existencia</h4>
				<div class="progress">
				<div class="progress-bar progress-bar" style="width: {PRODUCTOS_RESURTIR}%">
					<a href="{BASE_URL}productos/resurtir" style="color:#fff">{PRODUCTOS_RESURTIR}% Resurtir</a>
				</div>
			</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-12">
				<h4>Ultimas compras</h4>
				<ul class="list-group">
					<ul class="list-group">
					<ciclo comprasRecientes>
						<li class="list-group-item list-group-item-success list-group-item-warning">
							{CVE_DOC} - ${IMPORTE}
						</li>
					</ciclo comprasRecientes>
				</ul>
				</ul>
			</div>
		</div>
	</div>
</div>
<incluir archivo="Footer">