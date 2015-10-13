<?php
/**
 * Control inicial
 */
class Controladores_Inicio extends Sfphp_Controlador
{
	/**
	 * Pantalla de inicio (login o inicio del sistema)
	 * @return none
	 */
	public function inicio()
	{
		$this->vistaLogin;
	}

	public function salir() {
		unset($_SESSION['acceso']);
		$this->inicio();
	}

	/**
	 * Hace el login de usuario
	 * @return json
	 */
	public function apiLogin()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		$respuesta = $this->modeloUsuarios->login($data);
		if(count($respuesta))
			$_SESSION['acceso'] = json_encode(array("respuesta"=>$respuesta));
		echo json_encode(array("respuesta"=>$respuesta));
	}
}