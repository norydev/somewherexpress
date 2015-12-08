function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['(cities)'] });
    google.maps.event.addListener(autocomplete, 'place_changed', function(){
      var place = autocomplete.getPlace();

      for (var i in place.address_components) {
        var component = place.address_components[i];
        for (var j in component.types) {
          // Long name for country and admn area
          var type_element = document.getElementById(id.replace( /name/g, '' ) + component.types[j]);
          if (type_element) {
            type_element.value = component.long_name;
          }
          // Short name for country and admn area
          var type_element = document.getElementById(id.replace( /name/g, '' ) + component.types[j] + '_short');
          if (type_element) {
            type_element.value = component.short_name;
          }
        }
      }
    });
  }
}

google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('competition_start_city_attributes_name');
  initializeAutocomplete('competition_end_city_attributes_name');
});