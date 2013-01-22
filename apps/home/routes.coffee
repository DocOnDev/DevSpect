routes = (app) ->
  app.get '/', (req, res) ->
    project_list = [{uri: "devspect", name: "DevSpect"}]
    if req.user
      project_list.push {uri: "humor", name: "Humor"}
      project_list.push {uri: "personalization", name: "Personalize"}
      project_list.push {uri: "pull", name: "Pull"}
    else
    res.render "#{__dirname}/views/index",
      title: 'Home'
      stylesheet: 'style'
      projects: project_list

module.exports = routes
