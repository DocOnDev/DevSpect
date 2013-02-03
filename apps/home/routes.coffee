User = require('../../models/user.coffee').User

showPage = (res, project_list) ->
  res.render "#{__dirname}/views/index",
    title: 'Home'
    stylesheet: 'style'
    projects: project_list

routes = (app) ->
  app.get '/', (req, res) ->
    project_list = []
    if req.user
      user = new User req.user.twitterName
      user.id = req.user.id
      user.name = req.user.name
    else
      user = new User null

    user.projectList (err, user) ->
      if (err)
        res.flash 'error', 'Failed to Load entire project list'
      else
        if user.projects
          user.projects.forEach (prj) ->
            if prj
              project_list.push prj
        showPage res, project_list

module.exports = routes
