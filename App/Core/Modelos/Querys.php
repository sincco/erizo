<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Querys extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT id, descripcion, query, filtro
		FROM _querys ";
		if(trim($id) != "")
			$where = " WHERE id = {$id};";
		return $this->db->query($query.$where);
	}

	public function grid()
	{
		$query = "SELECT id, descripcion
		FROM _querys;";
		return $this->db->query($query);
	}

}
