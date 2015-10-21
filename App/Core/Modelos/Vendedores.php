<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Vendedores extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un vendedor
	 * @param  string $id Id del vendedor
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT ven.vendedor, ven.almacen, usr.nombre
		FROM vendedores ven
		INNER JOIN usuarios usr USING (usuario)";
		if(trim($id) != "")
			$where = " WHERE ven.vendedor = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve el id de vendedor en base al usuario
	 * @param  int $usuario Id de usario
	 * @return array
	 */
	public function getByUsuario($usuario)
	{
		$query = "SELECT vendedor FROM vendedores WHERE usuario = '{$usuario}';";
		return $this->db->query($query);
	}

	/**
	 * Inserta un nuevo vendedor
	 * @param  array $data Datos del vendedor
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO vendedores
		SET
			usuario = '{$data['usuario']}',
			almacen = '{$data['almacen']}';";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un vendedor
	 * @param  string $id Id del vendedor
	 * @return array
	 */
	public function del($id)
	{
		$query = "UPDATE vendedores
		SET activo = 0 
		WHERE lineaProducto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los vendedores para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT ven.vendedor, usr.nombre, ven.almacen, alm.descripcion
		FROM vendedores ven
		INNER JOIN usuarios usr USING (usuario)
		INNER JOIN almacenes alm USING (almacen);";
		return $this->db->query($query);
	}
}