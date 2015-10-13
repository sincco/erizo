<?php
/**
 * Operaciones con almacenes
 */
class Seguridad extends Sfphp_Seguridad
{
	public function validarAcceso($controlador = "", $modelo = "") {
		if($controlador != "Inicio") {
			if(isset($_SESSION['acceso']))
				return TRUE;
		} else {
			return TRUE;
		}
	}
}