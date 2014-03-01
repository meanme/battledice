###
User: mmarinucci
Copyright © mename 2014 All rights reserved
ResultsMode
###

define ['./../Core/GameMode'], () ->
    class ResultsMode extends GameMode

        constructor: () ->
            super

        setUp: () ->
            super()

            $("#results-mode").css('display', 'block')

            $('#resultBtn').click () ->
                GameManager.instance.popGameMode()


        cleanUp: () ->
            $("#results-mode").css('display', 'none')
            $('#resultBtn').unbind()
            super()

        init: (results) ->
            $("#matchSummary").empty()

            for result in results
                @setupResultDom result

        setupResultDom: (result) ->
            resultItem = $('<div></div>').addClass('roundSummary')

            hero0 = $('<div></div>').addClass('hero0')
            hero0.append $('<img/>', src: result.currentHero).addClass('heroPic')
            hero0.append $('<div></div>').addClass('diceSummary').text result.currentRoll
            hero0.append $('<div></div>').addClass('totalDamage').text result.currentDmg

            hero1 = $('<div></div>').addClass('hero1')
            hero1.append $('<img/>', src: result.opponentHero).addClass('heroPic')
            hero1.append $('<div></div>').addClass('diceSummary').text result.opponentRoll
            hero1.append $('<div></div>').addClass('totalDamage').text result.opponentDmg

            resultItem.append hero0
            resultItem.append hero1

            resultItem.append $('<div></div>').addClass('outcome').text result.outcome

            $("#matchSummary").append resultItem

        update: (time) =>


    root = exports ? window
    root.ResultsMode = ResultsMode