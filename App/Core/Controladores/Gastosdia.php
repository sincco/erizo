<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Gastosdia extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloGastosdia->grid();
		$this->vistaGastosDia;
	}

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function nuevo()
	{
		$this->_vista->vendedores = $this->modeloVendedores->get();
		$this->_vista->gastos = $this->modeloGastos->get();
		$this->vistaGastosDiaAlta;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloGastosdia->post($data)));
	}

}