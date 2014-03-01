mongoose = require 'mongoose'
config = require '../../config/config'

#
# Getters and setters for tags
#
getTags = (tags) ->
    return tags.join ','

setTags = (tags) ->
    return tags.split ','

#
# Player Schema
#
Schema = mongoose.Schema

PlayerSchema = new Schema
    username:
        type: String
        trim: true
        required: true
    heroes:
        type: Schema.Types.Mixed,
        default: {}
    activeSet: []
    xp:
        type: Number
        required: true
        default: 0
    level:
        type: Number
        required: true
        default: 1


PlayerSchema.pre 'save', (next) ->
    return next()

#
# Initialize player with a random deck
#
PlayerSchema.methods.initialize = () ->
    heroes = config.heroes

    for hero in heroes

        this.activeSet.push hero.name

        # Change to the global identifier for the hero progression
        this.heroes[hero.name] =
            level: 1
            stones: 0

    return

#
# Schema statics
#
PlayerSchema.statics =
    list: (cb) ->
        this.find().sort
            username: 1
        .exec(cb)
        return

Player = mongoose.model 'Player', PlayerSchema