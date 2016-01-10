<?php
switch($_GET['code']){
	case 400:
		$title = "400 Error en petición";
		$description = "The request can not be processed due to bad syntax";
	break;

	case 401:
		$title = "401 Sin permisos";
		$description = "No tienes permisos para consultar la opción seleccionada";
	break;

	case 403:
		$title = "403 Prohibido";
		$description = "Se te ha negado la respuesta a esta sección";
	break;

	case 404:
		$title = "404 No encontrado";
		$description = "No se ha encontrado la sección solicitada";
	break;

	case 500:
		$title = "500 Error interno";
		$description = "Ocurrió un error desconocido";
	break;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><?php echo $title ?></title>
	 <!-- Bootstrap Table -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="panel panel-danger">
		<div class="panel-heading">
		<h3><?php echo $description ?></h3>
		</div>
	</div>
	<nav>
		<ul class="pager">
			<li class="previous"><a href="javascript:window.history.back()"><span aria-hidden="true">&larr;</span> Older</a></li>
		</ul>
	</nav>
</body>
</html>