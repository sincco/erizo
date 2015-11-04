<?php
/**
 * Operaciones con clientes
 */
class Controladores_Clientes extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de clientes
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloClientes->grid();
		$this->vistaClientes;
	}

	/**
	 * Muestra el formulario de captura de clientes
	 * @return none
	 */
	public function nuevo()
	{
		$this->vistaClientesAlta;
	}

	public function editar()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$this->_vista->clientes = $this->modeloClientes->get($data['clave']);
		$this->vistaClientesEdicion;
	}

	/**
	 * Llamada AJAX para insertar cliente
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		if(isset($data['cliente']['cliente']))
			echo json_encode(array("respuesta"=>$this->modeloClientes->update($data)));
		else
			echo json_encode(array("respuesta"=>$this->modeloClientes->post($data)));
	}

	public function apiDel()
	{
		$data = Sfphp_Peticion::get('_parametros');
			echo json_encode(array("respuesta"=>$this->modeloClientes->del($data['cliente']['cliente'])));
	}

	/**
	 * Muestra el grid del catálogo de clientes
	 * @return none
	 */
	public function apiGrid()
	{
		echo json_encode($this->modeloClientes->grid());
	}

	/**
	 * Devuelve las direcciones de los clientes para el mapa
	 * @return json
	 */
	public function apiMapaDirecciones()
	{
		echo json_encode($this->modeloClientes->direcciones());
	}

	public function mapa()
	{
		$this->_vista->direcciones = json_encode($this->modeloClientes->direcciones());
		$this->vistaClientesMapa;
	}

}