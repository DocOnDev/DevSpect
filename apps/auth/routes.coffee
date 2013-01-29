routes = (app, passport) ->
  app.get '/auth/twitter', passport.authenticate('twitter')
  app.get '/auth/twitter/callback', passport.authenticate('twitter', { failureRedirect: '/login' }), (req, res) ->
    req.flash 'info', "Welcome #{req.user.name}"
    res.redirect '/'

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect '/'

module.exports = routes
