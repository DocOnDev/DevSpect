Project = require('../../models/project').Project
VelocityChart = require('../../models/velocity_chart').VelocityChart
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
      _points = []
      for doc in docs
        _points.push [(toDateFormat doc.date), doc.points]

      series.push {name: 'velocity', data: _points}
      res.render "#{__dirname}/views/index",
        title: 'Velocity Chart'
        charttitle: upperFirst(project_name)
        stylesheet: 'velocity'
        err: err
        velocity: docs
        series: JSON.stringify(series)

module.exports = routes
