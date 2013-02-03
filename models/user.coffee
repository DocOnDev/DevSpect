cradle = require 'cradle'

class User
  constructor: (twitterName) ->
    @twitterName = twitterName
    @id = null
    @name = null
    @projects = null
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

  validate: (callback) ->
    thisUser = @
    twitterName = @twitterName
    @db.view 'user/twitter_name', {descending: true, "key": @twitterName}, (err, res) ->
      found = false
      if (err)
        callback err, null
      else
        res.forEach (row) ->
          if row.id == twitterName
            found = true
            thisUser.id = row.id
            thisUser.name = row.name
            callback null, thisUser
        callback null, false if !found

  projectList: (callback) ->
    callback null, @projects if @projects

    @db.view 'user/project_list', {"key": ["user/#{twitterName}",1]}, (err, res) ->
      if (err)
        console.log err
        callback err
      else
        projects = []
        res.forEach (row) ->
          projects.push row
        callback null, projects

exports.User = User
