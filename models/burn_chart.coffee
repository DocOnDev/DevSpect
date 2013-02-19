CradleModel = require('./cradle_model').CradleModel

class BurnChart extends CradleModel
  initialize: (project_name) ->
    @databaseName = project_name

  findAll: (callback) ->
    @db.view 'points/scope', {descending: true, limit: 1}, (err, res) ->
      return callback err if err

      records = for row in res
        record = row.value
        record.date = new Date(record.date)
        record

      callback null, records

exports.BurnChart = BurnChart

