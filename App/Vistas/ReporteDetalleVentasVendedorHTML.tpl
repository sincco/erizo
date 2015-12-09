<incluir archivo="Header">
<div class="panel panel-primary">
  <table class="table">
    <tr><td rowspan="4"><img src="{BASE_URL}html/img/logo.jpg" width="200px"><td><td>Vendedor</td><td>{vendedor}</td></tr>
    <tr><td></td><td>Ruta</td><td>{ruta}</td></tr>
    <tr><td></td><td>Emitido el </td><td><span id="fecha"></span></td></tr>
    <tr><td></td><td>Por</td><td>{usuario}</td></tr>
  </table>
</div>

<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Detalle de ventas</h3>
  </div>
  <table class="table table-bordered">
    <tr style="font-size:1.2em;">
      <td>Fecha</td><td>Producto</td><td>Cantidad</td><td>IVA</td><td>Subtotal</td>
    </tr>
  <ciclo detalle>
    <tr>
      <td>{fecha}</td><td>{producto}</td><td style="text-align:right;">{cantidad}</td><td style="text-align:right;">{iva}</td><td style="text-align:right;">{subtotal}</td>
    </tr>
  </ciclo detalle>
  </table>
</div>
  <br>
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Total de venta y comisión</h3>
  </div>
  <table class="table table-bordered">
    <tr style="font-size:1.2em;">
      <td>Total</td><td>Comision</td>
    </tr>
  <ciclo comisiones>
    <tr>
      <td style="text-align:right;">{venta}</td><td style="text-align:right;">{comision}</td>
    </tr>
  </ciclo comisiones>
  </table>
</div>


<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Detalle de mermas</h3>
  </div>
  <table class="table table-bordered">
    <tr style="font-size:1.2em;">
      <td>Fecha</td><td>Motivo</td><td>Producto</td><td style="text-align:right;">Cantidad</td>
    </tr>
  <ciclo mermas>
    <tr>
      <td>{fecha}</td><td>{motivo}</td><td>{producto}</td><td style="text-align:right;">{cantidad}</td>
    </tr>
  </ciclo mermas>
  </table>
</div>

<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Detalle de devoluciones</h3>
  </div>
  <table class="table table-bordered">
    <tr style="font-size:1.2em;">
      <td>Fecha</td><td>Producto</td><td style="text-align:right;">Cantidad</td>
    </tr>
  <ciclo devoluciones>
    <tr>
      <td>{fecha}</td><td>{producto}</td><td style="text-align:right;">{cantidad}</td>
    </tr>
  </ciclo devoluciones>
  </table>
</div>

<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Detalle de gastos</h3>
  </div>
  <table class="table table-bordered">
    <tr style="font-size:1.2em;">
      <td>Fecha</td><td>Gasto</td><td style="text-align:right;">Cantidad</td>
    </tr>
  <ciclo gastos>
    <tr>
      <td>{fecha}</td><td>{descripcion}</td><td style="text-align:right;">{monto}</td>
    </tr>
  </ciclo gastos>
  </table>
</div>
<br>
<div class="panel panel-success">
  <div class="panel-heading">
    <h3 class="panel-title">Total de gastos</h3>
  </div>
  <table class="table">
    <tr style="font-size:1.2em;">
      <td>Total</td>
    </tr>
  <ciclo totalGastos>
    <tr>
      <td style="text-align:right;">{monto}</td>
    </tr>
  </ciclo totalGastos>
  </table>
</div>
<br>
<div class="panel panel-warning">
  <div class="col-sm-6">Vendedor</div>
  <div class="col-sm-6">{vendedor}</div>
</div>
<script type="text/javascript">
var today = new Date()
var dd = today.getDate()
var mm = today.getMonth()+1
var yyyy = today.getFullYear()
if(dd<10) {
    dd='0'+dd
} 
if(mm<10) {
    mm='0'+mm
} 
today = mm+'/'+dd+'/'+yyyy
$("#fecha").html(today)
</script>