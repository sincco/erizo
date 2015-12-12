<?php
/**
 * Manejo de reportes
 */
class Modelos_Reportes extends Sfphp_Modelo 
{

	public function utilidades($desde, $hasta)
	{
		$query = "SELECT vta.fecha, usr.nombre, 
			FORMAT(SUM(det.subtotal),3) venta, 
			FORMAT(IFNULL(MAX(gto.monto),0),3) gasto, 
			FORMAT(SUM(pro.costo*det.cantidad),3) costo, 
			FORMAT(SUM(det.subtotal) - IFNULL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad),3) utilidad,
			FORMAT(SUM(det.subtotal) - IFNULL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad),3) * con.porcentajeSocio1 socio1,
			FORMAT(SUM(det.subtotal) - IFNULL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad),3) * con.porcentajeSocio2 socio2,
			FORMAT(SUM(det.subtotal) - IFNULL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad),3) * con.porcentajeSocio3 socio3,
			FORMAT(SUM(det.subtotal) - IFNULL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad),3) * con.porcentajeSocio4 socio4
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		INNER JOIN _configuracion con 
		LEFT JOIN (
			SELECT rta.fecha, rta.vendedor, SUM(gto.monto) monto FROM gastosRuta rta
			INNER JOIN gastosRutasDetalle gto USING(gastoRuta)
			GROUP BY rta.fecha, rta.vendedor
		) gto ON(gto.fecha = vta.fecha AND gto.vendedor = vta.vendedor)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'
		GROUP BY vta.fecha, usr.nombre;";
		return $this->db->query($query);
	}

	public function detalleVentasVendedor($desde, $hasta, $vendedor)
	{
		$query = "SELECT vta.fecha, ven.vendedor, usr.nombre, pro.descripcionCorta producto, 
			det.cantidad, pro.unidadMedida, CONCAT('$', FORMAT(det.iva, 3)) iva,
			CONCAT('$', FORMAT(det.subtotal, 3)) subtotal
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'";
		if(trim($vendedor) != "0")
			$query .= " AND vta.vendedor = '{$vendedor}'";
		$query .= " GROUP BY vta.fecha, usr.nombre, pro.descripcionCorta;";
		return $this->db->query($query);
	}

	public function comisionesVendedor($desde, $hasta, $vendedor)
	{
		$query = "SELECT vta.fecha, ven.vendedor, usr.nombre, CONCAT('$',FORMAT(SUM(det.subtotal),3)) venta, CONCAT('$',FORMAT(SUM(det.subtotal) * (ven.comision/100),3)) comision
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'";
		if(trim($vendedor) == "0")
			$query .= " AND vta.vendedor = '{$vendedor}'";
		$query .= " GROUP BY vta.fecha, usr.nombre;";
		return $this->db->query($query);
	}

	public function comisionesTotalesVendedor($desde, $hasta, $vendedor)
	{
		$query = "SELECT vta.fecha, ven.vendedor, usr.nombre, CONCAT('$',FORMAT(SUM(det.subtotal),3)) venta, CONCAT('$',FORMAT(SUM(det.subtotal) * (ven.comision/100),3)) comision
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'";
		if(trim($vendedor) == "0")
			$query .= " AND vta.vendedor = '{$vendedor}'";
		$query .= " GROUP BY usr.nombre;";
		return $this->db->query($query);
	}

	public function ventasPagos($desde, $hasta, $tipo)
	{
		$query = "SELECT vta.fecha, usr.nombre, pag.tipo, pag.monto pago, FORMAT(SUM(det.subtotal),3) venta
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN ventasPagos pag USING(venta)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'
			AND pag.tipo = '{$tipo}'
		GROUP BY vta.fecha, usr.nombre, pag.tipo;";
		return $this->db->query($query);
	}

	public function ventasCreditos($desde, $hasta)
	{
		$query = "SELECT 
			vta.fecha, ADDDATE(vta.fecha, con.diasCredito) vigencia,
			cli.razonSocial, pag.tipo,
			FORMAT(SUM(pag.monto),3) saldo, FORMAT(SUM(det.subtotal) / count(pag.tipo),3) venta
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN ventasPagos pag USING(venta)
		INNER JOIN clientes cli USING(cliente)
		INNER JOIN _configuracion con
		WHERE vta.fecha between '{$desde}' AND '{$hasta}' AND pag.tipo='Crédito' AND pag.monto > 0
		GROUP BY vta.venta, pag.tipo
		ORDER BY vta.fecha DESC, vta.venta DESC;";
		return $this->db->query($query);
	}
}