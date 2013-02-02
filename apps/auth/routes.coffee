User = require('../../models/user.coffee').User

validateUser = (userName, next) ->
  validator = new User
  validator.validate userName, (err, user_name) ->
    if err
      next null
    else
      next user_name


isValidUser = (user_name) ->
  true

routes = (app, passport) ->
  app.get '/auth/twitter', passport.authenticate('twitter')
  app.get '/auth/twitter/callback', passport.authenticate('twitter', { failureRedirect: '/login' }), (req, res) ->
    validateUser req.user.name, (username) ->
      if username
        req.flash 'info', "Welcome #{username}"
        res.redirect '/'
      else
        req.flash 'error', "User Not Found"
        req.logout()
        res.redirect '/'

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'

module.exports = routes
