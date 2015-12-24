<?php
class Controladores_Querys extends Sfphp_Controlador
{
	public function inicio()
	{
		$this->_vista->catalogo = $this->modeloQuerys->grid();
		$this->vistaQuerys;
	}

	public function ejecutar()
	{
		$_data = Sfphp_Peticion::get('_parametros');
		$_querys = $this->modeloQuerys->get($_data['id']);
		$this->_vista->query = $_querys;
		$_query = array_shift($_querys);
		$_filtros = json_decode($_query['filtro'], TRUE);
		$_htmlForm = "";
		foreach ($_filtros as $_filtro) {
			switch ($_filtro['tipo']) {
				case 'FECHA':
					$_htmlForm .= '
					<div class="input-group input-daterange">
						<label>'.strtoupper($_filtro['campo']).'</label><input type="text" class="form-control" value="'.date("Y-m-d").'" data-date-format="yyyy-mm-dd" name="'.$_filtro['campo'].'">
					</div>';
					break;
				case 'FECHAS':
					$_htmlForm .= '
					<label>'.strtoupper($_filtro['campo']).'</label>
					<div class="input-group input-daterange">
						<span class="input-group-addon">desde</span>
						<input type="text" class="form-control" value="'.date("Y-m-d").'" data-date-format="yyyy-mm-dd" name="'.$_filtro['campo'].'[]">
						<span class="input-group-addon">hasta</span>
						<input type="text" class="form-control" value="'.date("Y-m-d").'" data-date-format="yyyy-mm-dd" name="'.$_filtro['campo'].'[]">
					</div>';
					break;
				case 'TEXTO':
					$_htmlForm .= '<label>'.strtoupper($_filtro['campo']).'</label><input type="text" class="form-control" value="" name="'.$_filtro['campo'].'">';
					break;
				case 'CATALOGO':
					$_modelo = "modelo".$_filtro['catalogo'];
					$_dataAsociada = "json".$_filtro['catalogo'];
					$this->_vista->$_dataAsociada = json_encode($this->$_modelo->get());
					//$_htmlForm .= '<label>'.strtoupper($_filtro['campo']).'</label><input type="text" class="form-control" value="" name="'.$_filtro['campo'].'">';
					break;
			}
		}
		$this->_vista->filtros = $_htmlForm;
		$this->vistaQuerysEjecutar;
	}
}