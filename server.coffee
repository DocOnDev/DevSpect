# Requires and Variables
exp = require 'express'
app = exp.createServer()
passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy
stylus = require 'stylus'

# compile on the fly
require 'coffee-script'
require('./apps/socket-io')(app)

passport.use new TwitterStrategy {
  consumerKey: '1301yY5d1qQD5HWVYtAA',
  consumerSecret: 'iEo7n9756AesXzjborhu8LDXTWR53TEz4Y3T8WDe4',
  callbackURL: "http://www.devspect.com/auth/twitter/callback"
  },
  (token, tokenSecret, profile, done) ->
    user = users[profile.id] || (users[profile.id] = { id: profile.id, name: profile.username })
    user = {id: "Doc", name: "Michael 'Doc' Norton"}
    done(null, user)

passport.serializeUser (user, done) ->
  done null, user

passport.deserializeUser (id, done) ->
  done(null, users[id])

# App Configuration
app.configure () ->
  app.set 'view engine', 'jade'
  app.set 'view options', { layout: false }
  app.set 'views', __dirname + '/views'
  app.use exp.static __dirname + '/public'
  app.use exp.bodyParser()
  app.use exp.methodOverride()
  app.use passport.initialize()
  app.use passport.session()
  app.use exp.cookieParser()
  app.use exp.session({secret: "DevSpect-For-All-My-Friends"})

# Run App
app.listen process.env.PORT || 1337
console.log "Server running at http://localhost:#{app.address().port}/"

# Global Helpers
require('./apps/helpers')(app)

# Routes
app.get '/auth/twitter', passport.authenticate('twitter')
app.get '/auth/twitter/callback', passport.authenticate('twitter', { successRedirect: '/', failureRedirect: '/auth/twitter' })

require('./apps/cfd/routes')(app)
require('./apps/home/routes')(app)
