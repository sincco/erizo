<?php
/**
 * Manejo de reportes
 */
class Modelos_Reportes extends Sfphp_Modelo 
{

	public function utilidades($desde, $hasta)
	{
		$query = "SELECT vta.fecha, SUM(pag.monto) venta, SUM(gto.monto) gasto, SUM(pro.costo) costo
		FROM ventas vta
		INNER JOIN ventasPagos pag USING(venta)
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN productos pro USING(producto)
		INNER JOIN gastosRuta rta ON(rta.fecha = vta.fecha)
		INNER JOIN gastosRutasDetalle gto USING(gastoRuta)
		WHERE vta.fecha between '{$desde}' AND '{$hasta}'
		GROUP BY vta.fecha;";
		return $this->db->query($query);
	}
}