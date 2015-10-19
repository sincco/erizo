<?php
/**
 * Operaciones con Transferencias
 */
class Controladores_Transferencias extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de Transferencias
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloTransferencias->grid();
		$this->vistaTransferencias;
	}

	/**
	 * Muestra el formulario de captura de Transferencias
	 * @return none
	 */
	public function captura()
	{
		$this->_vista->almacenes = $this->modeloAlmacenes->get();
		$this->vistaTransferenciasCaptura;
	}

	/**
	 * Muestra el detalle de uns transferencia entre almacenes
	 * @return none
	 */
	public function apiConsulta()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		#$this->_vista->transferencia = $this->modeloTransferencias->getDetalle($data['id']);
		#$this->vistaTransferenciasDetalle;
		echo json_encode(array("respuesta"=>$this->modeloTransferencias->getDetalle($data['id'])));
	}

	/**
	 * Llamada AJAX para hacer transferencia
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloTransferencias->post($data)));
	}

	/**
	 * Llamada AJAX para regresar la existencia de un producto en almacen
	 * @return json
	 */
	public function apiProductoExistencia()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenesproductos->getByClaveAlmacen($data['clave'],$data['almacen'])));
	}
}