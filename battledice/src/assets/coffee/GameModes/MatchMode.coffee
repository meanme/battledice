###
User: mmarinucci
Copyright © mename 2013 All rights reserved
MatchMode
###

define ['./../Core/GameMode'], () ->
    class MatchMode extends GameMode

        constructor: () ->
            @match = new Match window['heroesCatalog']

        setUp: () ->
            super
            $("#match-mode").css('display', 'block')

            @match.hero0.setupDom $("#hero0")[0]
            @match.hero1.setupDom $("#hero1")[0]

            $("#diceContainer").empty()

            window.addEventListener 'round.roll', @rollDice, false
            window.addEventListener 'round.ready', @roundReady, false
            window.addEventListener 'round.rollPhase', @enableRoll, false
            window.addEventListener 'round.reset', @roundReset, false

            window.addEventListener 'round.cpuRoll', @enemyRoll, false

            # Whether the player is ready to resolve the round or is out of rerolls
            @isReady = false

            @match.nextRound()

        enemyRoll: (event) =>
            diceRoll = event.data
            diceContainer = $("#enemyContainer")

            diceContainer.empty()

            for die in diceRoll
                console.log 'die ' + die
                dieDom = $('<button>').addClass('diceRoll')
                dieDom.addClass("roll-#{die}").attr 'die', die
                dieDom.attr 'disabled', 'disabled'

                diceContainer.append dieDom

            $('#enemyRoll').fadeIn 'slow'

        roundReset: =>
            # Re-enable event listeners
            window.addEventListener 'round.rollPhase', @enableRoll, false
            window.addEventListener 'round.ready', @roundReady, false

            # Remove all the dice from the board
            $("#diceContainer").empty()

            $("#enemyRoll").css 'display', 'none'

            # Restore button
            $("#reRoll").unbind 'click'
            $('#reRoll').text 'Roll Again'
            $("#reRoll").removeClass 'pure-button-disabled'

        enableRoll: =>
            $("#reRoll").unbind 'click'
            $("#reRoll").click () =>
                @moveNext()
            window.removeEventListener 'round.rollPhase', @enableRoll, false

        moveNext:() ->
            if @match.currentRound.canReroll() and not @isReady
                nextRoll = new Event 'round.nextRoll'
                window.dispatchEvent nextRoll
            else
                @readyAccept()

        readyAccept: () ->
            $("#reRoll").addClass 'pure-button-disabled'

            $("#reRoll").unbind 'click'

            # Get the dice values
            diceContainer = $("#diceContainer")
            finalRoll = new Array()
            for die in diceContainer.children '.diceRoll'
                finalRoll.push $(die).attr 'die'

            resolveEvent = new Event 'round.resolve'
            resolveEvent.data = finalRoll
            window.dispatchEvent resolveEvent

        rollDice: () =>
            diceContainer = $("#diceContainer")
            previousRoll = diceContainer.children '.diceRoll'

            # Get the dice to roll from the current round

            for i in [0...@match.currentRound.hold.length]
                if not @match.currentRound.hold[i]

                    # TODO - should skip dice on hold
                    setTimeout ( (index) =>
                        =>
                            previousRollDie = previousRoll[index]
                            currentRound = @match.currentRound

                            die = Math.floor Math.random() * Round.DIE.length
                            rollValue = Round.DIE[die]

                            # Update the previous die if present
                            if previousRollDie?

                                # Remove the previous die value class
                                for dieFace in Round.DIE
                                    $(previousRollDie).removeClass("roll-#{dieFace}")

                                $(previousRollDie).addClass("roll-#{rollValue}").attr 'die', rollValue
                            else
                                die = $('<button>').addClass('diceRoll')
                                die.addClass("roll-#{rollValue}").attr 'die', rollValue

                                die.click (event) =>

                                    # Update button if every dice is selected
                                    $(event.target).toggleClass("holdDice")
                                    currentRound.hold[index] = not currentRound.hold[index]
                                    @checkReady()

                                diceContainer.append die

                    )(i), i * 200

        checkReady: () =>
            @isReady = $('.holdDice').length is $('#diceContainer > .diceRoll').length or not @match.currentRound.canReroll()
            if @isReady then $("#reRoll").text 'Ready' else $('#reRoll').text 'Roll Again'

        roundReady: () =>
            window.removeEventListener 'round.ready', @roundReady, false

            $("#reRoll").text 'Ready'
            ###$("#reRoll").unbind 'click'

            $("#reRoll").click () =>
                @readyAccept()###

        cleanUp: () ->
            super

            window.removeEventListener 'round.roll', @rollDice, false

            $("#match-mode").css('display', 'none')

            $("#diceContainer").empty()
            $("#reRoll").removeClass 'pure-button-disabled'

            # Clear heroes DOM elements
            @match.hero0.cleanupDom $("#hero0")[0]
            @match.hero1.cleanupDom $("#hero1")[0]


        update: (time) =>



    root = exports ? window
    root.MatchMode = MatchMode