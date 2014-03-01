module.exports = (app) ->

    # Template function for Markdown rendering
    marked = require 'marked'
    app.locals.marked = marked

    moment = require 'moment'

    app.locals.dateShortMon = (date) ->
        moment(date).format 'MMM DD'