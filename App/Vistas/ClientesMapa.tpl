<incluir archivo="Header">
<incluir archivo="Menu">

<div id='map' style="width:600px; height:400px;"></div>

<script type="text/javascript">
 
var map;
 
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 13
  });
  var infoWindow = new google.maps.InfoWindow({map: map});

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindow.setPosition(pos);
      infoWindow.setContent('Tu ubicación.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }
  var geocoder = new google.maps.Geocoder()
  var direcciones = {direcciones}
    $.each(direcciones, function(index,direccion) {
        //console.log(direccion.direccion)
        geocoder.geocode({'address': direccion.direccionFiscal}, geocodeResult)
    })
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}
 
function geocodeResult(results, status) {
    // Verificamos el estatus
    if (status == 'OK') {
    	console.log(results)
        // Si hay resultados encontrados, centramos y repintamos el mapa
        // esto para eliminar cualquier pin antes puesto
        var mapOptions = {
            center: results[0].geometry.location,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // map = new google.maps.Map($("#map_canvas").get(0), mapOptions);
        // fitBounds acercará el mapa con el zoom adecuado de acuerdo a lo buscado
        //map.fitBounds(results[0].geometry.viewport);
        // Dibujamos un marcador con la ubicación del primer resultado obtenido
        var markerOptions = { position: results[0].geometry.location, title: results[0].formatted_address, label: results[0].formatted_address }
        var marker = new google.maps.Marker(markerOptions);
        marker.setMap(map);
    } else {
        // En caso de no haber resultados o que haya ocurrido un error
        // lanzamos un mensaje con el error
        alert("Geocoding no tuvo éxito debido a: " + status);
    }
}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWiQgw8USHlZh9y3sals_L-9ZiF1wSPTU&sensor=true&callback=initMap" async defer></script>

<incluir archivo="Footer">