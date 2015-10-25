<?php
/**
 * Operaciones con Planventas
 */
class Controladores_Planventas extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo del Plan de Ventas
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloPlanventas->grid();
		$this->vistaPlanVentas;
	}

	/**
	 * Muestra el formulario de captura del Plan de Ventas
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaPlanVentasAlta;
	}

	/**
	 * Llamada AJAX para insertar el plan de ventas
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloPlanventas->post($data)));
	}
}