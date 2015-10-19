<?php
/**
 * Manejo de datos de ventas
 */
class Modelos_Ventas extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de una venta
	 * @param  string $id Id de la venta
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT vta.venta Venta, vta.fecha Fecha, cli.razonSocial Cliente, vta.estatus Estatus
		FROM ventas vta 
		INNER JOIN clientes cli USING (cliente)";
		if(trim($id) != "")
			$where = " WHERE venta = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo venta
	 * @param  array $data Datos del venta
	 * @return array
	 */
	public function post($data)
	{
		$query = "SELECT almacen FROM vendedores WHERE vendedor = '{$data['vendedor']}';";
		$almacen = $this->db->query($query);
		$almacen = $almacen[0];
		$query = "INSERT INTO ventas
		SET
			fecha = CURDATE(),
			cliente = '{$data['cliente']}',
			vendedor = '{$data['vendedor']}',
			estatus = '{$data['estatus']}';";
		$venta = $this->db->insert($query);
		$respuesta = array();
		foreach ($data['productos'] as $key => $value) {
			if(count($value)>2 && $venta > 0) {
				$query = "INSERT INTO ventasProductos
				SET
					venta = '{$venta}',
					producto = '{$value['producto']}',
					cantidad = '{$value['cantidad']}',
					precio = '{$value['precio']}',
					iva = '{$value['iva']}',
					ieps = '{$value['ieps']}',
					subtotal = '{$value['subtotal']}';";
				$detalle = $this->db->insert($query);
				if($detalle && ($data['estatus'] == 'Pago' || $data['estatus'] == 'Entregada')) {
					$query = "UPDATE almacenesProductos
					SET
						existencias = existencias - {$value['cantidad']}
					WHERE almacen = {$almacen['almacen']} AND
						producto = {$value['producto']};"
					$this->db->query($query);
				}
				array_push($respuesta, $detalle);

			}
		}
		return array("venta"=>$venta,"detalle"=>$respuesta);
	}

	/**
	 * Devuelve el grid de ventas
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT vta.venta Venta, vta.fecha Fecha, cli.razonSocial Cliente, vta.estatus Estatus
		FROM ventas vta 
		INNER JOIN clientes cli USING (cliente)
		ORDER BY vta.fecha DESC;";
		return $this->db->query($query);
	}

	/**
	 * Devuelve el grid del detalle de ventas
	 * @return array
	 */
	public function gridDetalle($id)
	{
		$query = "SELECT vta.venta, vta.fecha,
			cli.razonSocial, vta.estatus, prd.clave, prd.descripcionCorta,
			det.cantidad, det.precio, det.iva, det.ieps, det.subtotal
		FROM ventas vta
		INNER JOIN clientes cli USING (cliente)
		INNER JOIN ventasProductos det USING (venta)
		INNER JOIN productos prd USING (producto)
		WHERE vta.venta = {$id};";
		return $this->db->query($query);
	}
}