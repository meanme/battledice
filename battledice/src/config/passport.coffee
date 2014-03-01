mongoose = require 'mongoose'
User = mongoose.model 'User'
Player = mongoose.model 'Player'

config = require './config'

module.exports = (passport) ->

    LocalStrategy = require('passport-local').Strategy
    FacebookStrategy = require('passport-facebook').Strategy

    passport.serializeUser (user, done) ->
        done null, user

    passport.deserializeUser (obj, done) ->
        done null, obj

    passport.use new LocalStrategy (username, password, done) ->
        #console.log "#{username} and #{password}"

        User.findOne username: username, (err, user) ->
            if err
                return done err
            if not user
                return done null, false, message: "Unknown user: #{username}"

            user.comparePassword password, (err, isMatch) ->
                if err then return done err
                if isMatch
                    return done null, user
                else
                    return done null, false, message: 'Invalid password'

    passport.use new FacebookStrategy(
        clientID: config.facebook.clientID
        clientSecret: config.facebook.clientSecret
        callbackURL: config.facebook.callbackURL
    , (accessToken, refreshToken, profile, done) ->

        User.findOne {"facebook.id" : profile.id}, (err, user) ->
            if err
                return done err

            # TODO - Move into user class
            if not user
                user = new User(
                    name: profile.displayName
                    email: profile.emails[0].value
                    username: profile.username
                    provider: 'facebook'
                    facebook: profile._json
                )

                player = new Player(
                    username: profile.username
                )
                player.initialize()

                user.save (err) ->
                    if err then console.log err
                    player.save (err) ->
                        done err, user
            else
                done err, user

    )
