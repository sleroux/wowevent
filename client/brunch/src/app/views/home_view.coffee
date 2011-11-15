homeTemplate = require('templates/home')
NewEventView = require('views/new_event_view').NewEventView

class exports.HomeView extends Backbone.View
  id: 'home_view'

  events:
    'click #create_event': 'createEvent'
    
  initialize: (options) ->
    @locale = @options.locale
    @server = @options.server

  render: ->
    $(@el).empty()
    $(@el).html homeTemplate()
    @
    
  createEvent: ->   
    new NewEventView
      locale: @locale
      server: @server