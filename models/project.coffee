CradleModel = require('./cradle_model').CradleModel

class Project extends CradleModel
  initialize: (projectName) ->
    @id = null
    @name = projectName

  isPublic: (callback) ->
    @db.view 'project/public', {descending: true}, (err, res) =>
      return callback err, null if err

      for project in res when project.value.id == "project/#{@name}"
        return callback null, true

      callback null, false

exports.Project = Project
