<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Lineasproductos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de una linea de producto
	 * @param  string $id Id de la linea a consultar
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "
		SELECT lineaProducto, descripcion, activo
		FROM lineasProductos ";
		if(trim($id) != "")
			$where = " WHERE lineaProducto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta una nueva linea de producto
	 * @param  array $data Datos de la linea
	 * @return array
	 */
	public function post($data)
	{
		$query = "
		INSERT INTO lineasProductos
		SET
			descripcion = '{$data['descripcion']}',
			activo = 1;";
		return $this->db->insert($query);
	}

	/**
	 * Elimina una linea de producto
	 * @param  string $id Id del cliente
	 * @return array
	 */
	public function del($id)
	{
		$query = "
		UPDATE lineasProductos
		SET activo = 0 
		WHERE lineaProducto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los clientes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "
		SELECT 
			lineaProducto Linea, descripcion Descripcion, activo Activo
		FROM
			lineasProductos;";
		return $this->db->query($query);
	}
}