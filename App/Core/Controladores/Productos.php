<?php
/**
 * Operaciones con productos
 */
class Controladores_Productos extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de productos
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloProductos->grid();
		$this->vistaProductos;
	}

	/**
	 * Muestra el formulario de captura de productos
	 * @return none
	 */
	public function nuevo()
	{
		$this->_vista->lineas = $this->modeloLineasproductos->get();
		$this->vistaProductosAlta;
	}

	/**
	 * Llamada AJAX para insertar producto
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloProductos->post($data)));
	}

	/**
	 * Regresa los datos del producto según su clave
	 * @return json
	 */
	public function apiClave()
	{
		$clave = Sfphp_Peticion::get()['_parametros']['clave'];
		echo json_encode(array("respuesta"=>$this->modeloProductos->getByClave($clave)));	
	}
}