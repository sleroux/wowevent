eventInfoTemplate = require('templates/event_info')

class exports.EventInfoView extends Backbone.View
  id: 'event_info'

  initialize: (options) ->
    @event = @options.event
    @render()
  
  render: ->
    console.log "[Debug]", "Rendering EventInfoView"
    $(@el).html  eventInfoTemplate(event: @event.toJSON())
    @
