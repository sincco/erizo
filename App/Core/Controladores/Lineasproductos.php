<?php
/**
 * Operaciones con clientes
 */
class Controladores_Lineasproductos extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de clientes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloLineasproductos->grid();
		$this->vistaLineasProductos;
	}

	/**
	 * Muestra el formulario de captura de clientes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaLineasProductosAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloLineasproductos->post($data)));
	}
}