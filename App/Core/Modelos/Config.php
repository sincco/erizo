<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_Config extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get()
	{
		$where = NULL;
		$query = "SELECT *
		FROM _configuracion;";
		return $this->db->query($query.$where);
	}

	public function upd($data)
	{
		$query = "UPDATE _configuracion
		SET
			porcentajeSocio1 = {$data['porcentajeSocio1']},
			porcentajeSocio2 = {$data['porcentajeSocio2']},
			porcentajeSocio3 = {$data['porcentajeSocio3']},
			porcentajeSocio4 = {$data['porcentajeSocio4']}
		WHERE id = 1;";
		return $this->db->insert($query);
	}

}
