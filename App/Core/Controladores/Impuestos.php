<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Impuestos extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloImpuestos->grid();
		$this->vistaImpuestos;
	}

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaImpuestosAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloImpuestos->post($data)));
	}

}