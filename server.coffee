# Requires and Variables
exp = require 'express'
app = exp.createServer()
passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy
#User = require('./models/user.coffee').User
stylus = require 'stylus'

# compile on the fly
require 'coffee-script'
require('./apps/socket-io')(app)

callBackURL = (serviceName) ->
  if process.env.PORT
    domain = 'http://devspect.com'
  else
    domain = 'http://localhost:1337'
  url = "#{domain}/auth/#{serviceName}/callback"

passport.use new TwitterStrategy {
  consumerKey: '1301yY5d1qQD5HWVYtAA',
  consumerSecret: 'iEo7n9756AesXzjborhu8LDXTWR53TEz4Y3T8WDe4',
  callbackURL: callBackURL('twitter')  },
  (token, tokenSecret, profile, done) ->
    console.log "User is #{profile.id} / #{profile.username}"
    user = {id: profile.id, twitter_name: profile.username, name: profile.username}
    done(null, user)

passport.serializeUser (user, done) ->
  done null, user

passport.deserializeUser (user, done) ->
  done null, user

# App Configuration
app.configure () ->
  app.set 'view engine', 'jade'
  app.set 'view options', { layout: false }
  app.set 'views', __dirname + '/views'
  app.use exp.static __dirname + '/public'
  app.use exp.bodyParser()
  app.use exp.methodOverride()
  app.use exp.cookieParser()
  app.use exp.session({secret: "DevSpect-For-All-My-Friends"})
  app.use passport.initialize()
  app.use passport.session()

# Run App
app.listen process.env.PORT || 1337
console.log "Server running at http://localhost:#{app.address().port}/"

# Global Helpers
require('./apps/helpers')(app)

# Routes
require('./apps/auth/routes')(app, passport)
require('./apps/cfd/routes')(app)
require('./apps/home/routes')(app)
