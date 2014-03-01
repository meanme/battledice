# Example main.coffee file in /assets/js folder

# Required files
requiredFiles = ['Core/GameManager', 'Core/GameMode', 'Core/Player', 'Core/NetworkManager',
    'Game/Hero', 'Game/Match', 'Game/Round', 'Game/CpuRound', 'Game/PlayerRound',
    'GameModes/MainMode', 'GameModes/MatchMode', 'GameModes/ResultsMode', 'GameModes/MarketMode'
]

# Path mappings for module names not found directly under baseUrl
requirePaths =
    paths:
        jquery: "//cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min"
        underscore: "//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min"
        backbone: "//cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.2/backbone-min"

if jsPaths
    for own key, value of jsPaths
        # Fix up the lib references
        key = key.slice 4 if key.slice(0, 4) == "lib/"
        requirePaths.paths[key] = value

require.config
    paths: requirePaths.paths

    shim:
        jquery:
            exports: "$"
        underscore:
            exports: "_"
        backbone:
            deps: ["underscore", "jquery"]
            exports: "Backbone"


init = (element) ->

    player = new Player(window.playerJson)
    gameManager = new GameManager()

require requiredFiles, init