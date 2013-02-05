# Cumulative Flow
CumulativeFlow = require('../../models/cumulative-flow').CumulativeFlow

upper_first = (phrase) -> (phrase.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

zero_pad = (x) ->
    if x < 10 then '0'+x else ''+x

toDateFormat = (dt) ->
  dt.getTime()

ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    if req.params.project == 'devspect'
      next()
    else
      req.flash 'error', ' Please login.'
      res.redirect '/'

routes = (app) ->
  app.get '/cfd/:project?', ensureAuthenticated, (req, res) ->
    project_name = req.params.project || 'devspect'
    cfd = new CumulativeFlow project_name
    cfd.findAll (err, docs) ->
      if (err)
        res.render "#{__dirname}/views/index",
          title: 'Cumulative Flow Diagram'
          charttitle: 'Project Does Not Exist'
          stylesheet: 'cfd'
          err: err
          cfds: null
          axis: xAxis
          series: JSON.stringify(series)

      xAxis = []
      states = {}
      series = []
      for doc in docs
        xAxis.push "#{toDateFormat doc.date}"
        for state of doc.points
          points = doc.points[state]
          if states[state]
            states[state].push points
          else
            states[state] = [points]
      for name, values of states
        series.push {name: name, data: values}
      res.render "#{__dirname}/views/index",
        title: 'Cumulative Flow Diagram'
        charttitle: upper_first(project_name)
        stylesheet: 'cfd'
        err: err
        cfds: docs
        axis: xAxis
        series: JSON.stringify(series)

module.exports = routes
