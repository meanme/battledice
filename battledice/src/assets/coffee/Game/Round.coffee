###
User: mmarinucci
Copyright © mename 2013 All rights reserved
Round
###

class Round

    @DIE = ['r', 'r', 'y', 'b', 'a', 'a']
    @DICE = 6

    @PHASES = {'init', 'heroSelect', 'roll', 'resolve'}

    # @param Hero hero
    constructor: (@match, @hero, @attacker) ->

        @totalDamage = 0
        @roll = new Array()

        @hold = [false, false, false, false, false, false]
        @reroll = 0

        @currentPhase = Round.PHASES.init

    heroSelectPhase: () ->

    holdPhase: () ->

    rollPhase: () ->

    resolvePhase: () ->

    isAttacker: () ->
        @attacker is 1

    canReroll: () ->
        @reroll < 3

    nextRoll: () =>
        #console.log "next roll #{@reroll}"

        if @canReroll()
            rollEvent = new Event 'round.roll'
            window.dispatchEvent rollEvent
            @reroll++

            if @reroll is 3
                roundReady = new Event 'round.ready'
                window.dispatchEvent roundReady
        else
            throw "Round - Reroll max exceeded"

    resolveHeroDamage: () ->
        totalDamage = 0

        # Skills
        for skillLevel in [0..@hero.skills.length]
            effects = @hero.activateSkill skillLevel, @roll

            for effect in effects
                # TODO - Define possible effects and
                # influence over other gameplay components
                #console.log 'Skill damage: ' + (Number effect.split(':')[1])
                totalDamage += Number effect.split(':')[1]

        # Base damage
        totalDamage += @hero.atk for die in @roll when die is 'a'

        totalDamage


root = exports ? window
root.Round = Round