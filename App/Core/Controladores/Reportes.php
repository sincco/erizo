<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Reportes extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio(){ }

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function utilidades()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['accion'])) {
			$data = $this->modeloReportes->utilidades($data['desde'],$data['hasta']);
			echo json_encode(array("respuesta"=>$data));
		} else {
			$this->vistaReporteUtilidades;
		}
	}

	public function detalleventasvendedor()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['accion'])) {
			$usuario = $this->modeloUsuarios->get($_SESSION['acceso']['usuario']);
			$this->_vista->usuario = $usuario[0]['nombre'];
			$this->_vista->detalle = $this->modeloReportes->detalleVentasVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$this->_vista->mermas = $this->modeloMermas->detalleVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$this->_vista->devoluciones = $this->modeloDevoluciones->detalleVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$vendedor = $this->modeloVendedores->get($this->_vista->detalle[0]['vendedor']);
			$this->_vista->vendedor = $vendedor[0]['nombre'];
			$this->_vista->ruta = $vendedor[0]['descripcion'];
			$this->_vista->comisiones = $this->modeloReportes->comisionesTotalesVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$this->_vista->gastos = $this->modeloGastosdia->detalleVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$this->_vista->totalGastos = $this->modeloGastosdia->totalVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			$this->vistaReporteDetalleVentasVendedorHTML;
		} else {
			$this->_vista->vendedores = $this->modeloVendedores->get();
			$this->vistaReporteDetalleVentasVendedor;
		}
	}

	public function comisionesvendedor()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['accion'])) {
			$data = $this->modeloReportes->comisionesVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			echo json_encode(array("respuesta"=>$data));
		} else {
			$this->_vista->vendedores = $this->modeloVendedores->get();
			$this->vistaReporteComisiones;
		}
	}

	public function ventaspagos()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['accion'])) {
			$data = $this->modeloReportes->ventasPagos($data['desde'],$data['hasta'],$data['tipo']);
			echo json_encode(array("respuesta"=>$data));
		} else {
			$this->vistaReporteVentasPagos;
		}
	}

	public function cxc()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['accion'])) {
			$data = $this->modeloReportes->ventasCreditos($data['desde'],$data['hasta']);
			echo json_encode(array("respuesta"=>$data));
		} else {
			$this->vistaReporteVentasCreditos;
		}
	}
}