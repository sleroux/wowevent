Event = require('models/event_model').Event

class exports.Events extends Backbone.Collection
  
  model: Event

  url: -> [
        app.config.hostname
        '/events/US/The Forgotten Coast'
        ].join ''
