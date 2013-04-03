Project = require('../../models/project').Project
CycleTime = require('../../models/cycle_time').CycleTime
{upperFirst, toDateFormat} = require '../formatters'

accessAllowed = (req, res, next) ->
  project_name = req.params.project

  if req.isAuthenticated()
    for proj in req.user.projects when proj._id == "project/#{project_name}"
        return next()

  prj = new Project project_name
  prj.isPublic (err, found) ->
    return next() if found
    req.flash 'error', ' You do not have access to this project.'
    res.redirect '/'

routes = (app) ->
  app.get '/cycle/:project?', accessAllowed, (req, res) ->
    project_name = req.params.project
    cycle = new CycleTime project_name
    cycle.findAll (err, docs) ->
      if (err)
        res.render "#{__dirname}/views/index",
          title: 'Cycle Time'
          charttitle: 'Project Does Not Exist'
          stylesheet: 'cycle_time'
          err: err
          cycle: null
          series: JSON.stringify(series)

      series = []
      _cycle = []
      _points = []
      _avgs = []
      _devs = []
      for doc in docs
        _date = toDateFormat doc.date
        _cycle.push [_date, doc.cycle_time]

      series.push {type: 'column', name: 'Cycle Time', data: _cycle}
      res.render "#{__dirname}/views/index",
        title: 'Cycle Time'
        charttitle: upperFirst(project_name)
        stylesheet: 'cycle_time'
        err: err
        cycle: docs
        chartColors: JSON.stringify(["#958F78", "#ffd300", "#9B5E4A", "#72727F", "#1F949A", "#82914E", "#86777F", "#42A07B"])
        series: JSON.stringify(series)

module.exports = routes
