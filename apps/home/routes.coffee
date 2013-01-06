routes = (app) ->
  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: 'Home'
      stylesheet: 'style'

module.exports = routes
