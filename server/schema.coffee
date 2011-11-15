mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/wowevents_db_test'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

CharacterStub = new Schema
  id: ObjectId
  name: String
  locale: String
  server: String
  
mongoose.model 'CharacterStub', CharacterStub

Event = new Schema
  id: ObjectId
  title: String
  locale: String
  server: String
  created_by: String
  event_type: String
  start_date: String
  start_hour: Number
  start_minute: Number
  start_ampm: Number
  end_date: String
  end_hour: Number
  end_minute: Number
  end_ampm: Number
  description: String
  signups: [CharacterStub]
  
mongoose.model 'Event', Event