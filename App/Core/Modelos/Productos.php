<?php
/**
 * Manejo de datos de productos
 */
class Modelos_Productos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un producto
	 * @param  string $id Id del producto
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "
		SELECT producto, descripcion, descripcionCorta, precio, activo
		FROM productos ";
		if(trim($id) != "")
			$where = " WHERE producto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Obiene los datos de un producto por la clave
	 * @param  string $clave clave del producto
	 * @return array
	 */
	public function getByClave($clave = '')
	{
		$where = NULL;
		$query = "SELECT producto, clave, lineaProducto, descripcion, descripcionCorta, precio, unidadMedida, iva, costo
		FROM productos ";
		$where = " WHERE clave = '{$clave}';";
		return $this->db->query($query.$where);
	}

	/**
	 * Obtiene los datos de un producto por su descripcion
	 * @param  string $descripcion descripcion del producto
	 * @return array
	 */
	public function getByDescripcion($descripcion = '')
	{
		$where = NULL;
		$query = "SELECT producto, clave, lineaProducto, descripcionCorta, precio, unidadMedida, iva, costo
		FROM productos
		WHERE descripcion like '%{$descripcion}%' AND activo = 1;";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo producto
	 * @param  array $data Datos del producto
	 * @return array
	 */
	public function post($data)
	{
		$query = "REPLACE INTO productos
		SET
			clave = '{$data['clave']}',
			descripcion = '{$data['descripcion']}',
			descripcionCorta = '{$data['descripcionCorta']}',
			lineaProducto = '{$data['lineaProducto']}',
			precio = '{$data['precio']}',
			unidadMedida = '{$data['unidadMedida']}',
			iva = '{$data['iva']}',
			costo = '{$data['costo']}',
			activo = 1;";
		return $this->db->insert($query);
	}

	/**
	 * Actualizar un producto
	 * @param  array $data Datos del producto
	 * @return array
	 */
	public function update($data)
	{
		$query = "REPLACE INTO productos
		SET
			clave = '{$data['clave']}',
			descripcion = '{$data['descripcion']}',
			descripcionCorta = '{$data['descripcionCorta']}',
			precio = '{$data['precio']}',
			costo = '{$data['costo']}',
			activo = 1;";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un producto
	 * @param  string $id Id del producto
	 * @return array
	 */
	public function del($data)
	{
		$query = "UPDATE productos
		SET activo = 0 
		WHERE clave = '{$data['clave']}';";
		return $this->db->query($query);
	}

	/**
	 * Devuelve todos los productos para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			clave Producto, descripcionCorta Descripcion, 
			precio Precio, costo Costo
		FROM
			productos
		WHERE activo = 1;";
		return $this->db->query($query);
	}

	/**
	 * Los productos con más ventas
	 * @return array
	 */
	public function masVendidos()
	{
		$query = "SELECT det.producto, pro.descripcionCorta, COUNT(distinct det.venta) ventas
			FROM ventasProductos det
			INNER JOIN productos pro USING (producto)
			LIMIT 5;";
		return $this->db->query($query);
	}
}