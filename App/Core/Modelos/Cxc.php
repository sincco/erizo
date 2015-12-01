<?php
/**
 * Manejo de reportes
 */
class Modelos_Cxc extends Sfphp_Modelo 
{
	public function grid()
	{
		$query = "SELECT 
			vta.venta clave, vta.fecha, ADDDATE(vta.fecha, con.diasCredito) vigencia,
			cli.razonSocial, pag.tipo,
			FORMAT(SUM(pag.monto),3) saldo, FORMAT(SUM(det.subtotal) / count(pag.tipo),3) venta
		FROM ventas vta
		INNER JOIN ventasProductos det USING(venta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN ventasPagos pag USING(venta)
		INNER JOIN clientes cli USING(cliente)
		INNER JOIN _configuracion con
		WHERE pag.tipo='Crédito' AND pag.monto > 0
		GROUP BY vta.venta, pag.tipo
		ORDER BY vta.fecha DESC, vta.venta DESC;";
		return $this->db->query($query);
	}

	public function post($data)
	{
		$query = "INSERT INTO ventasPagos 
			SET venta='{$data['venta']}', 
			tipo='Efectivo', 
			monto={$data['pago']}, 
			fecha=CURDATE();";
		$id = $this->insert($query);
		if($id) {
			$query = "UPDATE ventasPagos
			SET monto = monto - {$data['pago']}
			WHERE venta = {$data['venta']} AND tipo = 'Crédito';";
			$this->query($query);
		}
		$query = "DELETE FROM ventasPagos WHERE monto <= 0;";
		$this->query($query);
		return $id;
	}
}