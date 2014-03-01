module.exports = (app, passport, auth) ->


    main = require '../app/controllers/main'

    # User routes
    users = require '../app/controllers/users'

    app.post '/login', passport.authenticate('local',
        failureRedirect: '/login'
        failureFlash: true), (req, res) ->
            res.redirect '/'

    app.get '/auth/facebook', passport.authenticate('facebook',
        scope: ['user_status', 'email']
    )

    app.get '/auth/facebook/callback', passport.authenticate('facebook', {failureReidrect: '/'}), (req, res) ->
        res.redirect '/'

    (req, res) ->
        res.redirect '/'
        return

    app.get '/', main.index

    app.get '/logout', users.logout

    app.get '/login', users.login
    app.get '/users/new', users.new
    app.post '/users', users.create

    app.get '/users', auth.requiresLogin, users.index

    app.get '/users/:userId/edit', auth.requiresLogin, users.edit
    app.put '/users/:userId', auth.requiresLogin, users.update
    app.get '/users/:userId/destroy', auth.requiresLogin, users.destroy

    app.param 'userId', users.user

    # Article routes
    articles = require '../app/controllers/articles'
    app.get '/articles', articles.manage
    app.get '/articles/new', auth.requiresLogin, articles.new
    app.get '/articles/:articleId', articles.show
    app.post '/articles', auth.requiresLogin, articles.create
    app.get '/articles/:articleId/edit', auth.requiresLogin, articles.edit
    app.put '/articles/:articleId', auth.requiresLogin, articles.update
    app.get '/articles/:articleId/destroy', auth.requiresLogin, articles.destroy

    app.param 'articleId', articles.article

    return