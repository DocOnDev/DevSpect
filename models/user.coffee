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

  validate: (user_name, done) ->
    @db.view 'user/twitter_name', (err, res) ->
      if (err)
        done err, null
      else
        res.forEach (row) ->
          console.log row.id
          if row.id == user_name
            done null, row.id

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
