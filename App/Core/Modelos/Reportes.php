<?php
/**
 * Manejo de reportes
 */
class Modelos_Reportes extends Sfphp_Modelo 
{

	public function utilidades($desde, $hasta)
	{
		$query = "SELECT vta.fecha, usr.nombre, SUM(det.subtotal) venta, NVL(MAX(gto.monto),0) gasto, SUM(pro.costo*det.cantidad) costo, SUM(det.subtotal) - NVL(MAX(gto.monto),0) - SUM(pro.costo*det.cantidad) utilidad
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
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
		$query = "SELECT vta.fecha, usr.nombre, pro.descripcionCorta producto, 
			det.cantidad, det.iva, det.subtotal
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario)
		INNER JOIN productos pro USING(producto)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'";
		if(trim($vendedor) == "0")
			$query .= " AND vta.vendedor = '{$vendedor}'";
		$query .= " GROUP BY vta.fecha, usr.nombre, pro.descripcionCorta;";
		return $this->db->query($query);
	}
}