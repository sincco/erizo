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

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloAlmacenes->post($data)));
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
}