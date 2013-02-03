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
    twitterName = @twitterName
    @db.view 'user/twitter_name', {descending: true, "key": @twitterName}, (err, res) ->
      found = false
      if (err)
        callback err, null
      else
        res.forEach (row) ->
          if row.id == twitterName
            found = true
            @id = row.id
            @name = row.name
          callback null, @
      callback null, false if !found

  projectList: (callback) ->
    @projects = []
    currentUser = @
    @db.view 'user/project_list', {descending: false}, (err, res) ->
      found = false
      if (err)
        callback err, null
      else
        currentUser.projects.push {uri: "humor", name: "Humor"}
        currentUser.projects.push {uri: "personalization", name: "Personalize"}
        currentUser.projects.push {uri: "pull", name: "Pull"}
        res.forEach (row) ->
          if row.type == "project"
            found = true
            currentUser.projects.push {name: row.value, uri: row.value}
        callback null, currentUser
      callback null, false if !found

exports.User = User
