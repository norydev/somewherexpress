function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['(cities)'] });
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();

      var pic_field = document.getElementById(id.replace( /name/g, '' ) + "picture");
      pic_field.value = place.photos[0].getUrl({ 'maxWidth': 800 });

      _.each(place.address_components, function(component) {
        _.each(component.types, function(type) {
          // Long name for country and admn area
          var type_element = document.getElementById(id.replace( /name/g, '' ) + type);
          if (type_element) {
            type_element.value = component.long_name;
          }
          // Short name for country and admn area
          var type_element = document.getElementById(id.replace( /name/g, '' ) + type + '_short');
          if (type_element) {
            type_element.value = component.short_name;
          }
        });
      });
    });
  }
}

google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('competition_start_city_attributes_name');
  initializeAutocomplete('competition_end_city_attributes_name');
});
