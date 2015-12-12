<?php
/**
 * Operaciones con config
 */
class Controladores_Config extends Sfphp_Controlador
{
	/**
	 * Muestra el grid del catálogo de config
	 * @return none
	 */
	public function inicio()
	{
		$this->_vista->config = $this->modeloConfig->get();
		$this->vistaConfigAlta;
	}

	public function apiUpd()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		echo json_encode(array("respuesta"=>$this->modeloConfig->upd($data)));
	}
}