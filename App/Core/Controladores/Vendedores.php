<?php
/**
 * Operaciones con vendedores
 */
class Controladores_Vendedores extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de vendedores
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloVendedores->grid();
		$this->vistaVendedores;
	}

	/**
	 * Muestra el formulario de captura de vendedores
	 * @return none
	 */
	public function nuevo()
	{
		$this->_vista->usuarios = $this->modeloUsuarios->getActivos();
		$this->_vista->almacenes = $this->modeloAlmacenes->get();
		$this->vistaVendedoresAlta;
	}

	public function editar()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->vendedores = $this->modeloVendedores->get($data['vendedor']);
		$this->_vista->almacenes = $this->modeloAlmacenes->get();
		$this->vistaVendedoresEdicion;
	}

	/**
	 * Llamada AJAX para insertar vendedor
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloVendedores->post($data)));
	}

	public function apiUpd()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloVendedores->upd($data)));
	}

}