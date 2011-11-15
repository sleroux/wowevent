window.app = {}
app.config = {}
app.routers = {}
app.models = {}
app.collections = {}
app.views = {}
app.utils = {}

MainRouter = require('routers/main_router').MainRouter
HomeView = require('views/home_view').HomeView
EventView = require('views/event_view').EventView
EventsView = require('views/events_view').EventsView
NewEventView = require('views/new_event_view').NewEventView
Events = require('collections/events_collection').Events
DateUtils = require('utils/dateutils').DateUtils
EventUtils = require('utils/eventutils').EventUtils

# app bootstrapping on document ready
$(document).ready ->
  app.initialize = ->
    app.config.hostname = 'http://localhost:5678'
    app.config.blizzard = 
      battlenet: '.battle.net'
      character: '/api/wow/character/'
    
    app.routers.main = new MainRouter()
    app.utils.date = new DateUtils()
    app.utils.event = new EventUtils()
    app.views.home = new HomeView
      server: 'The Forgotten Coast'
      locale: 'US'
              
    app.routers.main.navigate 'home', true if Backbone.history.getFragment() is ''
    
    # load up the events
    app.collections.events = new Events()
    app.collections.events.fetch 
      success: (collection) ->
        console.log "[Debug]", "Got the events -> " + JSON.stringify collection
        
        app.views.events ||= new EventsView
          collection: collection
          appendEl: $('body')
        
      error: (error) ->
        console.log "[Error]", "Failed to get any events -> " + error
    
  app.initialize()
  Backbone.history.start()
