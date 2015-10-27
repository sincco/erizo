<incluir archivo="Header">
<header class="wow fadeInLeft">
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
            <form class="navbar-form navbar-left" id="acceso">
                <input type="text" class="form-control col-lg-8" placeholder="usuario" name="clave" id="usuario">
                <input type="password" class="form-control col-lg-8" placeholder="contraseña" name="password" id="password">
                <button type="button" class="btn btn-success" onclick="accesar()">entrar</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Soporte <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Olvidé mi contraseña</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Contactar a sincco</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</header>
<div class="container">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <img src="{BASE_URL}html/img/logo.jpg">
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12">
            <h1>{APP_NAME}</h1>
            <p class="lead">Debes tener una cuenta para accesar al sistema</p>
        </div>
    </div>
</div>
<script>
$(function(){
    $("#password").keypress(function(event) {
        if(event.which == 13) {
            accesar()
        }
    })

    $("#usuario").keypress(function(event) {
        if(event.which == 13) {
            accesar()
        }
    })
})

function accesar() {
    sincco.consumirAPI('POST','{BASE_URL}inicio/apiLogin',$("#acceso").serializeJSON())
    .done(function(data) {
        console.log(data)
        if(data.respuesta[0].usuario) {
            if(data.respuesta[0].vendedor)
                window.location = '{BASE_URL}ventas/pos'
            else
                window.location = '{BASE_URL}dashboard'
        }
    }).fail(function(jqXHR, textStatus, errorThrown) {
        console.log(errorThrown)
    })
}
</script>