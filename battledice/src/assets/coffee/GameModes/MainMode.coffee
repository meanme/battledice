###
User: mmarinucci
Copyright © mename 2013 All rights reserved
MainMode
###

define ['./../Core/GameMode'], () ->
    class MainMode extends GameMode

        constructor: () ->
            super

        setUp: () ->
            super()

            document.addEventListener "touchmove", ((e) ->
                e.preventDefault()
            ), false

            $('#playBtn').click () ->
                GameManager.instance.pushGameMode new MatchMode()

            $('#testResults').click () ->
                GameManager.instance.pushGameMode new ResultsMode()

            $("#main-mode").css('display', 'block')

            $('.heroProfile > input:checkbox').click @heroSelectionChange

            @setupHeroes()

        cleanUp: () ->
            document.removeEventListener "touchmove", ((e) ->
                e.preventDefault()
            ), false

            $("#main-mode").css('display', 'none')

            $('#playBtn').unbind 'click'
            $('#testResults').unbind 'click'

            $('.heroPreviewLocked').removeClass 'heroPreviewLocked'

            super()

        heroSelectionChange: (event) =>
            event.preventDefault()
            console.log event.target.id

        setupHeroes: () ->
            for heroProfile in $(".heroProfile")
                heroId = $(heroProfile).find('input:hidden').val()

                playerHero = Player.instance.getHero(heroId)
                if playerHero?
                    $(heroProfile).find('.heroLevel').text playerHero.level

                    # Check if the hero is part of the active set
                    if $.inArray heroId, Player.instance.activeSet > -1
                        $(heroProfile).find('input:checkbox').attr 'checked', true
                    else
                        $(heroProfile).find('input:checkbox').attr 'checked', false
                else
                    $(heroProfile).addClass 'heroPreviewLocked'

        setupActiveSet: () ->
            console.log 'main mode - setup active set'

        update: (time) =>
    

    root = exports ? window
    root.MainMode = MainMode