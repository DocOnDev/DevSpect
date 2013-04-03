CradleModel = require('./cradle_model').CradleModel

class CycleTime extends CradleModel
  initialize: (project_name) ->
    @databaseName = project_name

  findAll: (callback) ->
    @db.view 'points/velocity', {descending: false}, (err, velocity) =>
      return callback err if err

      @db.view 'points/wip', {descending: false}, (err2, cycle) ->
        return callback err2 if err2

        records = for row in velocity
          record = row.value
          record.velocity = record.points
          record.throughput = record.velocity / 5
          record.wip = 1
          for c in cycle when c.date = record.date
            record.wip = c.value.points
          record.cycle_time = (record.wip / record.throughput)
          record.date = new Date(record.date)
          record

        callback null, records

exports.CycleTime = CycleTime

