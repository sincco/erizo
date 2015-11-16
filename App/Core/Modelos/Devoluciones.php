<?php
/**
 * Manejo de datos de devoluciones
 */
class Modelos_Devoluciones extends Sfphp_Modelo 
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
			producto, clave, descripcion, descripcionCorta, precio, unidadMedida, iva, costo
		FROM devoluciones ";
		if(trim($id) != "")
			$where = " WHERE producto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo producto
	 * @param  array $data Datos del producto
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO devoluciones
		SET
			vendedor = '{$data['vendedor']}',
			producto = '{$data['producto']}',
			cliente = '{$data['cliente']}',
			cantidad = '{$data['cantidad']}',
			fecha = CURDATE();";
		return $this->db->insert($query);
	}

	/**
	 * Devuelve todos los devoluciones para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			dev.fecha Fecha, cli.razonSocial Cliente,
			pro.clave Producto, pro.descripcionCorta Descripcion,
			dev.cantidad cantidad
		FROM devoluciones dev
		INNER JOIN clientes cli USING(cliente)
		INNER JOIN productos pro USING(producto);";
		return $this->db->query($query);
	}

	public function detalleVendedor($desde, $hasta, $vendedor)
	{
		$query = "SELECT dev.fecha, usr.nombre, pro.descripcionCorta producto, 
			dev.cantidad
		FROM devoluciones dev
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		WHERE dev.fecha between '{$desde}' AND '{$hasta}'";
		if(trim($vendedor) != "0")
			$query .= " AND dev.vendedor = '{$vendedor}'";
		$query .= " GROUP BY dev.fecha, usr.nombre, pro.descripcionCorta;";
		return $this->db->query($query);
	}
}
