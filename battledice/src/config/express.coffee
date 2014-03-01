express = require 'express'

mongoStore = require('connect-mongo')(express)
flash = require 'connect-flash'
helpers = require 'view-helpers'

assets = require 'connect-assets'
jsPaths = require "connect-assets-jspaths"


path = require 'path'

module.exports = (app, config, passport) ->

    console.log 'assets directory: '
    console.log path.join(__dirname, '../assets')
    app.set('showStackError', true)

    app.use(express.compress({
        filter: (req, res) ->
            return /json|text|javascript|css/.test(res.getHeader('Content-Type'))
        level: 9
    }))

    app.set('views', config.root + '/app/views')
    app.set('view engine', 'jade')

    app.configure ->
        app.use(helpers(config.app.name))
        app.use(express.cookieParser())
        app.use(express.bodyParser())

        # Support for using PUT, DEL etc. in forms using hidden _method field
        app.use(express.methodOverride())

        app.use(express.session({
            secret: 'blutfurblut',
            store: new mongoStore({
                url: config.db,
                collection : 'sessions'
            })
        }))

        app.use(express.favicon(path.join(__dirname, '../assets/img/favicon.ico')))

        app.use(flash())

        app.use(passport.initialize())
        app.use(passport.session())

        app.use(express.static(path.join(__dirname, '../assets')))

        app.use(assets())

        #jsPaths assets, console.log
        jsPaths assets

        app.use(app.router)
        return

    app.configure 'development', ->
        console.log 'Configuring development environment'
        app.use express.errorHandler()
        app.locals.pretty = true
        return

    return