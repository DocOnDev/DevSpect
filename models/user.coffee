CradleModel = require('./cradle_model').CradleModel


class User extends CradleModel

  initialize: (twitterName) ->
    @twitterName = twitterName
    @id = null
    @name = null
    @projects = null


  validate: (callback) ->
    @db.view 'user/twitter_name', {descending: true, "key": @twitterName}, (err, res) =>
      return callback(err, null) if err

      for row in res when row.value.id == @twitterName
        user = row.value
        @id = user.id
        @name = user.name
      callback null, @

  projectList: (callback) ->
    @projects = []
    currentUser = @
    @db.view 'user/project_list', {descending: false}, (err, res) ->
      return callback(err, null) if err

      found = false

      nonPublicProjects = []

      for row in res when row.key[0] == 'project'
        project = row.value

        if project.isPublic
          currentUser.projects.push {name: project.name, uri: project.uri}
        else
          nonPublicProjects.push project

      projects = {}
      for proj in nonPublicProjects
        projects[proj._id] = proj

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

exports.User = User



