<div class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="{BASE_URL}dashboard">{APP_NAME}</a>
    </div>
    <div class="navbar-collapse collapse navbar-responsive-collapse">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Seguridad <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}usuarios">Usuarios</a></li>
                    <li><a href="{BASE_URL}perfiles">Perfiles</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}clientes">Clientes</a></li>
                    <li><a href="{BASE_URL}proveedores">Proveedores</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}almacenes">Rutas</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}lineasproductos">Líneas de Productos</a></li>
                    <li><a href="{BASE_URL}productos">Productos</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}impuestos">Impuestos</a></li>
                    <li><a href="{BASE_URL}gastos">Gastos</a></li>
                    <li><a href="{BASE_URL}vendedores">Vendedores</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inventarios <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}almacenes/existencias">Existencias</a></li>
                    <li><a href="{BASE_URL}transferencias">Transferencias</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Operaciones <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}compras">Compras</a></li>
                    <li><a href="{BASE_URL}ventas">Ventas</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}devoluciones">Registrar devoluciones</a></li>
                    <li><a href="{BASE_URL}mermas">Registrar mermas</a></li>
                    <li><a href="{BASE_URL}gastosdia">Registrar gastos</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}planventas">Plan de ventas</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reportes <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}reportes/utilidades">Utilidades</a></li>
                    <li><a href="{BASE_URL}reportes/detalleventasvendedor">Detalle de Ventas por vendedor</a></li>
                    <li><a href="{BASE_URL}reportes/comisionesvendedor">Comisiones</a></li>
                </ul>
            </li>

			<li><a href="{BASE_URL}inicio/salir"><i class="fa fa-sign-out"></i> Salir</a></li>
        </ul>
    </div>
</div>