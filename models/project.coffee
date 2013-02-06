cradle = require 'cradle'

class Project
  constructor: (projectName) ->
    @id = null
    @name = projectName
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
    @db = @connect.database "devspect"

  isPublic: (callback) ->
    name = @name
    @db.view 'project/public', {descending: true}, (err, res) ->
      found = false
      if (err)
        callback err, null
      else
        res.forEach (row) ->
          if row.id == "project/#{name}"
            found = true
      console.log found
      callback null, found

exports.Project = Project
