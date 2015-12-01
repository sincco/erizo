<?php
/**
 * Operaciones con ventas
 */
class Controladores_Cotizaciones extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de ventas
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->cotizaciones = $this->modeloVentas->grid("Cotización");
		$this->vistaCotizaciones;
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
		$this->vistaCotizacionesCaptura;
	}

	/**
	 * Llamada AJAX para insertar venta
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		echo json_encode(array("respuesta"=>$this->modeloVentas->postCotizacion($data)));
	}

	/**
	 * Regresa el grid con el detalle de venta
	 * @return json
	 */
	public function apiDetalleVenta()
	{
		$data = Sfphp_Peticion::get('_parametros');
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

	public function formato()
	{
		$_total = 0;
		$_iva = 0;
		$this->_vista->cabecera = array();
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->cotizacion = $this->modeloVentas->getDetalle($data['id']);
		$this->_vista->cabecera[0] = $this->_vista->cotizacion[0];
		foreach ($this->_vista->cotizacion as $registro) {
			$_total += floatval(str_replace(",", "", $registro['subtotal']));
			$_iva += floatval(str_replace(",", "", $registro['iva']));
		}
		$this->_vista->total = number_format($_total,3);
		$this->_vista->iva = number_format($_iva,3);
		$this->_vista->url = BASE_URL."cotizaciones/formato/id/{$data['id']}";
		$this->vistaCotizacionesFormato;
	}

	public function formatopublico()
	{
		$_total = 0;
		$_iva = 0;
		$this->_vista->cabecera = array();
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->cotizacion = $this->modeloVentas->getDetalle(base64_decode($data['id']));
		$this->_vista->cabecera[0] = $this->_vista->cotizacion[0];
		foreach ($this->_vista->cotizacion as $registro) {
			$_total += floatval(str_replace(",", "", $registro['subtotal']));
			$_iva += floatval(str_replace(",", "", $registro['iva']));
		}
		$this->_vista->total = number_format($_total,3);
		$this->_vista->iva = number_format($_iva,3);
		$this->_vista->url = BASE_URL."cotizaciones/formatopublico/id/".$data['id'];
		$this->vistaCotizacionesFormato;
	}

	public function enviar()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$html = Curl::getWebPage(BASE_URL."cotizaciones/formatopublico/id/".base64_encode($data['id']));
		echo ElasticEmail::send($data['correo'], "Cotización", "", $html, "contacto@nats.com.mx", "Nats S.A. de C.V.");
	}

}