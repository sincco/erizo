<incluir archivo="Header">
<div class="panel panel-primary">
  <table class="table">
    <ciclo cabecera>
      <tr><td rowspan="5"><img src="{BASE_URL}html/img/logo.jpg" width="200px"><td><td>Vendedor</td><td>{vendedor}</td></tr>
      <tr><td></td><td>Fecha </td><td>{fecha}</td></tr>
      <tr><td></td><td>Cotizacion </td><td>{venta}</td></tr>
      <tr><td></td><td>Cliente </td><td>{razonSocial}</td></tr>
      <tr><td></td><td>Atención </td><td>{contacto}</td></tr>
    </ciclo cabecera>
  </table>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title">Detalle de cotización</h3>
  </div>
  <table class="table">
    <tr style="font-size:1.2em;">
      <td>Producto</td><td>Precio</td>
    </tr>
  <ciclo cotizacion>
    <tr>
      <td>{descripcionCorta}</td><td style="text-align:right;">{precio}</td>
    </tr>
  </ciclo cotizacion>
  </table>
</div><br>

<div class="panel panel-warning">
  <div class="panel-heading">
  <h6 class="panel-title">Esta cotización tiene una vigencia de 30 días después de su emisión</h6>
  </div>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <a href="{url}">Da clic para ver completa esta cotización</a>
  </div>
</div>
