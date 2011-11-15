Event = require('models/event_model').Event
EventView = require('views/event_view').EventView

class exports.EventsView extends Backbone.View
  
  id: 'events_view'
  
  initialize: ->
    _.bindAll @, 'render'
    @collection.bind 'reset', => @render()
    @appendEl = @options.appendEl
    @render()
    
  add: (model) ->
    new Event
      model: model
  
  remove: (model) ->
    viewToRemove = @collection.select (m) ->
      m.model is model
    viewToRemove = viewToRemove[0]
    $(viewToRemove.el).remove()
  
  render: ->
    console.log '[Debug]', 'Rendering EventsView'

    @collection.each (model) =>
      modelView = new EventView
        model: model
        
      $(@appendEl).append modelView.el    
  
    @