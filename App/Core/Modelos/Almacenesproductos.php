<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Almacenesproductos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "
		SELECT almacen, producto, existencias, costo
		FROM almacenesProductos ";
		if(trim($id) != "")
			$where = " WHERE almacen = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo almacen
	 * @param  array $data Datos del almacen
	 * @return array
	 */
	public function post($data)
	{
		$query = "
		INSERT INTO almacenesProductos
		SET
			almacen = '{$data['almacen']}',
			producto = '{$data['producto']}',
			existencias = '{$data['descripcion']}',
			costo = '{$data['costo']}',;";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function del($id)
	{
		$query = "
		DELETE almacenesProductos
		WHERE almacenProducto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "
		SELECT 
			alm.almacen Almacen, alm.descripcion Descripcion, 
			pro.clave Clave, pro.descripcion Producto, 
			exi.existencias Existencia, exi.costo
		FROM
			almacenesProductos exi,
			almacenes alm,
			productos pro;";
		return $this->db->query($query);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function hot($almacen = 0)
	{
		$query = "
		SELECT 
			pro.clave, pro.descripcion, 
			exi.existencias, exi.costo
		FROM
			almacenesProductos exi,
			productos pro
		WHERE exi.almacen = '{$almacen}';";
		return $this->db->query($query);
	}
}