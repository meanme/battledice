#
# Module dependencies
#
mongoose = require 'mongoose'
_ = require 'underscore'

User = mongoose.model 'User'
Player = mongoose.model 'Player'

#
# Show login form
#
exports.login = (req, res) ->
    res.render 'users/login',
        title: 'Login'
        message: req.flash 'error'
    return

#
# Logout
#
exports.logout = (req, res) ->
    req.logout()
    res.redirect '/'
    return

# List users #
exports.index = (req, res) ->
    console.log 'index'
    User.list (err, users) ->
        res.render 'users/index',
            users: users
            message: req.flash 'notice'
        return

#
# Display new user form
#
exports.new = (req, res) ->
    res.render 'users/new',
        user: new User({})
    return

#
# Create user
#
exports.create = (req, res) ->
    user = new User req.body
    user.provider = 'local'

    user.save (err) ->
        if err
            console.log 'error'
            for errorKey,errorJson of err.errors
                console.log errorJson
            res.render 'users/new',
                errors: (v.message for k,v of err.errors)
                user: user

        else

            # Initialize a new player object for the user
            player = new Player(
                username: user.username
            )
            player.initialize()
            player.save (err) ->

            res.redirect '/users'
        return

#
# Find user by id
#
exports.user = (req, res, next, id) ->
    User.findById(id).exec (err, user) ->
        return next err if err
        return next new Error 'Failed to load user' if not user

        req.profile = user
        next()
        return
    return

#
# Show edit form for users
#
exports.edit = (req, res) ->
    res.render 'users/edit',
        user: req.profile
    return

#
# Update user
#
exports.update = (req, res) ->
    user = req.profile

    user.name = req.body.name
    user.username = req.body.username
    user.email = req.body.email

    user.password = req.body.password if req.body.password

    user.save (err) ->
        if err
            console.log err

            res.render 'users/edit',
                user: user
                errors: err.errors
        else
            req.flash 'notice', 'User was successfully updated'
            res.redirect '/users'
        return
    return

#
# Delete user
#
exports.destroy = (req, res) ->
    user = req.profile

    user.remove (err) ->
        req.flash 'notice', 'User ' + user.name + ' was successfully deleted.'
        res.redirect '/users'

    return




