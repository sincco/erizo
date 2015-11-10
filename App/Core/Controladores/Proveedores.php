<?php
/**
 * Operaciones con Proveedores
 */
class Controladores_Proveedores extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de Proveedores
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloProveedores->grid();
		$this->vistaProveedores;
	}

	/**
	 * Muestra el formulario de captura de Proveedores
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaProveedoresAlta;
	}

	public function editar()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->proveedores = $this->modeloProveedores->get($data['clave']);
		$this->vistaProveedoresEdicion;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['proveedor']['proveedor']))
			echo json_encode(array("respuesta"=>$this->modeloProveedores->upd($data)));
		else
			echo json_encode(array("respuesta"=>$this->modeloProveedores->post($data)));
	}

	public function apiDel()
	{
		$data = Sfphp_Peticion::get('_parametros');
		echo json_encode(array("respuesta"=>$this->modeloProveedores->del($data['proveedor']['proveedor'])));
	}
}