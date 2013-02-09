CradleModel = require('./cradle_model').CradleModel

class User extends CradleModel

  initialize: (twitterName) ->
    @twitterName = twitterName
    @id = null
    @name = null
    @projects = null
    @isAdmin = false

  validate: (callback) ->
    @db.view 'user/twitter_name', {descending: true, "key": @twitterName}, (err, res) =>
      return callback(err, null) if err

      for row in res when row.value.id == @twitterName
        user = row.value
        @id = user.id
        @name = user.name
        @isAdmin = user.isAdmin
      callback null, @

  projectList: (callback) ->
    @projects = []
    @db.view 'user/project_list', {descending: false}, (err, res) =>
      return callback(err, null) if err

      projects = {}
      projects[row.value._id] = row.value for row in res when row.key[0] == 'project'

      @projects.push projects[prj] for prj of projects when projects[prj].isPublic
      #@projects.push projects[prj] for prj of projects when !projects[prj].isPublic if @isAdmin

      for row in res when row.value.type == "access" && row.value.value.user == "user/#{@twitterName}"
        project_id = row.value.value.project
        if project_id == "*"
          @projects.push projects[prj] for prj of projects when !projects[prj].isPublic
        else
          @projects.push projects[project_id]

      @projects.sort (a,b) -> return if a.name.toUpperCase() >= b.name.toUpperCase() then 1 else -1
      callback null, @

exports.User = User



