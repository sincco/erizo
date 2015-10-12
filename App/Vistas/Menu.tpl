<div class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="{BASE_URL}">{APP_NAME}</a>
    </div>
    <div class="navbar-collapse collapse navbar-responsive-collapse">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}clientes">Clientes</a></li>
                    <li><a href="{BASE_URL}proveedores">Proveedores</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}almacenes">Almacenes</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="{BASE_URL}lineasproductos">Líneas de Productos</a></li>
                    <li><a href="{BASE_URL}productos">Productos</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inventarios <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="{BASE_URL}almacenes/existencias">Existencias</a></li>
                </ul>
            </li>

			<li><a href="{BASE_URL}inicio/salir"><i class="fa fa-sign-out"></i> Salir</a></li>
        </ul>
    </div>
</div>