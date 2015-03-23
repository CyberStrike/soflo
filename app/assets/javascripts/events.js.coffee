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

      console.log place

      # Build Static Map
      staticMap =
        baseurl: "https://maps.googleapis.com/maps/api/staticmap?"
        location: "center=" + place.geometry.location
        options: "&zoom=18&size=640x320&maptype=roadmap"
        markers: "&markers=color:red|#{place.geometry.location.toUrlValue()}"

      mapImageUrl = staticMap.baseurl + staticMap.location + staticMap.options + staticMap.markers

      location = locationAdapter(place)

      $('#location_addr').html(
          "<h4>#{place.name}</h4>" + "<p>#{location.streetAddr()}" + "#{ if location.unit? then (' #' + location.unit) else '' }" + "<br>" + "#{location.city + ', ' + location.state}</p>")


      addMap(mapImageUrl)
      setLocationInfo(location)


    addMap = (mapImageUrl)->
      $mapItem = $('#location_map')
      $mapItem
        .slideUp complete: ->
          $(this).html("<img class='img-responsive center-block' src=#{encodeURI(mapImageUrl)}>")
          $(this).slideDown()

    # Build Location Object
    locationAdapter = (place) ->
      location =
        name: place.name
        unit: undefined
        streetNumber: ''
        street: ''
        city:''
        state: ''
        zip: ''
        country: ''
        longAddress: place.formatted_address
        streetAddr: ->
          this.streetNumber + " " + this.street

      for component in place.address_components
        address_type = component.types[0]
        location.unit = component.long_name if address_type == "subpremise"
        location.streetNumber = component.long_name if address_type == "street_number"
        location.street = component.short_name if address_type == "route"
        location.city = component.short_name if address_type == "locality"
        location.state = component.short_name if address_type == "administrative_area_level_1"
        location.zip = component.short_name if address_type == "postal_code"
        location.country = component.short_name if address_type == "country"

      return location

    setLocationInfo = (location) ->
      $('#event_location_name').val location.name
      $('#event_location_streetnumber').val location.streetNumber
      $('#event_location_street').val location.street
      $('#event_location_city').val location.city
      $('#event_location_state').val location.state
      $('#event_location_zip').val location.zip
      $('#event_location_country').val location.country

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
