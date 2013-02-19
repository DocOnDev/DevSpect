Project = require('../../models/project').Project
Scope = require('../../models/scope').Scope
VelocityChart = require('../../models/velocity_chart').VelocityChart
{upperFirst, toDateFormat} = require '../formatters'

calcs =
  root: Math.sqrt
  square: (x) -> x * x
  sum: (x) -> x.reduce (a,b) -> a+b
  square_sum: (x) -> x.reduce (a,b) -> a+calcs.square(b)

dev = (_arr) ->
  nCount = _arr.length
  _total = calcs.sum(_arr)
  _sqrTotal = calcs.square_sum(_arr)
  variance = Math.max(0,(_sqrTotal - ((_total * _total)/nCount)) / nCount)
  return calcs.root(variance)

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

report_err = (err) ->
  res.render "#{__dirname}/views/index",
    title: 'Burn Chart'
    charttitle: 'Project Does Not Exist'
    stylesheet: 'burn'
    err: err
    burn: null
    series: JSON.stringify([])

routes = (app) ->
  app.get '/burn/:project?', accessAllowed, (req, res) ->
    project_name = req.params.project

    scope = new Scope project_name
    scope.mostRecent (err, docs) ->
      report_err err if (err)

      total_scope = 0
      total_scope = doc.points for doc in docs

      burn = new VelocityChart project_name
      burn.findAll (err, docs) ->
        report_err err if (err)

        total_scope += doc.points for doc in docs

        series = []
        _burn = []
        _points = []
        _devs = []
        mean_burn = 0
        _dev = 0
        for doc in docs
          _date = toDateFormat doc.date
          total_scope -= doc.points
          _burn.push [_date, total_scope]
          _points.push doc.points
          mean_burn = avg(_points, 3)
          _dev = dev(_points)

        last_date = _burn[_burn.length - 1][0]
        prior_date = _burn[_burn.length - 2][0]
        prior_points = _burn[_burn.length - 2][1]
        date_diff = last_date - prior_date
        next_date = last_date

        fast_burn = mean_burn + _dev
        slow_burn = mean_burn - _dev

        standard_scope = total_scope
        fast_scope = standard_scope - fast_burn
        slow_scope = standard_scope + slow_burn

        _devs.push [prior_date, prior_points, prior_points]
        _devs.push [last_date, fast_scope, slow_scope]
        while total_scope >= 0
          total_scope -= mean_burn
          fast_scope -= fast_burn
          slow_scope -= slow_burn
          next_date += date_diff
          _burn.push [next_date, total_scope]
          _devs.push [next_date, fast_scope, slow_scope]

        series.push {type: 'area', name: 'Burn', data: _burn}
        series.push {type: 'areasplinerange', name: 'Deviation', data: _devs}
        res.render "#{__dirname}/views/index",
          title: 'Burn Chart'
          charttitle: upperFirst(project_name)
          stylesheet: 'burn'
          err: err
          burn: docs
          chartColors: JSON.stringify(["#514F78", "#ffd300", "#9B5E4A", "#72727F", "#1F949A", "#82914E", "#86777F", "#42A07B"])
          series: JSON.stringify(series)

module.exports = routes
