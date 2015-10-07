<?php
/**
 * Operaciones con Proveedores
 */
class Controladores_Proveedores extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de Proveedores
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloProveedores->grid();
		$this->vistaProveedores;
	}

	/**
	 * Muestra el formulario de captura de Proveedores
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaProveedoresAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloProveedores->post($data)));
	}
}