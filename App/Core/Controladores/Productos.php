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
	 * Muestra el formulario de edicion de productos
	 * @return none
	 */
	public function edicion()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		$this->_vista->producto = $this->modeloProductos->getByClave($data['clave']);
		$this->vistaProductosEdicion;
	}

	public function masivo()
	{
		$lineas = $this->modeloLineasproductos->get();
		$lineasProductos = array();
		foreach ($lineas as $key => $value) {
			 array_push($lineasProductos, "'{$value['descripcion']}'");
		}
		$this->_vista->lineasProductos = implode(",", $lineasProductos);
		$impuestos = $this->modeloImpuestos->getActual();
		$this->_vista->iva = $impuestos[0]['ivaPorcentaje'];
		$this->_vista->productos = json_encode($this->modeloProductos->getMasivo());
		$this->vistaProductosEdicionMasiva;
	}

	public function masiva()
	{
		$lineas = $this->modeloLineasproductos->get();
		$lineasProductos = array();
		foreach ($lineas as $key => $value) {
			 array_push($lineasProductos, "'{$value['descripcion']}'");
		}
		$this->_vista->lineasProductos = implode(",", $lineasProductos);
		$impuestos = $this->modeloImpuestos->getActual();
		$this->_vista->iva = $impuestos[0]['ivaPorcentaje'];
		$this->vistaProductosAltaMasiva;
	}

	/**
	 * Llamada AJAX para insertar producto
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		if(intval($data['lineaProducto']) == 0) {
			$lineaProducto = $this->modeloLineasproductos->getByDesc($data['lineaProducto']);
			$data['lineaProducto'] = $lineaProducto[0]['lineaProducto'];
		}
		echo json_encode(array("respuesta"=>$this->modeloProductos->post($data)));
	}

	/**
	 * Llamada AJAX para insertar producto
	 * @return json
	 */
	public function apiUpd()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		if(intval($data['lineaProducto']) == 0) {
			$lineaProducto = $this->modeloLineasproductos->getByDesc($data['lineaProducto']);
			$data['lineaProducto'] = $lineaProducto[0]['lineaProducto'];
		}
		echo json_encode(array("respuesta"=>$this->modeloProductos->upd($data)));
	}

	/**
	 * Llamada AJAX para borrar producto
	 * @return json
	 */
	public function apiDel()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloProductos->del($data)));
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

	/**
	 * Regresa los datos del producto según su descripción
	 * @return json
	 */
	public function apiDescripcion()
	{
		$descripcion = Sfphp_Peticion::get()['_parametros']['descripcion'];
		echo json_encode(array("respuesta"=>$this->modeloProductos->getByDescripcion($descripcion)));	
	}
}