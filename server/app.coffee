require 'zappa'

mongoose = require 'mongoose'
def mongoose: mongoose

_ = require 'underscore'
def _: _

mongoose.connect 'mongodb://localhost/wowevents_db_test'

include 'schema.coffee'

def dstruct: (obj, obj_to_merge) ->
  _.extend obj, obj_to_merge

get '/events/:locale/:server': ->
  Events = mongoose.model('Event')
  Events.find({ locale: @locale, server: @server }).execFind (err, docs) ->
    response.send docs
    
get '/events/:eventId': ->
  Events = mongoose.model('Event')
  Events.findById @eventId, (err, event) ->
    response.send event
  
put '/events/:locale/:server/:eventId/signup': ->
  Events = mongoose.model('Event')
  Events.findById @eventId, (err, event) ->
    CharacterStubs = mongoose.model('CharacterStub')
    stub = new CharacterStubs()

    dstruct stub, request.body

    # Only generate a new stub in the DB if we don't have one for this character
    CharacterStubs.findOne { name: stub.name, locale: stub.locale, server: stub.server }, (err, searchstub) ->
      if searchstub == null  
        stub.save (err) ->
          console.log 'Created a new character stub to the DB: ' + JSON.stringify stub unless err
              
    # Scan the signups for this dude using the name, locale, and server
    # as the key.
    res = true
    _.each event.signups, (signup) ->
      if signup.name is stub.name and signup.locale is stub.locale and
      signup.server is stub.server 
        res = false
    
    if res
      event.signups.push stub            
      event.save (err) ->
        console.log 'Added character stub to event: ' + JSON.stringify stub unless err
    else
      console.log 'Character already part of event!' 
      
    response.send event
    
post '/event': ->
  model = mongoose.model('Event') 
  event = new model()
    
  dstruct event, request.body
  
  event.save (err) ->
    console.log 'Created event: ' + JSON.stringify event unless err
    
  response.send event  