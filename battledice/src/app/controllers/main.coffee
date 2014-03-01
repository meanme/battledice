mongoose = require 'mongoose'
_ = require 'underscore'

Player = mongoose.model 'Player'

config = require '../../config/config'

exports.index = (req, res) ->

    if req.user? and req.user.username?
        Player.findOne {username : req.user.username}, (err, player) ->

            playerHeroes = new Array()
            for key,value of player.heroes
                playerHeroes.push
                    name: key
                    stones: value.stones
                    level: value.level

            # TODO - Consolidate in one object
            res.render 'modes/main',
                heroes: playerHeroes
                heroesCatalog: config.heroes

                playerJson: player
                activeSet: player.activeSet
                level: player.level
                xp: player.xp
                username: player.username


    else
        res.render 'modes/main'


    return