<?php
/**
 * Manejo de datos de usuarops
 */
class Modelos_Usuarios extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un usuario
	 * @param  string $id Id del usuario
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "
		SELECT usuario, clave, nombre, activo
		FROM usuarios ";
		if(trim($id) != "")
			$where = " WHERE usuario = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Obtiene los usuarios activos
	 * @return array
	 */
	public function getActivos()
	{
		$where = NULL;
		$query = "SELECT usuario, clave, nombre, activo
		FROM usuarios
		WHERE activo = 1;";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo usuario
	 * @param  array $data Datos del usuario
	 * @return array
	 */
	public function post($data)
	{
		$query = "
		INSERT INTO usuarios
		SET
			clave = '{$data['clave']}',
			password = '".Sfphp::encrypt($data['password'],Sfphp_Config::get()['app']['key'])."',
			activo = 1;";
		return $this->db->insert($query);
	}

	/**
	 * Elimina un usuario
	 * @param  string $id Id del usuario
	 * @return array
	 */
	public function del($id)
	{
		$query = "
		UPDATE usuarios
		SET activo = 0 
		WHERE producto = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "
		SELECT 
			usuario Usuario, clave Clave, activo Activo
		FROM
			usuarios;";
		return $this->db->query($query);
	}

	/**
	 * Valida el acceso del usuario
	 * @param  array Datos de acceso
	 * @return array
	 */
	public function login($data)
	{
		$query = "
		SELECT usuario, clave
		FROM usuarios
		WHERE clave = '{$data['clave']}'
			AND password = '".Sfphp::encrypt($data['password'],Sfphp_Config::get()['app']['key'])."'
			AND activo = 1;";
		return $this->db->query($query);
	}
}