User = require('../../models/user.coffee').User

validateUser = (userName, next) ->
  user = new User userName
  user.validate (err, user) ->
    if err
      next null
    else
      next user

routes = (app, passport) ->
  app.get '/auth/twitter', passport.authenticate('twitter')
  app.get '/auth/twitter/callback', passport.authenticate('twitter', { failureRedirect: '/' }), (req, res) ->
    validateUser req.user.twitterName, (user) ->
      if user
        req.user.name = user.name
        req.user.id = user.id
        req.flash 'info', "Welcome #{req.user.name}"
        res.redirect '/'
      else
        req.flash 'error', "User Not Found"
        req.logout()
        res.redirect '/'

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'

module.exports = routes
