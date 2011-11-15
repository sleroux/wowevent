EventInfoView = require('views/event_info').EventInfoView

class exports.MainRouter extends Backbone.Router
  routes :
    "home": "home"
    "eventinfo/:eventId": "event_info"

  home: ->
    $('body').html app.views.home.render().el

  event_info: (eventId) ->
    # Generate a new event info view based on the event id 
    console.log "[Debug]", "Navigated to the event info page for " + eventId
  
    
    
