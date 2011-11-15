eventTemplate = require('templates/event')
SignupView = require('views/signup_view').SignupView

class exports.EventView extends Backbone.View
  id: 'event_view'
  
  events:
    'click #sign_up': 'signup'
    'click #view_info': 'view_info'
    
  initialize: ->
    @render()
  
  render: ->
    console.log "[Debug]", "Rendering EventView"
    $(@el).html  eventTemplate(event: @model.toJSON(), dateutils: app.utils.date, eventutils: app.utils.event)
    @
    
  signup: ->
    console.log "[Debug]", "Signing up for event"
    new SignupView
      event: @model
      
  view_info: ->
    # Navigate to full event view for this event
    eventId = @model.get '_id'
    app.routers.main.navigate "eventinfo/#{eventId}", true
    