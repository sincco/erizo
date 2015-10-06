<?php
class Controladores_Pedidos extends Sfphp_Controlador
{
	public function inicio()
	{
		$this->_vista->pedidos = $this->utf8_converter($this->modeloPedidos->get());
		$this->vistaPedidos;
	}

	private function utf8_converter($array)
	{
	    array_walk_recursive($array, function(&$item, $key){
	        if(!mb_detect_encoding($item, 'utf-8', true)){
	                $item = utf8_encode($item);
	        }
	    });
	 
	    return $array;
	}
}