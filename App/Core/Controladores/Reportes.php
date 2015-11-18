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
			$data = $this->modeloReportes->detalleVentasVendedor($data['desde'],$data['hasta'],$data['vendedor']);
			echo json_encode(array("respuesta"=>$data));
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
}