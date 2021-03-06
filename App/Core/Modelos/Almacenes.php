<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Almacenes extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT almacen, descripcion, activo, principal
		FROM almacenes ";
		if(trim($id) != "")
			$where = " WHERE almacen = {$id};";
		return $this->db->query($query.$where);
	}

	public function getPrincipal()
	{
		$query = "SELECT almacen, descripcion, activo
		FROM almacenes 
		WHERE principal = 1;";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo almacen
	 * @param  array $data Datos del almacen
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO almacenes
		SET
			descripcion = '{$data['descripcion']}',
			principal = '{$data['principal']}',
			activo = 1;";
		return $this->db->insert($query);
	}

	public function upd($data)
	{
		$query = "UPDATE almacenes
		SET
			descripcion = '{$data['descripcion']}',
			principal = '{$data['principal']}'
		WHERE almacen = '{$data['almacen']}';";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function del($id)
	{
		$query = "UPDATE almacenes
		SET activo = 0 
		WHERE lineaProducto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			almacen Almacen, descripcion Descripcion, activo Activo
		FROM
			almacenes;";
		return $this->db->query($query);
	}
}
