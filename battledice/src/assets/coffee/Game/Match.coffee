###
User: mmarinucci
Copyright © mename 2013 All rights reserved
Match
Every match is best out of 3 Rounds
###

class Match

    @PHASES = [
        id: 'init'
        simulataneous: true
        function: 'initPhase'
    ,
        id: 'heroSelect'
        simulataneous: false
        function: 'heroSelectPhase'
    ,
        id: 'roll'
        simulataneous: true
        function: 'rollPhase'
    ,
        id: 'resolve'
        simulataneous: true
        function: 'resolvePhase'
    ]

    constructor: (@deck) ->

        # Determines what hero goes first
        @attacker = 1
        @isCpu = true

        @currentPhase = 0

        @rounds = new Array()
        @results = new Array()
        @currentRound = null
        @opponentRound = null

        # Heroes catalogue
        @deck = Match.shuffle deck

        # Should use the active set
        # For now pick a random hero from the unlocked set
        playerHeroes = (name for name,hero of Player.instance.heroes)
        selectedHero = Player.getHeroByName playerHeroes[Math.floor(Math.random() * playerHeroes.length)]

        @ready = [false, false]

        #@hero0 = new Hero @deck[0]
        @hero0 = new Hero (selectedHero?= @deck[0])
        @hero1 = new Hero @deck[1]

    nextRound: () ->
        @opponentRound = new CpuRound @, @hero1, (@attacker^1)
        @currentRound = new PlayerRound @, @hero0, @attacker

        @nextPhase()

        #TODO - Alternate attackers only for PVP rounds
        #@attacker ^= 1

    nextPhase: ->
        @currentPhase++
        @ready = [false, false]

        if(@currentPhase >= Match.PHASES.length)
            @endRound()
            return

        else
            console.log "About to process phase #{Match.PHASES[@currentPhase].id}"

            phase = Match.PHASES[@currentPhase]

            if(phase.simulataneous)
                @currentRound[phase.function]()
                @opponentRound[phase.function]()

            else
                @currentRound[phase.function]()
                @opponentRound.holdPhase()

    roundResult: () ->
        currentDmg = @currentRound.resolveHeroDamage()
        opponentDmg = @opponentRound.resolveHeroDamage()

        result =
            roundNumber: @rounds.length
            summary: "#{@currentRound.hero.name} (#{currentDmg}) VS #{@opponentRound.hero.name} (#{opponentDmg})"
            outcome: (if (currentDmg > opponentDmg) then "Win" else (if (opponentDmg > currentDmg) then "Lose" else "Tie"))
            currentHero: @currentRound.hero.picture
            currentRoll: @currentRound.roll
            currentDmg: currentDmg
            opponentHero: @opponentRound.hero.picture
            opponentRoll: @opponentRound.roll
            opponentDmg: opponentDmg



    endRound: () ->
        currentDmg = @currentRound.resolveHeroDamage()
        opponentDmg = @opponentRound.resolveHeroDamage()

        #TODO - Use player ids instead of heroes
        if currentDmg > opponentDmg
            @rounds.push @currentRound.hero.name
        else if opponentDmg > currentDmg
            @rounds.push @opponentRound.hero.name
        else if currentDmg is opponentDmg
            @rounds.push 'tie'

        currentId = @currentRound.hero.name
        opponentId = @opponentRound.hero.name

        currentVictories = $.grep @rounds, (winnerId) ->
            winnerId is currentId
        opponentVictories = $.grep @rounds, (winnerId) ->
            winnerId is opponentId

        winner = false

        if (currentVictories - opponentVictories) >= 2
            console.log 'player won'
            winner = true
        if (opponentVictories - currentVictories) >= 2
            console.log 'opponent won'
            winner = true

        if @rounds.length is 3 and not winner
            console.log 'tie!'
            winner = true

        @results.push @roundResult()

        if not winner
            @currentPhase = 0
            roundReset = new Event 'round.reset'
            window.dispatchEvent roundReset
            @nextRound()
        else
            GameManager.instance.popGameMode()
            resultsMode = new ResultsMode()
            GameManager.instance.pushGameMode resultsMode
            resultsMode.init @results


    phaseCompleted: (round) ->
        console.log 'phase ' + Match.PHASES[@currentPhase].id + ' completed by round attacker: ' + round.isAttacker()
        @ready[round.attacker] = true

        phase = Match.PHASES[@currentPhase]

        if @ready[0] and @ready[1]
            @nextPhase()

        else if(round.isAttacker()) and not phase.simulataneous
            round.holdPhase()
            @opponentRound[phase.function]()

    @shuffle : (o) ->
        j = undefined
        x = undefined
        i = o.length

        while i
            j = Math.floor(Math.random() * i)
            x = o[--i]
            o[i] = o[j]
            o[j] = x
        o


root = exports ? window
root.Match = Match