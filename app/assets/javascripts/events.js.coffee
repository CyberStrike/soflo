# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  if $('#event_location')[0]?
    @autocomplete

    automagic = ()->
      # Create the autocomplete object, restricting the search
      # to geographical location types.
      @autocomplete = new google.maps.places.Autocomplete((document.getElementById("event_location")))

      # When the user selects an address from the dropdown,
      # populate the address fields in the form.
      google.maps.event.addListener autocomplete, "place_changed", ->
        fillInAddress()

    fillInAddress = () ->
      # Get the place details from the autocomplete object.
      place = @autocomplete.getPlace()

      # Build Location Object
      location=
        streetNumber: place.address_components[0].long_name
        street: place.address_components[1].short_name
        city: place.address_components[2].short_name
        state: place.address_components[3].short_name
        zip: place.address_components[5].short_name
        country: place.address_components[4].short_name
        streetAddr: ->
          this.streetNumber + " " + this.street

      # Build Static Map
      staticMap =
        baseurl: "https://maps.googleapis.com/maps/api/staticmap?"
        location: "center=" + place.formatted_address
        options: "&zoom=18&size=640x320&maptype=roadmap"
        markers: "&markers=color:red|#{place.geometry.location.toUrlValue()}"

      mapImage = staticMap.baseurl + staticMap.location + staticMap.options + staticMap.markers

      $('#location_addr').html(
        "<h4>#{place.name}</h4>" + "<p>#{location.streetAddr()}" + "<br>" + "#{location.city + ', ' + location.state}</p>")


      addMap(mapImage)

    addMap = (mapImage)->
      $mapItem = $('#location_map')
      $mapItem
        .slideUp complete: ->
          $(this).html("<img class='img-responsive center-block' src=#{encodeURI(mapImage)}>")
          $(this).slideDown()

    # Bias the autocomplete object to the user's geographical location,
    # as supplied by the browser's 'navigator.geolocation' object.
    geolocate = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position) ->
          geolocation = new google.maps.LatLng(
            position.coords.latitude,
            position.coords.longitude)
          @autocomplete.setBounds new google.maps.LatLngBounds(
            geolocation, geolocation)
    # Enable autocomplete when focused
    $('#event_location').on "focusin", (e)->
      automagic()
      geolocate()
      # Stop enter from submitting while autocompleting
      $('#event_location').on "keypress", (e)->
        if event.keyCode == 13
          e.stopPropagation()
          e.preventDefault()
