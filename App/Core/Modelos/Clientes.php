<?php
/**
 * Manejo de datos de clientes
 */
class Modelos_Clientes extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un cliente
	 * @param  string $id Id del cliente a consultar
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT 
			cli.cliente, cli.razonSocial, cli.rfc, cli.direccionFiscal, cli.activo,
			dir.alias, dir.domicilio, dir.telefono,
			con.nombre, con.telefono, con.correo, cli.diasCredito
		FROM clientes cli
		LEFT JOIN clientesContactos con USING(cliente)
		LEFT JOIN clientesDirecciones dir USING (cliente)";
		if(trim($id) != "")
			$where = " WHERE cliente = {$id}";
		return $this->db->query($query.$where." ORDER BY cli.razonSocial;");
	}

	public function getByRazon($razonSocial)
	{
		$query = "SELECT 
			cli.cliente, cli.razonSocial, cli.rfc, cli.direccionFiscal, cli.activo,
			dir.alias, dir.domicilio, dir.telefono,
			con.nombre, con.telefono, con.correo
		FROM clientes cli
		LEFT JOIN clientesContactos con USING(cliente)
		LEFT JOIN clientesDirecciones dir USING (cliente)
		WHERE razonSocial = '{$razonSocial}'
		ORDER BY cli.razonSocial;";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo cliente
	 * @param  array $data Datos del cliente ['cliente']['contactos']['direcciones']
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO clientes
		SET
			razonSocial = '{$data['cliente']['razonSocial']}',
			rfc = '{$data['cliente']['rfc']}',
			direccionFiscal = '{$data['cliente']['direccionFiscal']}',
			diasCredito = '{$data['diasCredito']}',
			activo = 1;";
		$idInsert = $this->db->insert($query);
		if($idInsert) 
		{
			if(trim($data['contactos']['nombre']) != "") {
				$query = "INSERT INTO clientesContactos
				SET
					cliente = '$idInsert',
					nombre = '{$data['contactos']['nombre']}',
					correo = '{$data['contactos']['correo']}',
					telefono = '{$data['contactos']['telefono']}';";
				$this->db->insert($query);
			}
			if(trim($data['direcciones']['alias']) != "") {
				$query = "INSERT INTO clientesDirecciones
				SET
					cliente = '$idInsert',
					alias = '{$data['direcciones']['alias']}',
					domicilio = '{$data['direcciones']['domicilio']}',
					telefono = '{$data['direcciones']['telefono']}';";
				$this->db->insert($query);
			}
		}
		return $idInsert;
	}

	/**
	 * Inserta un nuevo cliente
	 * @param  array $data Datos del cliente ['cliente']['contactos']['direcciones']
	 * @return array
	 */
	public function upd($data)
	{
		$query = "UPDATE clientes
		SET
			razonSocial = '{$data['cliente']['razonSocial']}',
			rfc = '{$data['cliente']['rfc']}',
			direccionFiscal = '{$data['cliente']['direccionFiscal']}',
			diasCredito = '{$data['cliente']['diasCredito']}'
		WHERE cliente = '{$data['cliente']['cliente']}';";
		$this->db->query($query);
		$idInsert = $data['cliente']['cliente'];
		if($idInsert) 
		{
			if(trim($data['contactos']['nombre']) != "") {
				$query = "REPLACE INTO clientesContactos
				SET
					cliente = '{$idInsert}',
					nombre = '{$data['contactos']['nombre']}',
					correo = '{$data['contactos']['correo']}',
					telefono = '{$data['contactos']['telefono']}';";
				$this->db->query($query);
			}
			if(trim($data['direcciones']['alias']) != "") {
				$query = "REPLACE INTO clientesDirecciones
				SET
					cliente = '{$idInsert}',
					alias = '{$data['direcciones']['alias']}',
					domicilio = '{$data['direcciones']['domicilio']}',
					telefono = '{$data['direcciones']['telefono']}';";
				$this->db->query($query);
			}
		}
		return $idInsert;
	}

	/**
	 * Elimina un cliente en particular (desactiva)
	 * @param  string $id Id del cliente
	 * @return array
	 */
	public function del($id)
	{
		$query = "UPDATE clientes
		SET activo = 0 
		WHERE cliente = {$id};";
		return $this->db->query($query);
	}

	/**
	 * Devuelve todos los clientes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			cli.cliente Clave, cli.razonSocial 'Razon Social', cli.rfc RFC, cli.direccionFiscal 'Direccion Fiscal'
		FROM
			clientes cli
		WHERE activo = 1;";
		return $this->db->query($query);
	}

	public function direcciones()
	{
		$query = "SELECT 
			cli.cliente, cli.razonSocial, cli.rfc, cli.direccionFiscal, cli.activo Activo
		FROM
			clientes cli
		WHERE activo = 1;";
		return $this->db->query($query);
	}
}