class exports.Character extends Backbone.Model

  initialize: (options) ->
    @locale = options.locale
    @server = options.server
    @name = options.name
    
    console.log "[Debug]", options

  url: -> 
    [
      'http://'
      @locale
      app.config.blizzard.battlenet
      app.config.blizzard.character # /api/wow/character/
      @server
      '/'
      @name
    ].join ''
    