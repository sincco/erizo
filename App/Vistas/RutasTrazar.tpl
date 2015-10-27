<incluir archivo="Header">
<incluir archivo="Menu">
<div class="container">
  <div class="row">
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
    <p><a class="btn btn-primary btn-lg" href="#" onclick="trazar()" role="button"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Trazar</a></p>
  </div>
  <div class="row">
    <div class="col-lg-6 col-md-6 col-sm-12">
      <div id='map' style="width:100%; height:200px;"></div>
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
  
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 7,
    center: {lat: 41.85, lng: -87.65}
  });
  directionsDisplay.setMap(map);

  directionsService.route({
    origin: direcciones[0].direccion,
    destination: direcciones[ultima].direccion,
    waypoints: waypts,
    optimizeWaypoints: true,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    if (status === google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });

}

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWiQgw8USHlZh9y3sals_L-9ZiF1wSPTU&sensor=true" async defer></script>

<incluir archivo="Footer">
