<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Compras extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->compras = $this->modeloCompras->grid();
		$this->vistaCompras;
	}

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaComprasCaptura;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPostSolicitud()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloCompras->solicitud($data)));
	}

	public function apiDetalleCompra()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloCompras->gridDetalle($data['compra'])));
	}

}