CradleModel = require('./cradle_model').CradleModel

class Scope extends CradleModel
  initialize: (project_name) ->
    @databaseName = project_name

  mostRecent: (callback) ->
    @db.view 'points/scope', {descending: true, limit: 1}, (err, res) ->
      return callback err if err

      records = for row in res
        record = row.value
        record.date = new Date(record.date)
        record

      callback null, records

  findAll: (callback) ->
    @db.view 'points/scope', {descending: false}, (err, res) ->
      return callback err if err

      records = for row in res
        record = row.value
        record.date = new Date(record.date)
        record

      callback null, records

exports.Scope = Scope


