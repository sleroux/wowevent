signupTemplate = require('templates/signup')
characterStubTemplate = require('templates/character_stub')
Character = require('models/character_model').Character

class exports.SignupView extends Backbone.View
  id: 'signup_view'
  
  events:
    'click #get_character': 'getCharacter'
  
  character: {}
  
  initialize: (options) ->
    @event = @options.event
    @render()
  
  render: ->
    console.log "[Debug]", "Rendering EventView"
    $(@el).html  signupTemplate()
    $('body').append @el
    $(@el).dialog
      bgiframe: true
      autoOpen: false
      height: 150
      width: 400
      modal: true
      buttons: 
        "Signup": =>
          @finishSignup()
        "Cancel": =>
          $(@el).dialog("close") 
               
    $(@el).dialog("open")
    @
    
  finishSignup: ->
    console.log "[Debug]", "Signing up character..."
    
    # Send stub of character to server for event registration
    stub = 
      name: @character.name
      locale: @character.locale
      server: @character.server
        
    request = $.ajax 
      type: 'PUT'
      headers:
        'Content-Type': 'application/json'
      data: JSON.stringify stub
      url: [ 
        app.config.hostname
        '/events/'
        @character.locale
        '/'
        @character.server
        '/'
        @event.get '_id'
        '/signup'
        ].join ''
        
      success: (body) =>
        console.log "[Debug]", "Signed up " + @character.name + " successfully!"
             
  getCharacter: ->
    console.log "[Debug]", "Hit the WoW Character API like you mean it"
        
    @character = new Character 
      name: $('#character_name').val()
      locale: 'us'
      server: 'The Forgotten Coast'
    
    @character.fetch
      success: (model, response) =>   
        @showCharacterStub model
        
      error: (model, response) =>
        console.log "[Debug]", "Failed to get character data!"
        @showFail
    
  showCharacterStub: ->
    @character.formatted_thumbnail = [
        'http://'
        @character.locale
        app.config.blizzard.battlenet
        '/static-render/'
        @character.locale
        '/'
        @character.get 'thumbnail'
      ].join ''
      
    $(@el).append characterStubTemplate(character:  @character.toJSON())
    $('#character_thumbnail').attr "src",  @character.formatted_thumbnail
        
  showFail: ->
  
    
  
      
      