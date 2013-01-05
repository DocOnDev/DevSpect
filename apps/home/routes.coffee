routes = (app) ->
  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: 'Select a Project'
      stylesheet: 'style'

module.exports = routes
