cradle = require 'cradle'

class CumulativeFlow
  constructor: (project_name) ->
    @connect = new cradle.Connection {
      host: 'https://docondev.cloudant.com'
      cache: true
      raw: false
      port: 443
      secure: true
      auth: {
        username: "shalmordinfrosequeedderb"
        password: "nSG4S4nqKYWiSJNSv3n6xM3M"
      }
    }
    @db = @connect.database project_name

  findAll: (callback) ->
    @db.view 'points/cfd', {descending: false}, (err, res) ->
      if (err)
        console.log err
        callback err
      else
        records = []
        res.forEach (row) ->
          row.date = new Date(row.date)
          records.push row
        callback null, records

        #  save:
        #    @db.save records, (err, res) ->
        #      if (err)
        #        callback err
        #      else
        #        callback null, records

exports.CumulativeFlow = CumulativeFlow
