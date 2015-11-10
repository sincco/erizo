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
		if($data['accion'] == 'csv') {
			$data = $this->modeloReportes->utilidades($data['desde'],$data['hasta']);
			$salida = array("Fecha,Venta,Gastos,Costos,Utilidad");
			foreach ($data as $registro) {
				$utilidad = doubleval($registro['venta'])-doubleval($registro['gasto'])-doubleval($registro['costo']);
				array_push($salida, implode(",",$registro).",".$utilidad);
			}
			header('Content-Disposition: attachment; filename="utilidades.csv";');
			echo implode("\n",$salida);
		} else {
			$this->vistaReporteUtilidades;
		}
	}
}