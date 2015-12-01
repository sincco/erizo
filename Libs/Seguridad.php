<?php
/**
 * Control de seguridad.
 * Esta clase y método se invocan automaticamente antes de lanzar
 * cualquier control/accion en el sistema, por lo que es el lugar donde
 * se deben realizar todas las validaciones para el acceso al sistema
 */
class Seguridad extends Sfphp_Seguridad
{
	public function validarAcceso($controlador = "", $modelo = "") {
		if($controlador != "Inicio" & $controlador != "Cotizaciones" & $modelo != "formatopublico") {
			if(isset($_SESSION['acceso']))
				return TRUE;
		} else {
			return TRUE;
		}
	}
}