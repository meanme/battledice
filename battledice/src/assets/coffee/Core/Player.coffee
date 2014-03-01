###
User: mmarinucci
Copyright © mename 2014 All rights reserved
Player
###

class Player

    @instance = null

    constructor: (playerJson) ->
        Player.instance = this

        @username = null
        @id = null
        # Heroes unlcoked by the player
        @heroes = null
        # Currently active heroes
        @activeSet = null

        @level = 0
        @xp = 0

        @deserializeJson playerJson

    deserializeJson: (playerJson) ->
        @username = playerJson.username
        @id = playerJson.id

        @heroes = playerJson.heroes
        @activeSet = playerJson.activeSet

        @level = playerJson.level
        @xp = playerJson.xp

    getHero: (heroId) ->
        @heroes[heroId]

    @getHeroByName: (name) ->
        res = null
        for hero in window['heroesCatalog']
            if hero.name is name
                console.log 'hero ' + name + ' found'
                res = hero
                break
        return res

    addXp: (xpDelta) ->
        console.log 'add xp'

root = exports ? window
root.Player = Player