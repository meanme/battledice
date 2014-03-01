###
User: matteo
Copyright © mename 2013 All rights reserved
GameManager
###

class GameManager

    @instance = null
    @config = null
    @DEBUG = false

    constructor: () ->
        @gameModes = new Array()
        GameManager.instance = this
        GameManager.instance.pushGameMode new MainMode()

        requestAnimFrame @update

    # Clean previous game mode and activate the new one
    pushGameMode: (gameMode) ->
        if @gameModes.length > 0
            @gameModes[@gameModes.length-1].cleanUp()

        gameMode.setUp()
        @gameModes.push gameMode

    popGameMode: () ->
        if @gameModes.length > 0
            gameMode = @gameModes.pop()
            if gameMode? then gameMode.cleanUp()

        if @gameModes.length > 0
            @gameModes[@gameModes.length-1].setUp()

    update: (time) =>
        # place the rAF *before* the render() to assure as close to
        # 60fps with the setTimeout fallback.
        requestAnimFrame @update

        if @gameModes.length > 0
            @gameModes[@gameModes.length-1].update(time)

    # Reflection like helper function to instantiate objects
    @instantiate: (className, params...) ->
        root = exports ? window
        classType = root[className]
        new classType(params...)


root = exports ? window
root.GameManager = GameManager