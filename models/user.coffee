cradle = require 'cradle'

class User
  constructor: ->
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

  validate: (user_name, callback) ->
    @db.view 'user/twitter_name', {descending: true, "key": user_name}, (err, res) ->
      if (err)
        callback err, null
      else
        res.forEach (row) ->
          if row.id == user_name
            callback null, row.id

  projectList: (callback) ->
    @db.view 'user/project_list', (err, res) ->
      if (err)
        console.log err
        callback err
      else
        projects = []
        res.forEach (row) ->
          projects.push row
        callback null, projects

exports.User = User
