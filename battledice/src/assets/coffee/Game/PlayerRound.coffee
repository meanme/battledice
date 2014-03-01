###
User: mmarinucci
Copyright © mename 2014 All rights reserved
PlayerRound
###

define ['./../Game/Round'], () ->
    class PlayerRound extends Round

        constructor: ->
            super

        selectHero: () ->
            console.log 'PlayerRound - should select hero (timer)'
            super()

        heroSelectPhase: () ->
            @match.phaseCompleted(@)
            super()

        holdPhase: () ->
            console.log 'hold phase - player'
            super()

        rollPhase: () ->

            console.log 'enable roll phase = player'
            nextRoll = new Event 'round.rollPhase'
            window.dispatchEvent nextRoll

            window.addEventListener 'round.nextRoll', @nextRoll, false
            window.addEventListener 'round.resolve', @resolve, false

            @nextRoll()
            super()

        resolve: (event = null) =>
            console.log 'resolve data'
            console.log event

            @roll = event.data
            window.removeEventListener 'round.nextRoll', @nextRoll, false
            window.removeEventListener 'round.resolve', @resolve, false

            @match.phaseCompleted(@)

        resolvePhase: () ->
            console.log 'resolve phase - show player damage'

            result = @match.roundResult()

            $(".roundLabel").text "Round #{(result.roundNumber + 1)}"
            $(".roundDescription").text result.summary
            $('.roundOutcome').html result.outcome

            $('#roundResults > .roundOutcome').click =>
                $('#roundResults > .roundOutcome').unbind()
                $('#roundResults').fadeOut 500, =>
                    @match.phaseCompleted(@)

            $('#roundResults').fadeIn 'slow'

            # TODO - Should display result immediately
            # And wait for use input or timer to move next

            #@match.phaseCompleted(@)
            super()


    root = exports ? window
    root.PlayerRound = PlayerRound