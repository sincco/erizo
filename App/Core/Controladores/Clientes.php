<?php
/**
 * Operaciones con clientes
 */
class Controladores_Clientes extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de clientes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloClientes->grid();
		$this->vistaClientes;
	}

	/**
	 * Muestra el formulario de captura de clientes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaClientesAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloClientes->post($data)));
	}
}