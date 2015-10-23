<?php
/**
 * Operaciones con ventas
 */
class Controladores_Ventas extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de ventas
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->ventas = $this->modeloVentas->grid();
		$this->vistaVentas;
	}

	/**
	 * Muestra el formulario de captura de ventas
	 * @return none
	 */
	public function nuevo()
	{
		$impuestos = $this->modeloImpuestos->getActual();
		$this->_vista->ivaPorcentaje = $impuestos[0]['ivaPorcentaje'];
		$this->_vista->iepsPorcentaje = $impuestos[0]['iepsPorcentaje'];
		$this->_vista->clientes = $this->modeloClientes->get();
		$this->_vista->vendedores = $this->modeloVendedores->get();
		$this->vistaVentasCaptura;
	}

	/**
	 * Llamada AJAX para insertar venta
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		var_dump($data);
		#echo json_encode(array("respuesta"=>$this->modeloVentas->post($data)));
	}

	/**
	 * Regresa el grid con el detalle de venta
	 * @return json
	 */
	public function apiDetalleVenta()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloVentas->gridDetalle($data['venta'])));
	}

	/**
	 * Muestra la pantalla del POS
	 * @return none
	 */
	public function pos()
	{
		$acceso = Sfphp_Sesion::get('acceso');
		$impuestos = $this->modeloImpuestos->getActual();
		$this->_vista->ivaPorcentaje = $impuestos[0]['ivaPorcentaje'];
		$this->_vista->iepsPorcentaje = $impuestos[0]['iepsPorcentaje'];
		$this->_vista->clientes = $this->modeloClientes->get();
		$this->_vista->vendedor = $acceso['vendedor'];
		$this->vistaPOS;
	}

}