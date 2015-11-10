<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Gastos extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloGastos->grid();
		$this->vistaGastos;
	}

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaGastosAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloGastos->post($data)));
	}

}