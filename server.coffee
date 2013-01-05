# Requires and Variables
exp = require 'express'
app = exp.createServer()
app.listen();
stylus = require 'stylus'

# compile on the fly
require 'coffee-script'
require('./apps/socket-io')(app)

# App Configuration
app.configure () ->
  app.set 'view engine', 'jade'
  app.set 'view options', { layout: false }
  app.set 'views', __dirname + '/views'
  app.use exp.static __dirname + '/public'
  app.use exp.bodyParser()
  app.use exp.methodOverride()
  app.use exp.cookieParser()
  app.use exp.session({secret: "Metricator-For-All-My-Friends"})

# Run App
# app.listen 1337
console.log "Server running at http://localhost:#{app.address().port}/"

# Global Helpers
require('./apps/helpers')(app)

# Routes
require('./apps/cfd/routes')(app)
