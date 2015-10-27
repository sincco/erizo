<?php
/**
 * Operaciones con trazado de rutas
 */
class Controladores_Rutas extends Sfphp_Controlador
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

	public function trazar()
	{
		$this->_vista->direcciones = $this->modeloClientes->direcciones();
		$this->vistaRutasTrazar;
	}

}