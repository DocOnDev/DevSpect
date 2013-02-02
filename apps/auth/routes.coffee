User = require('../../models/user.coffee').User

validateUser = (userName, next) ->
  validator = new User
  validator.validate userName, (err, user) ->
    if err
      next null
    else
      next user


routes = (app, passport) ->
  app.get '/auth/twitter', passport.authenticate('twitter')
  app.get '/auth/twitter/callback', passport.authenticate('twitter', { failureRedirect: '/' }), (req, res) ->
    validateUser req.user.name, (user) ->
      if user
        req.user.name = user.name
        req.flash 'info', "Welcome #{user.name}"
        res.redirect '/'
      else
        req.flash 'error', "User Not Found"
        req.logout()
        res.redirect '/'

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'

module.exports = routes
