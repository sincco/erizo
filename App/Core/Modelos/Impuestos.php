<?php
/**
 * Manejo de datos de impuestos
 */
class Modelos_Impuestos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos del impuesto aplicable a la fecha
	 * @return array
	 */
	public function getActual()
	{
		$query = "SELECT ivaPorcentaje, iepsPorcentaje
		FROM impuestos
		WHERE CURDATE() >= desde AND (CURDATE() <= hasta OR hasta IS NULL);";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo impuesto
	 * @param  array $data Datos del impuesto
	 * @return array
	 */
	public function post($data)
	{
		$desde = DateTime::createFromFormat("d/m/Y",$data['desde']);
		$desde = "'".$desde->format('Y-m-d')."'";
		if(strlen(trim($data['hasta']))) {
			$hasta = DateTime::createFromFormat("d/m/Y",$data['hasta']);
			$hasta = "'".$hasta->format('Y-m-d')."'";
		}
		else $hasta = "NULL";
		$query = "INSERT INTO impuestos
		SET
			ivaPorcentaje = '{$data['ivaPorcentaje']}',
			iepsPorcentaje = '{$data['iepsPorcentaje']}',
			desde = $desde,
			hasta = $hasta";
		return $this->db->insert($query);
	}

	/**
	 * Devuelve todos los impuestos para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			desde Desde, hasta Hasta, ivaPorcentaje IVA, iepsPorcentaje IEPS
		FROM
			impuestos;";
		return $this->db->query($query);
	}
}