# Cumulative Flow
CumulativeFlow = require('../../models/cumulative-flow').CumulativeFlow
cfd = new CumulativeFlow

routes = (app) ->
  app.get '/cfd', (req, res) ->
    cfd.findAll (err, docs) ->
      res.render "#{__dirname}/views/index", 
        title: 'Index'
        stylesheet: 'style'
        err: err
        cfds: docs

module.exports = routes
