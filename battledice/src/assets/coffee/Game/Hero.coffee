###
User: mmarinucci
Copyright © mename 2013 All rights reserved
Hero
###

class Hero

    constructor: (@data) ->

        console.log @data
        @atk = @data.atk
        @skills = @data.skills

        @name = @data.name
        @picture = @data.picture
        @atk = @data.atk

    activateSkill: (level, roll) ->
        result = new Array()

        if @skills[level]?
            activationCount = @canAfford @skills[level].cost, roll
            for i in [0...activationCount]
                #console.log 'activating skill ' + level + " [" + activationCount + '] times'
                result.push @skills[level].effect

        result

    setupDom: (element) ->
        $(element).css 'display', 'block'

        $(element).find('.name').text @name
        $(element).find('.picture').attr 'src', @picture
        $(element).find('.atk').text "Atk: #{@atk}"

        # Setup skills
        skillsDom = $(element).find 'ul'

        for skill in @skills
            #skillDom = $('<li/>').addClass('skillEntry').text(skill.effect)
            skillDom = $('<li/>').addClass('skillEntry')

            # Add skill cost
            skillCostGroup = $('<div></div>').addClass('skillCost')

            for skillCost in skill.cost
                costIcon = $('<img>').addClass('diceRoll')
                costIcon.addClass("roll-#{skillCost}")
                skillCostGroup.append costIcon


            skillDom.append skillCostGroup
            skillDom.append $('<div></div>').addClass('skillEffect').text skill.effect

            skillsDom.append skillDom


    cleanupDom: (element) ->
        $(element).css 'display', 'block'
        $(element).css 'display', 'hidden'

        $(element).find('ul').empty()


    canAfford: (cost, rollSource) ->
        # Extract the cost
        roll = rollSource.slice 0

        result = 0

        # Check how many times the skill can be activated
        # Exit when no match has been found
        match = true
        while match
            for costDie in cost
                costIndex = roll.lastIndexOf costDie
                if costIndex isnt -1
                    roll.splice costIndex, 1
                else
                    match = false
                    break

            if match then result++

        result



    

root = exports ? window
root.Hero = Hero