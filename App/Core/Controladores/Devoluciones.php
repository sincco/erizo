<?php
/**
 * Operaciones con productos
 */
class Controladores_Devoluciones extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de productos
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloDevoluciones->grid();
		$this->vistaDevoluciones;
	}

	/**
	 * Muestra el formulario de captura de productos
	 * @return none
	 */
	public function capturar()
	{
		$this->_vista->vendedores = $this->modeloVendedores->get();
		$_productos = $this->modeloProductos->get();
		$productos = array();
		foreach ($_productos as $key => $value) {
			 array_push($productos, "'{$value['descripcion']}'");
		}
		$this->_vista->productos = implode(",",$productos);
		$_clientes = $this->modeloClientes->get();
		$clientes = array();
		foreach ($_clientes as $key => $value) {
			 array_push($clientes, "'{$value['razonSocial']}'");
		}
		$this->_vista->clientes = implode(",",$clientes);
		$this->vistaDevolucionesCapturar;
	}

	/**
	 * Llamada AJAX para insertar producto
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$idProducto = $this->modeloProductos->getByDescripcion($data['producto']);
		$idCliente = $this->modeloClientes->getByRazon($data['cliente']);
		$data['cliente'] = $idCliente[0]['cliente'];
		$data['producto'] = $idProducto[0]['producto'];
		echo json_encode(array("respuesta"=>$this->modeloDevoluciones->post($data)));
	}
}