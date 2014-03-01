###
User: mmarinucci
Copyright © mename 2013 All rights reserved
CpuRound
###

define ['./../Game/Round'], () ->
    class CpuRound extends Round

        constructor: ->
            super

        selectHero: () =>
            console.log 'cpu needs to select hero'
            super()

        holdPhase: () ->
            #console.log 'hold phase - cpu'
            super()

        heroSelectPhase: () ->
            @match.phaseCompleted(@)
            super()

        rollPhase: () ->
            for i in [0...Round.DICE]
                die = Math.floor Math.random() * Round.DIE.length
                @roll.push Round.DIE[die]

            console.log @roll

            @match.phaseCompleted(@)
            super()

        resolvePhase: () ->
            console.log 'resolve phase - cpu'

            cpuRoll = new Event 'round.cpuRoll'
            cpuRoll.data = @roll
            window.dispatchEvent cpuRoll

            @match.phaseCompleted(@)
            super()

    

    root = exports ? window
    root.CpuRound = CpuRound