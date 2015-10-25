<?php
/**
 * Manejo de datos de documentos de ventas
 */
class Modelos_Ventasdocumentos extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un documento
	 * @param  string $id Id del documento
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT venta, tipo, identificador, fecha, hora, monto
			FROM ventasDocumentos";
		if(trim($id) != "")
			$where = " WHERE ventaDocumento = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo documento de venta
	 * @param  array $data Datos
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO ventasDocumentos
		SET
			tipo = '{$data['tipo']}',
			fecha = CURDATE(),
			hora = CURTIME(),
			venta = '{$data['venta']}',
			monto = '{$data['monto']}',
			identificador = '{$data['identificador']}';";
		return $this->db->insert($query);
	}

	/**
	 * Devuelve el grid
	 * @return none
	 */
	public function grid()
	{
		$query = "SELECT vta.venta Venta, doc.tipo Tipo, doc.identificador Clave,
			doc.fecha Fecha, cli.razonSocical Cliente, doc.Monto
		FROM ventasDocumentos doc
		INNER JOIN ventas vta USING (venta)
		INNER JOIN clientes cli USING (cliente)
		ORDER BY doc.fecha, doc.hora DESC";
		return $this->db->query($query);
	}

	/**
	 * Devuelve los documentos recientes
	 * @return none
	 */
	public function documentosRecientes()
	{
		$query = "SELECT vta.venta Venta, doc.tipo Tipo, doc.identificador Clave,
			doc.fecha Fecha, cli.razonSocial Cliente, doc.Monto
		FROM ventasDocumentos doc
		INNER JOIN ventas vta USING (venta)
		INNER JOIN clientes cli USING (cliente)
		ORDER BY doc.fecha, doc.hora DESC
		LIMIT 1,5;";
		return $this->db->query($query);
	}
}