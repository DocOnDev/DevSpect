isValidUser = (user_name) ->
  true

routes = (app, passport) ->
  app.get '/auth/twitter', passport.authenticate('twitter')
  app.get '/auth/twitter/callback', passport.authenticate('twitter', { failureRedirect: '/login' }), (req, res) ->
    if isValidUser(req.user.name)
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
