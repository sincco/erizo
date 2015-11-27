<?php
/**
 * Manejo de datos de transferencia entre almacenes
 */
class Modelos_Transferencias extends Sfphp_Modelo 
{
	/**
	 * Obiene los datos de una transferencia
	 * @param  string $id Id del almacen
	 * @return array
	 */
	public function get($id = '')
	{
		$where = NULL;
		$query = "
		SELECT almacen, descripcion, activo
		FROM almacenes ";
		if(trim($id) != "")
			$where = " WHERE almacen = {$id};";
		return $this->db->query($query.$where);
	}

	public function getDetalle($id = '')
	{
		$query = "SELECT trn.fecha, trn.almacenOrigen, trn.almacenDestino,
				pro.clave, pro.descripcionCorta, det.cantidad
			FROM transferencias trn
			INNER JOIN kardex det ON (det.idTabla = trn.transferencia)
			INNER JOIN productos pro USING (producto) 
			WHERE trn.transferencia = '{$id}';";
		#echo $query;
		return $this->db->query($query);
	}

	/**
	 * Inserta una nueva transferencia
	 * @param  array $data Datos de la transferencia
	 * @return array
	 */
	public function post($data)
	{
		$query = "INSERT INTO transferencias 
			SET fecha = CURDATE(), almacenOrigen = {$data['origen']}, 
				almacenDestino = {$data['destino']}, 
				motivo = '';";
		$transferencia = $this->db->insert($query);
		foreach ($data as $key => $value) {
			$respuesta = array();
			if(count($value) > 1) {
				$query = "SELECT pro.producto, alm.existencias 
					FROM almacenesProductos alm
					INNER JOIN productos pro USING (producto)
					WHERE almacen='{$data['destino']}' AND
						pro.clave = '{$value['clave']}';";
				$existencias = $this->db->query($query);
				if(count($existencias)) {
					$query = "UPDATE almacenesProductos 
						SET existencias = existencias + {$value['cantidad']}
						WHERE almacen='{$data['destino']}' AND
						producto = '{$existencias[0]['producto']}';";
					array_push($respuesta, $this->db->insert($query));
				} else {
					$query ="SELECT producto FROM productos WHERE clave = '{$value['clave']}';";
					$producto = $this->db->query($query);
					$query = "INSERT INTO almacenesProductos
						SET almacen = '{$data['destino']}',
							producto = '{$producto[0]['producto']}',
							existencias = '{$value['cantidad']}',
							costo = 1;";
					array_push($respuesta, $this->db->insert($query));
				}
				$query ="SELECT producto,precio FROM productos WHERE clave = '{$value['clave']}';";
				$producto = $this->db->query($query);
				$query = "INSERT INTO kardex 
					SET producto = '{$producto[0]['producto']}',
						fechaHora = CURRENT_TIMESTAMP,
						movimiento = 'Salida',
						tabla = 'transferencias',
						idTabla = '{$transferencia}',
						cantidad = '{$value['cantidad']}',
						precio = '{$producto[0]['precio']}';";
				$this->db->insert($query);
				$query = "UPDATE almacenesProductos 
					SET existencias = existencias - {$value['cantidad']}
					WHERE almacen='{$data['origen']}' AND
					producto = '{$producto[0]['producto']}';";
				$this->db->query($query);
			}
		}
		$query = "DELETE FROM almacenesProductos 
			WHERE almacen = '{$data['origen']}' AND existencias = 0;";
		$this->db->query($query);
		return $transferencia;
	}

	/**
	 * Devuelve todas las transferencias para dibujar el grid
	 * @return array
	 */
	public function grid()
	{
		$query = "SELECT 
			trs.transferencia ID, trs.fecha Fecha, trs.motivo Motivo
		FROM
			transferencias trs;";
		return $this->db->query($query);
	}
}