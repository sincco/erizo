<?php
/**
 * Manejo de datos de compras
 */
class Modelos_compras extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de una compra
	 * @param  string $id Id de la compra
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT compra, producto, existencias, costo
		FROM compras ";
		if(trim($id) != "")
			$where = " WHERE compra = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo compra
	 * @param  array $data Datos del compra
	 * @return array
	 */
	public function post($data)
	{
		$query = "
		INSERT INTO compras
		SET
			compra = '{$data['compra']}',
			producto = '{$data['producto']}',
			existencias = '{$data['descripcion']}',
			costo = '{$data['costo']}',;";
		return $this->db->insert($query);
	}

	/**
	 * Devuelve el grid de compras
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT  
			com.compra Compra, com.fecha Fecha, com.descripcionCorta Descripcion,
			pro.razonSocial Proveedor, com.estatus Estatus
		FROM
			compras com
		LEFT JOIN proveedores pro USING (proveedor);";
		return $this->db->query($query);
	}

	/**
	 * Devuelve el grid del detalle de compras
	 * @return array
	 */
	public function gridDetalle($id)
	{
		$query = "SELECT com.compra, com.fecha, com.descripcionCorta,
			pro.razonSocial, com.estatus, prd.clave, prd.descripcionCorta,
			det.cantidad, det.precio, det.impuesto, det.subtotal, det.autorizado
		FROM compras com
		LEFT JOIN proveedores pro USING (proveedor)
		INNER JOIN comprasProductos det USING (compra)
		INNER JOIN productos prd USING (producto)
		WHERE com.compra = {$id};";
		return $this->db->query($query);
	}

	/**
	 * Inserta una nueva solicitud de compra
	 * @param  array $data Datos de la solicitud
	 * @return array
	 */
	public function solicitud($data)
	{
		$respuesta = array();
		$query = "INSERT INTO compras
			SET	fecha = CURDATE(),
			descripcionCorta = '{$data['descripcionCorta']}',
			estatus = 'Solicitud';";
		$compra = $this->db->insert($query);
		foreach ($data['productos'] as $key => $value) {
			if(count($value) > 1) {
				$query = "SELECT producto, precio FROM productos WHERE clave = '{$value['clave']}';";
				$producto = $this->db->query($query);
				$query = "INSERT INTO comprasProductos
					SET compra = '{$compra}',
					producto = {$producto[0]['producto']},
					cantidad = {$value['cantidad']};";
				array_push($respuesta, $this->db->insert($query));
			}
		}
		return array("solicitud"=>$compra,"detalle"=>$respuesta);
	}

}