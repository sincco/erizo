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

	public function getDetalle($id = '')
	{
		$where = NULL;
		$query = "SELECT vta.venta, vta.fecha,
			cli.razonSocial, con.correo, con.nombre contacto,
			usr.nombre vendedor,
			vta.estatus, prd.clave producto, prd.descripcionCorta,
			FORMAT(det.cantidad,3) cantidad, FORMAT(det.precio,3) precio, FORMAT(det.iva,3) iva, FORMAT(det.subtotal,3) subtotal
		FROM ventas vta
		INNER JOIN clientes cli USING (cliente)
		INNER JOIN ventasProductos det USING (venta)
		INNER JOIN productos prd USING (producto)
		INNER JOIN vendedores ven USING (vendedor)
		INNER JOIN usuarios usr USING (usuario)
		LEFT JOIN clientesContactos con USING (cliente)
		WHERE vta.venta = {$id};";
		return $this->db->query($query);
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
	#Cabecera de venta
		$query = "INSERT INTO ventas
		SET
			fecha = CURDATE(),
			hora = CURTIME(),
			cliente = '{$data['cliente']}',
			vendedor = '{$data['vendedor']}',
			estatus = '{$data['estatus']}';";
		$venta = $this->db->insert($query);
		$respuesta = array();
		foreach ($data['productos'] as $key => $value) {
		#Detalle de venta
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
			#Salida de inventario
				if($detalle && ($data['estatus'] == 'Pago' || $data['estatus'] == 'Entregada')) {
					$query = "UPDATE almacenesProductos
					SET
						existencias = existencias - {$value['cantidad']}
					WHERE almacen = {$almacen['almacen']} AND
						producto = {$value['producto']};";
					$this->db->query($query);
					$query = "INSERT INTO kardex
					SET producto = '{$value['producto']}',
						fechaHora = CURRENT_TIMESTAMP,
						movimiento = 'Salida',
						tabla = 'ventas',
						idTabla = '{$venta}',
						cantidad = '{$value['cantidad']}',
						precio = '{$value['precio']}',
						costo = '0';";
					$this->db->insert($query);
				}
				array_push($respuesta, $detalle);
			}
		}
	#Insertar pagos
		if($venta) {
			if(isset($data['pagos'])) {
				if(floatval($data['pagos']['efectivo']) > 0) {
					$query = "INSERT INTO ventasPagos
						SET venta = '{$venta}',
						tipo = 'Efectivo',
						monto = '{$data['pagos']['efectivo']}',
						fecha = CURDATE();";
					$this->db->insert($query);
				}
				if(floatval($data['pagos']['tarjeta']) > 0) {
					$query = "INSERT INTO ventasPagos
						SET venta = '{$venta}',
						tipo = 'Tarjeta',
						monto = '{$data['pagos']['tarjeta']}',
						fecha = CURDATE();";
					$this->db->insert($query);
				}
				if(floatval($data['pagos']['monedero']) > 0) {
					$query = "INSERT INTO ventasPagos
						SET venta = '{$venta}',
						tipo = 'Crédito',
						monto = '{$data['pagos']['monedero']}',
						fecha = CURDATE();";
					$this->db->insert($query);
				}
			}
		}
		return array("venta"=>$venta,"detalle"=>$respuesta);
	}


	/**
	 * Inserta una cotizacion
	 * @param  array $data Datos de la cotizacion
	 * @return array
	 */
	public function postCotizacion($data)
	{
	#Cabecera de venta
		$query = "INSERT INTO ventas
		SET
			fecha = CURDATE(),
			hora = CURTIME(),
			cliente = '{$data['cliente']}',
			vendedor = '{$data['vendedor']}',
			estatus = 'Cotización';";
		$venta = $this->db->insert($query);
		$respuesta = array();
		foreach ($data['productos'] as $key => $value) {
		#Detalle de venta
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
				array_push($respuesta, $detalle);
			}
		}
		return array("venta"=>$venta,"detalle"=>$respuesta);
	}

	/**
	 * Devuelve el grid de ventas
	 * @return array
	 */
	public function grid($estatus = "Pago")
	{
		$query = "SELECT vta.venta Venta, vta.fecha Fecha, cli.razonSocial Cliente, vta.estatus Estatus
		FROM ventas vta 
		INNER JOIN clientes cli USING (cliente)
		WHERE estatus = '{$estatus}'
		ORDER BY vta.venta DESC;";
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
			det.cantidad, FORMAT(det.precio,3) precio, FORMAT(det.iva,3) iva, det.ieps, FORMAT(det.subtotal,3) subtotal
		FROM ventas vta
		INNER JOIN clientes cli USING (cliente)
		INNER JOIN ventasProductos det USING (venta)
		INNER JOIN productos prd USING (producto)
		WHERE vta.venta = {$id};";
		return $this->db->query($query);
	}

	public function ventasRecientes()
	{
		$query = "SELECT vta.venta Venta, vta.fecha Fecha, cli.razonSocial Cliente, vta.estatus Estatus, FORMAT(det.subtotal,3) Monto
				FROM ventas vta 
				INNER JOIN clientes cli USING (cliente)
				INNER JOIN (SELECT venta,SUM(subtotal) subtotal FROM ventasProductos GROUP BY venta) det USING (venta)
				ORDER BY vta.fecha, vta.hora DESC
				LIMIT 5;";
		return $this->db->query($query);
	}
}