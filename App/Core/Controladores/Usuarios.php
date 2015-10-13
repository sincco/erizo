<?php
/**
 * Operaciones con usuarios
 */
class Controladores_Usuarios extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de usuarios
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloUsuarios->grid();
		$this->vistaUsuarios;
	}

	/**
	 * Muestra el formulario de captura de usuarios
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaUsuariosAlta;
	}

	/**
	 * Llamada AJAX para insertar usuario
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloUsuarios->post($data)));
	}
}