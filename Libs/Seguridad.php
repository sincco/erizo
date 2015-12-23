<?php
/**
 * Control de seguridad.
 * Esta clase y método se invocan automaticamente antes de lanzar
 * cualquier control/accion en el sistema, por lo que es el lugar donde
 * se deben realizar todas las validaciones para el acceso al sistema
 */
class Seguridad extends Sfphp_Seguridad
{
	public function validarAcceso($controlador = "", $accion = "") {
		if($controlador != "Inicio" & $controlador != "Cotizaciones" & $accion != "formatopublico") {
			if(isset($_SESSION['acceso'])) {
				$_accesos = $_SESSION['acceso'];
				$_accesos = json_decode($_accesos['permisos'], TRUE);
				foreach ($_accesos as $_acceso) {
					if(1 == count(explode("/", $_acceso['url']))) {
						$_acceso['url'] .= "/inicio";
					}
					if("" == trim($accion))
						$accion = "inicio";
				//Si la ruta solicitada está dentro de los permisos del perfil, implica que el usuario
				//no tiene permisos para consultarla
					if(strtolower($controlador."/".$accion) == strtolower($_acceso['url']))
						return FALSE;
					else
						return TRUE;
				}
			} else 
				return FALSE;
		} else {
			return TRUE;
		}
	}
}