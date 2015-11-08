function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', function(){
      var place = autocomplete.getPlace();

      for (var i in place.address_components) {
        var component = place.address_components[i];
        for (var j in component.types) {
          var type_element = document.getElementById(id+'_'+component.types[j]);
          if (type_element) {
            type_element.value = component.long_name;
          }
        }
      }
    });
  }
}

google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('competition_start_location');
  initializeAutocomplete('competition_end_location');

  for (i=0; i<10; i++) {
    initializeAutocomplete('competition_tracks_attributes_'+i+'_start_location');
    initializeAutocomplete('competition_tracks_attributes_'+i+'_end_location');
  }
});