<?php
/**
 * Manejo de datos de lineas de productos
 */
class Modelos_GastosDia extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "SELECT fecha, vendedor, gasto, monto
		FROM gastosRuta ";
		if(trim($id) != "")
			$where = " WHERE gastoRuta = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Inserta un nuevo almacen
	 * @param  array $data Datos del almacen
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO gastosRuta
		SET
			fecha = CURDATE(),
			vendedor = '{$data['vendedor']}';";
		$idInsert = $this->insert($query);
		if($idInsert) {
			foreach ($data['detalle'] as $gasto) {
				$query = "INSERT INTO gastosRutasDetalle
				SET
					gastoRuta = '{$idInsert}',
					gasto = '{$gasto['gasto']}',
					monto = '{$gasto['monto']}';";
				$this->insert($query);
			}
		}
		return $idInsert;
	}

	/**
	 * Elimina un almacen
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function del($id)
	{
		$query = "DELETE FROM gastosRuta
		WHERE gastoRuta = {$id};";
		return $this->db->query($query.$where);
	}

	/**
	 * Devuelve todos los almcenes para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			gto.gastoRuta Id, gto.fecha Fecha, usr.nombre Nombre, SUM(det.monto) Monto
		FROM
			gastosRuta gto
		INNER JOIN gastosRutasDetalle det USING(gastoRuta)
		INNER JOIN vendedores ven USING(vendedor)
		INNER JOIN usuarios usr USING(usuario);";
		return $this->db->query($query);
	}
}