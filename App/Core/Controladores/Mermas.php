<?php
/**
 * Operaciones con mermas
 */
class Controladores_Mermas extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de mermas
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloMermas->grid();
		$this->vistaMermas;
	}

	/**
	 * Muestra el formulario de captura de mermas
	 * @return none
	 */
	public function capturar()
	{
		$this->_vista->productos = json_encode($this->modeloProductos->get());
		$this->_vista->vendedores = $this->modeloVendedores->get();
		$this->vistaMermasCapturar;
	}

	/**
	 * Llamada AJAX para insertar mermas
	 * @return json
	 */
	public function apiPost()
	{
		$data = Sfphp_Peticion::get('_parametros');
		$idProducto = $this->modeloProductos->getByClave($data['producto']);
		$data['producto'] = $idProducto[0]['producto'];
		echo json_encode(array("respuesta"=>$this->modeloMermas->post($data)));
	}
}
