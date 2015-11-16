<?php
/**
 * Manejo de datos de proveedores
 */
class Modelos_Proveedores extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un proveedor
	 * @param  string $id Id del proveedor a consultar
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT 
			pro.proveedor, pro.razonSocial, pro.rfc, pro.direccionFiscal, pro.activo,
			con.proveedorContacto,con.nombre, con.correo, con.telefono
		FROM
			proveedores pro
		LEFT JOIN proveedoresContactos con USING (proveedor) ";
		if(trim($id) != "")
			$where = " WHERE pro.proveedor = '{$id}';";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo proveedor
	 * @param  array $data Datos del proveedor ['proveedor']['contactos']
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO proveedores
		SET
			razonSocial = '{$data['proveedor']['razonSocial']}',
			rfc = '{$data['proveedor']['rfc']}',
			direccionFiscal = '{$data['proveedor']['direccionFiscal']}',
			activo = 1;";
		$idInsert = $this->db->insert($query);
		if($idInsert AND count($data['contactos'])) {
			$query = "
			INSERT INTO proveedoresContactos
			SET
				proveedor = '$idInsert',
				nombre = '{$data['contactos']['nombre']}',
				correo = '{$data['contactos']['correo']}',
				telefono = '{$data['contactos']['telefono']}';";
			$this->db->insert($query);
		}
		return $idInsert;
	}

	public function upd($data)
	{
		$query = "UPDATE proveedores
		SET
			razonSocial = '{$data['proveedor']['razonSocial']}',
			rfc = '{$data['proveedor']['rfc']}',
			direccionFiscal = '{$data['proveedor']['direccionFiscal']}'
		WHERE proveedor = '{$data['proveedor']['proveedor']}';";
		$this->db->query($query);
		if(count($data['contactos'])) {
			$query = "REPLACE INTO proveedoresContactos
			SET
				proveedor = '{$data['proveedor']['proveedor']}',
				nombre = '{$data['contactos']['nombre']}',
				correo = '{$data['contactos']['correo']}',
				telefono = '{$data['contactos']['telefono']}';";
			$this->db->query($query);
		}
		return $data['proveedor']['proveedor'];
	}

	/**
	 * Elimina un proveedor en particular (desactiva)
	 * @param  string $id Id del proveedor
	 * @return array
	 */
	public function del($id)
	{
		$query = "UPDATE proveedores
		SET activo = 0 
		WHERE proveedor = {$id};";
		return $this->db->query($query);
	}

	/**
	 * Devuelve todos los proveedores para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			pro.proveedor Clave, pro.razonSocial 'Razon Social', pro.rfc RFC, pro.direccionFiscal 'Direccion Fiscal'
		FROM
			proveedores pro
		WHERE activo = 1;";
		return $this->db->query($query);
	}
}