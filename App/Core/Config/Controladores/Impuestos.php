<?php
/**
 * Operaciones con impuestos
 */
class Config_Controladores_Impuestos extends Sfphp_Controlador
{
	/**
	 * Control de impuestos
	 * @return none
	 */
	public function inicio()
	{
		$impuestos = $this->modeloConfig_Impuestos;
		$this->_vista->catalogo = $impuestos->grid();
		$this->_vista->impuestosDefinicion = $impuestos->getDefinitions();
		$this->vistaConfig_Impuestos;
	}

	/**
	 * API
	 * @return json
	 */
	public function api()
	{
		$data = Sfphp_Peticion::get()['_parametros'];
		switch (Sfphp_Peticion::get('_metodo')) {
			case 'POST':
				echo json_encode(array("respuesta"=>$this->modeloConfig_Impuestos->post($data)));
				break;
		}
	}

}