CradleModel = require('./cradle_model').CradleModel

class CumulativeFlow extends CradleModel
  initialize: (project_name) ->
    @databaseName = project_name

  findAll: (callback) ->
    @db.view 'points/cfd', {descending: false}, (err, res) ->
      return callback err if err

      records = for row in res
        record = row.value
        record.date = new Date(record.date)
        record

      callback null, records

        #  save:
        #    @db.save records, (err, res) ->
        #      if (err)
        #        callback err
        #      else
        #        callback null, records

exports.CumulativeFlow = CumulativeFlow
