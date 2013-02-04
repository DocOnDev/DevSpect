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
        nonPublicProjects = []
        res.forEach (row) ->
          if row.type == "project"
            if row.value.isPublic
              currentUser.projects.push {name: row.value.name, uri: row.value.uri}
            else
              nonPublicProjects.push row.value

        projects = {}
        for proj in nonPublicProjects
          projects[proj.id] = proj

        res.forEach (row) ->
          if row.type == "access" && row.value.user == "user/#{currentUser.twitterName}"
            project_id = row.value.project
            found = true
            if project_id == "*"
              currentUser.projects.push {name: prj.name, uri: prj.uri} for prj in nonPublicProjects
            else
              currentUser.projects.push {name: projects[project_id].name, uri: projects[project_id].uri}
        currentUser.projects.sort (a,b) -> return if a.name.toUpperCase() >= b.name.toUpperCase() then 1 else -1
        callback null, currentUser
      callback null, false if !found

exports.User = User
