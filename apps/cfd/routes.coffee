Project = require('../../models/project').Project
CumulativeFlow = require('../../models/cumulative-flow').CumulativeFlow
{upperFirst, toDateFormat} = require '../formatters'

ensureAuthenticated = (req, res, next) ->
  return next() if req.isAuthenticated()

  prj = new Project(req.params.project)
  prj.isPublic (err, found) ->
    return next() if found
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
        charttitle: upperFirst(project_name)
        stylesheet: 'cfd'
        err: err
        cfds: docs
        axis: xAxis
        series: JSON.stringify(series)

module.exports = routes
