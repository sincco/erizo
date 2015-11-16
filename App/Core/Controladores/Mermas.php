<?php
/**
 * Operaciones con productos
 */
class Controladores_Mermas extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de productos
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloMermas->grid();
		$this->vistaMermas;
	}

	/**
	 * Muestra el formulario de captura de productos
	 * @return none
	 */
	public function capturar()
	{
		$_productos = $this->modeloProductos->get();
		$productos = array();
		foreach ($_productos as $key => $value) {
			 array_push($productos, "'{$value['descripcion']}'");
		}
		$this->_vista->productos = implode(",",$productos);
		$this->_vista->vendedores = $this->modeloVendedores->get();
		$this->vistaMermasCapturar;
	}

	/**
	 * Llamada AJAX para insertar producto
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$idProducto = $this->modeloProductos->getByDescripcion($data['producto']);
		$data['producto'] = $idProducto[0]['producto'];
		echo json_encode(array("respuesta"=>$this->modeloMermas->post($data)));
	}
}