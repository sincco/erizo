<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Gastos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT gasto, descripcion
		FROM gastos ";
		if(trim($id) != "")
			$where = " WHERE gasto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo almacen
	 * @param  array $data Datos del almacen
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO gastos
		SET
			descripcion = '{$data['descripcion']}';";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function del($id)
	{
		$query = "DELETE FROM gastos
		WHERE gasto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			gasto Gasto, descripcion Descripcion
		FROM
			gastos;";
		return $this->db->query($query);
	}
}