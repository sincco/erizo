<?php
/**
 * Operaciones con almacenes
 */
class Controladores_Almacenes extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de almacenes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloAlmacenes->grid();
		$this->vistaAlmacenes;
	}

	/**
	 * Muestra el formulario de captura de almacenes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaAlmacenesAlta;
	}

	public function editar()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->almacenes = $this->modeloAlmacenes->get($data['almacen']);
		$this->vistaAlmacenesEditar;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenes->post($data)));
	}

	public function apiUpd()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenes->upd($data)));
	}

	/**
	 * Productos en almacenes
	 * @return [type] [description]
	 */
	public function existencias()
	{
		$this->_vista->catalogo = $this->modeloAlmacenesproductos->grid();
		$this->vistaAlmacenesExistencias;
	}

	/**
	 * Editar un registro de existencias
	 * @return [type] [description]
	 */
	public function existenciasNuevo()
	{
		$this->_vista->catalogo = $this->modeloAlmacenesproductos->grid();
		$this->vistaAlmacenesExistencias;
	}

	/**
	 * Edicion de existencias en almacenes
	 * @return [type] [description]
	 */
	public function manejoExistencias()
	{
		$this->_vista->almacenes = $this->modeloAlmacenes->get();
		$this->vistaAlmacenesManejoExistencias;
	}

	/**
	 * Llamada AJAX para manejo de existencias
	 * @return json
	 */
	public function apiPostExistencia()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		$data['producto'] = $this->modeloProductos->getByClave($data['clave'])[0]['producto'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenesproductos->apiPost($data)));
	}

	/**
	 * Llamada AJAX para manejo de existencias
	 * @return json
	 */
	public function apiHot()
	{
		$data = Sfphp_Peticion::get()['_parametros']['almacen'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenesproductos->hot($data)));
	}
}