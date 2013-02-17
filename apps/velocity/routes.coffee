Project = require('../../models/project').Project
VelocityChart = require('../../models/velocity_chart').VelocityChart
{upperFirst, toDateFormat} = require '../formatters'

avg = (_arr, count) ->
  if count <= _arr.length
    return (_arr.slice(-1*count).reduce (a,b) -> a+b) / count
  else
    return avg(_arr, _arr.length)

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
  app.get '/velocity/:project?', accessAllowed, (req, res) ->
    project_name = req.params.project
    velocity = new VelocityChart project_name
    velocity.findAll (err, docs) ->
      if (err)
        res.render "#{__dirname}/views/index",
          title: 'Velocity Chart'
          charttitle: 'Project Does Not Exist'
          stylesheet: 'velocity'
          err: err
          velocity: null
          series: JSON.stringify(series)

      series = []
      _velocity = []
      _points = []
      _avgs = []
      for doc in docs
        _date = toDateFormat doc.date
        _velocity.push [_date, doc.points]
        _points.push doc.points
        _avgs.push [_date, avg(_points, 3)]

      console.log _avgs
      series.push {type: 'column', name: 'Velocity', data: _velocity}
      series.push {type: 'spline', name: 'Average', data: _avgs}
      res.render "#{__dirname}/views/index",
        title: 'Velocity Chart'
        charttitle: upperFirst(project_name)
        stylesheet: 'velocity'
        err: err
        velocity: docs
        chartColors: JSON.stringify(["#514F78", "#ffd300", "#9B5E4A", "#72727F", "#1F949A", "#82914E", "#86777F", "#42A07B"])
        series: JSON.stringify(series)

module.exports = routes
