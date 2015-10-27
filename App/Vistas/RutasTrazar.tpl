<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <div class="row">
    <div id="errores"></div>
    <div class="col-lg-6 col-md-6 col-sm-12">
      <h5>Clientes</h5>
      <ul class="clientes ruta">
      <ciclo direcciones>
        <li data-direccion="{direccionFiscal}">{razonSocial}</li>
      </ciclo direcciones>
      </ul>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-12">
      <h5>Visitas</h5>
      <ul class="visitas ruta"></ul>
    </div>
    <hr>
    <p><a class="btn btn-primary btn-md" href="#" onclick="trazar()" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Trazar</a></p>
  </div>
  <div class="row">
    <div class="col-lg-8 col-md-8 col-sm-8">
      <div id='map' style="width:100%; height:300px;"></div>
    </div>
    <div class="col-lg-4 col-md-4 col-sm-4">
      <div id='ruta'></div>
    </div>
  </div>
</div>

<script type="text/javascript">
$(function () {
  $(".clientes, .visitas").sortable({
    connectWith: ".ruta"
  })
})

function trazar() {
  var direcciones = []
  var waypts = []
  $("ul.visitas").children().each(function() {
    var direccion = {cliente: $(this).text(), direccion: $(this).attr("data-direccion")}
    direcciones.push(direccion)
    waypts.push({
      location: $(this).attr("data-direccion"),
      stopover: true
    })
  })

  var ultima = direcciones.length-1

  if(ultima <= 0) {
    $("#errores").html('<div class="alert alert-warning" role="alert"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Arrastra los clientes a la sección de visitas, debes elegir al menos dos para crear una ruta</div>')
    return
  }

  $("#errores").html('')
  
  var directionsService = new google.maps.DirectionsService
  var directionsDisplay = new google.maps.DirectionsRenderer
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 7,
    center: {lat: 41.85, lng: -87.65}
  })
  directionsDisplay.setMap(map)
  directionsDisplay.setPanel(document.getElementById('ruta'))

  directionsService.route({
    origin: direcciones[0].direccion,
    destination: direcciones[ultima].direccion,
    waypoints: waypts,
    optimizeWaypoints: true,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    if (status === google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response)
    } else {
      window.alert('Directions request failed due to ' + status)
    }
  });

}

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWiQgw8USHlZh9y3sals_L-9ZiF1wSPTU&sensor=true&callback=trazar" async defer></script>

<incluir archivo="Footer">
