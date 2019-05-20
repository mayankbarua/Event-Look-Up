/**
 * 
 */
function initMap(location){
      
	  var latVariable;
	  var langVariable;
	  axios.get('https://maps.googleapis.com/maps/api/geocode/json',{
        params:{
          address:location,
          key:'AIzaSyA99PthrWIUhjOqWLuEWSI1uzSycFucyeA'
        }
      })
      .then(function(response){

        latVariable = response.data.results[0].geometry.location.lat;
        langVariable = response.data.results[0].geometry.location.lng;
		console.log(latVariable+" "+langVariable)
		
		   var options = {
        zoom:16	,
        center:{lat:latVariable,lng:langVariable}
      }

      // New map
      var map = new google.maps.Map(document.getElementById('map'), options);

 

      
      // Add marker
      var marker = new google.maps.Marker({
        position:{lat:latVariable,lng: langVariable},
        map:map,
        icon:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
      });

      var infoWindow = new google.maps.InfoWindow({
        content:'<h1>Lynn MA</h1>'
      });

      marker.addListener('click', function(){
        infoWindow.open(map, marker);
      });
      

 	  
	  addMarker(marker);

      // Add Marker Function
		
      })
      .catch(function(error){
        console.log(error);
      });
	
	function addMarker(props){
        var marker = new google.maps.Marker({
          position:props.coords,
          map:map,
          //icon:props.iconImage
        });

        // Check for customicon
        if(props.iconImage){
          // Set icon image
          marker.setIcon(props.iconImage);
        }

        // Check content
        if(props.content){
          var infoWindow = new google.maps.InfoWindow({
            content:props.content
          });

          marker.addListener('click', function(){
            infoWindow.open(map, marker);
          });
        }
      }
	  
    }