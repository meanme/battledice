express = require 'express'
http = require 'http'
https = require 'https'
fs = require 'fs'
passport = require 'passport'
mongoose = require 'mongoose'

#TODO - Environment setup
config = require '../config/config'
auth = require '../config/middlewares/authorization'

privateKey = fs.readFileSync(__dirname + '/battledice-key.pem')
certificate = fs.readFileSync(__dirname + '/battledice-cert.pem')

console.log "Connection to database at #{config.db}"
mongoose.connect config.db

# Setup models
models_path = "#{__dirname}/../app/models"
fs.readdirSync(models_path).forEach (file) ->
    require "#{models_path}/#{file}"


require('../config/passport') passport, config

app = express()

require('../config/express')(app, config, passport)

require('../config/routes')(app, passport, auth)

require('../app/helpers/general')(app)

port = process.env.PORT or 3000
http.createServer(app).listen port, ->
    console.log "#{process.pid}, listening to port :#{port}"

###
https.createServer(
    key: privateKey
    cert: certificate
).listen 8080, ->
    console.log 'secure server started'
###


###
expressApp.configure( () ->
    expressApp.set 'views', "#{__dirname}/views"
    expressApp.set 'view engine', 'jade'
    expressApp.use express.cookieParser()
    expressApp.use express.bodyParser()
    expressApp.use express.methodOverride()
    expressApp.use express.session secret : 'blutfurblut'
)


port = process.env.PORT
port ?= 3000

expressApp.listen port, () ->
    console.log "#{process.pid}, listening. Go to: http://localhost:#{port}"

###
