<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Dashboard extends Sfphp_Controlador
{
	/**
	 * Muestra el tablero principal de información
	 * @return none
	 */
	public function inicio()
	{
		$plan = $this->modeloPlanventas->planContraVentas();
		$this->_vista->ventasRecientes = $this->modeloVentas->ventasRecientes();
		$this->_vista->documentosRecientes = $this->modeloVentasdocumentos->documentosRecientes();
		$this->_vista->gastosRecientes = $this->modeloGastosdia->recientes();
		$plan = $this->modeloPlanventas->planContraVentas();
		$this->_vista->montoPlan = $plan[0]['Plan'];
		$this->_vista->montoVentas = $plan[0]['Ventas'];
		$this->_vista->planDesde = $plan[0]['Desde'];
		$this->_vista->planHasta = $plan[0]['Hasta'];
		$this->_vista->masVendidos = $this->modeloProductos->masVendidos();
		$this->vistaDashboardPrincipal;
	}

}