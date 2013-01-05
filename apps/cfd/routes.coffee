# Cumulative Flow
CumulativeFlow = require('../../models/cumulative-flow').CumulativeFlow
cfd = new CumulativeFlow

zero_pad = (x) ->
    if x < 10 then '0'+x else ''+x

to_date_string = (dt) ->
    d = zero_pad(dt.getDate())
    m = zero_pad(dt.getMonth() + 1)
    y = dt.getFullYear()
    m + '/' + d + '/' + y

routes = (app) ->
  app.get '/cfd', (req, res) ->
    cfd.findAll (err, docs) ->
      xAxis = []
      states = {}
      series = []
      for doc in docs
        xAxis.push "'#{to_date_string doc.date}'"
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
        charttitle: 'Personalize Team'
        stylesheet: 'cfd'
        err: err
        cfds: docs
        axis: xAxis
        series: JSON.stringify(series)

module.exports = routes
