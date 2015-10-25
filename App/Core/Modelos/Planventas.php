<?php
/**
 * Manejo de datos del plan de ventas
 */
class Modelos_Planventas extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos por su Id
	 * @param  string $id Id del registro
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT desde, hasta, monto
		FROM planVentas ";
		if(trim($id) != "")
			$where = " WHERE almacen = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo registro
	 * @param  array $data Datos del registro
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
		$query = "INSERT INTO planVentas
		SET
			monto = '{$data['monto']}',
			desde = $desde,
			hasta = $hasta";
		return $this->db->insert($query);
	}

	/**
	 * Elimina el registro
	 * @param  string $id Id del registro
	 * @return array
	 */
	public function del($id)
	{
		$query = "DELETE FROM planVentas
			WHERE planVenta = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			desde Desde, hasta Hasta, monto Monto
		FROM
			planVentas;";
		return $this->db->query($query);
	}

	public function planContraVentas()
	{
		$query = "SELECT SUM(det.subtotal) Ventas, pla.monto Plan, pla.desde Desde, pla.hasta Hasta
			FROM ventasProductos det
			INNER JOIN ventas vta USING (venta)
			INNER JOIN planVentas pla ON (vta.fecha between pla.desde AND pla.hasta)
			WHERE CURDATE() BETWEEN pla.desde AND pla.hasta
			GROUP BY pla.monto, pla.desde, pla.hasta;";
		return $this->db->query($query);
	}
}