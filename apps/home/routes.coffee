User = require('../../models/user.coffee').User

showPage = (res, project_list) ->
  res.render "#{__dirname}/views/index",
    title: 'Home'
    stylesheet: 'style'
    projects: project_list

routes = (app) ->
  app.get '/', (req, res) ->
    project_list = []
    if sessionUserHasProjects(req.user)
      project_list.push prj for prj in req.user.projects
      return showPage res, project_list

    user = new User if req.user then req.user.twitterName else null
    user.listProjects (err, user) ->
      if (err)
        res.flash 'error', 'Failed to Load entire project list'
      else
        req.user.projects = user.projects if req.user
        project_list.push prj for prj in user.projects
      showPage res, project_list

sessionUserHasProjects = (sessionUser) ->
  sessionUser && sessionUser.projects
  
module.exports = routes
