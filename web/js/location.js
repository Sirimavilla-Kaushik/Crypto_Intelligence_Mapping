var map = null;
        var latLong =null;
			function showlocation() {
			   // One-shot position request.
			    navigator.geolocation.getCurrentPosition(callback);
			}
    	
      function callback(position) {
      	
      	var lat = position.coords.latitude;
      	var lon = position.coords.longitude;
      	            document.getElementById("lat").value=lat;
                     document.getElementById("lan").value=lon;

           	latLong	= new google.maps.LatLng(lat, lon);
       
      	   var latlng = new google.maps.LatLng(lat, lon);
           var  geocoder = new google.maps.Geocoder();
            geocoder.geocode
            ({ 'latLng': latlng }, 
            function (results, status)
            {
                var add=document.getElementById("loc1").value=results[0].formatted_address;
                alert(add); 
            });
            var addr=document.getElementById("loc1").value;
            if(addr === '' || addr === null || addr === undefined){
              tt.services.reverseGeocode({key:"1MmbJI1SBWF7Yht63JQXbpE5Yp5BvAge",   position: latLong})

                                        .go()
                                        .then(function (results) {
                                       // alert("success");
                                        var add=document.getElementById("loc1").value=results.addresses[0].address.freeformAddress;
                                    //alert(add); 
                                        //alert(results.addresses[0].address.freeformAddress);
                                    });
            initMap();
        }  }
      function initMap() {
        var mapOptions = {
          center: latLong,
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map-canvas"), 
                                          mapOptions);
     var marker = new google.maps.Marker({
				    position: latLong
				});      
				
				marker.setMap(map);
                                     	map.setZoom(8);
      	map.setCenter(marker.getPosition());
      } 
  
      //   google.maps.event.addDomListener(window, 'load', initMap);