function gmapize(markers) {
  handler = Gmaps.build('Google', { markers: { clusterer: undefined  }});
  handler.buildMap({
  provider: {
    disableDefaultUI: true,
    zoomControl: true,
    scrollwheel: false
  },
    internal: { id: 'map' } }, function(){
    SeMarkers = handler.addMarkers(markers);
    handler.bounds.extendWith(SeMarkers);
    handler.fitMapToBounds();
  });
}
