class exports.Event extends Backbone.Model
  
  url: -> [
        app.config.hostname
        '/event'
        ].join ''
    
  signupCharacter: (model) ->
    