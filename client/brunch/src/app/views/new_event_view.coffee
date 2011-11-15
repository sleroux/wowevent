newEventTemplate = require('templates/new_event')
newEventSuccessTemplate = require('templates/new_event_success')
Event = require('models/event_model').Event

class exports.NewEventView extends Backbone.View
  id: 'new_event_view'
        
  initialize: (options) ->
    @locale = @options.locale
    @server = @options.server
    @render()      
        
  render: ->
    console.log "[Debug]", "Rendering create event div"
    $(@el).html newEventTemplate()
    $('body').append @el
    $("#start_datepicker").datepicker()
    $("#end_datepicker").datepicker()
    $(@el).dialog
      bgiframe: true
      autoOpen: false
      width: 500
      modal: true
      buttons: 
        "Create Event": =>
          @createEvent()
        "Cancel": =>
          $(@el).dialog("close")
    @
    $(@el).dialog("open")
  
  createEvent: ->
    console.log "[Debug]", "Creating a new event to submit"
        
    event = new Event()
    event.save(
      { 
        title: $('#title').val(),
        locale: @locale,
        server: @server,
        created_by: $('#created_by').val(),
        event_type: $('#event_type').val(),
        start_date: $('#start_datepicker').val(),
        start_hour: $('#start_hour').val(),
        start_minute: $('#start_minute').val(),
        start_ampm: $('#start_ampm').val(),
        end_date: $('#end_datepicker').val(),
        end_hour: $('#end_hour').val(),
        end_minute: $('#end_minute').val(),
        end_ampm: $('#end_ampm').val(),
        description: $('#description').val() 
      }
      ,
      {
        success: =>
          console.log "[Debug]", "Saved new event successfull!"
          app.collections.events.add(event)
          app.collections.events.fetch()
          
          @renderSuccess()
          
        error: =>
          console.log "[Debug]", "Error saving new event!"
          
          @renderFailure()
      })
        
  renderSuccess: ->
    console.log "[Debug]", "Rendering create event - Success!"
    $(@el).empty()
    $(@el).html newEventSuccessTemplate()
    $(@el).dialog
      bgiframe: true
      autoOpen: false
      height: 200
      modal: true
      buttons: 
        "Dismiss": =>
          $(@el).dialog("close")

  renderError: ->
    console.log "[Debug]", "Rendering create event - Error!"
  