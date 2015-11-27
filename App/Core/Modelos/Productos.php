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
		$query = "SELECT 
			producto, clave, descripcion, descripcionCorta, FORMAT(SUM(precio),3) precio, FORMAT(SUM(precio2),3) precio2, FORMAT(SUM(precio3),3) precio3, FORMAT(SUM(precio4),3) precio4,
			unidadMedida, iva, FORMAT(SUM(costo),3) costo
		FROM productos ";
		if(trim($id) != "")
			$where = " WHERE producto = {$id}";
		return $this->db->query($query.$where." ORDER BY descripcion;");
	}

	public function getMasivo()
	{
		$where = NULL;
		$query = "SELECT 
			pro.producto, pro.clave, pro.descripcion, 
			lin.descripcion lineaProducto,
			pro.descripcionCorta, ROUND(pro.precio,3) precio, 
			pro.unidadMedida, pro.iva, pro.costo, 
			ROUND(pro.precio * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precioVenta,
			ROUND(pro.precio2 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio2,
			ROUND(pro.precio3 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio3,
			ROUND(pro.precio4 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio4,
			IFNULL(exi.existencias,0) existencias
		FROM productos pro
		INNER JOIN lineasProductos lin USING(lineaProducto)
		INNER JOIN impuestos imp ON (imp.desde <= CURDATE() AND (imp.hasta <= CURDATE() OR imp.hasta IS NULL))
		LEFT JOIN almacenes alm ON (alm.principal = 1)
		LEFT JOIN almacenesProductos exi ON (exi.producto = pro.producto AND exi.almacen = alm.almacen)
		WHERE pro.activo = 1
		ORDER BY pro.descripcion;";
		return $this->db->query($query);
	}

	/**
	 * Obiene los datos de un producto por la clave
	 * @param  string $clave clave del producto
	 * @return array
	 */
	public function getByClave($clave)
	{
		$where = NULL;
		$query = "SELECT producto, clave, lineaProducto, descripcion, descripcionCorta, precio, 
		precio2, precio3, precio4, unidadMedida, iva, 0 ieps, costo
		FROM productos 
		WHERE clave = '{$clave}';";
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
		$query = "SELECT 
			producto, clave, lineaProducto, descripcionCorta, 
			unidadMedida, iva, 0 ieps, costo,
			ROUND(pro.precio * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio,
			ROUND(pro.precio2 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio2,
			ROUND(pro.precio3 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio3,
			ROUND(pro.precio4 * (1+((imp.ivaPorcentaje * pro.iva) /100)),3) precio4

		FROM productos pro
		INNER JOIN impuestos imp ON (CURDATE() >= imp.desde AND (CURDATE() <= imp.hasta OR imp.hasta IS NULL))
		WHERE descripcion like '%{$descripcion}%' AND activo = 1
		ORDER BY pro.descripcion;";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo producto
	 * @param  array $data Datos del producto
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO productos
		SET
			clave = '{$data['clave']}',
			descripcion = '{$data['descripcion']}',
			descripcionCorta = '{$data['descripcionCorta']}',
			lineaProducto = '{$data['lineaProducto']}',
			precio = '{$data['precio']}',
			unidadMedida = '{$data['unidadMedida']}',
			iva = '{$data['iva']}',
			costo = '{$data['costo']}',
			precio2 = '{$data['precio2']}',
			precio3 = '{$data['precio3']}',
			precio4 = '{$data['precio4']}',
			activo = 1;";
		return $this->db->insert($query);
	}

	/**
	 * Actualizar un producto
	 * @param  array $data Datos del producto
	 * @return array
	 */
	public function upd($data)
	{
		$query = "UPDATE productos
		SET
			descripcion = '{$data['descripcion']}',
			descripcionCorta = '{$data['descripcionCorta']}',
			lineaProducto = '{$data['lineaProducto']}',
			precio = '{$data['precio']}',
			precio2 = '{$data['precio2']}',
			precio3 = '{$data['precio3']}',
			precio4 = '{$data['precio4']}',
			unidadMedida = '{$data['unidadMedida']}',
			iva = '{$data['iva']}',
			costo = '{$data['costo']}'
		WHERE 
			clave = '{$data['clave']}';";
		return $this->db->query($query);
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
			pro.clave Producto, pro.descripcionCorta Descripcion, 
			pro.costo Costo, 
			ROUND(pro.precio*(1+((imp.ivaPorcentaje * pro.iva) /100)),3) Precio,
			ROUND(((pro.precio*(1+((imp.ivaPorcentaje * pro.iva) /100)) / pro.costo) * 100) -100, 2) Utilidad,
			ROUND(pro.precio2*(1+((imp.ivaPorcentaje * pro.iva) /100)),3) Mayorista1,
			ROUND(pro.precio3*(1+((imp.ivaPorcentaje * pro.iva) /100)),3) Mayorista2,
			ROUND(pro.precio4*(1+((imp.ivaPorcentaje * pro.iva) /100)),3) Detalle
		FROM productos pro
		INNER JOIN impuestos imp ON (CURDATE() >= imp.desde AND (CURDATE() <= imp.hasta OR imp.hasta IS NULL))
		WHERE pro.activo = 1;";
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