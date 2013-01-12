routes = (app) ->
  app.get '/', (req, res) ->
    project_list = []
    if req.user
      project_list = [{uri: "humor", name: "Humor"}, {uri: "personalization", name: "Personalize"}, {uri: "pull", name: "Pull"}]
    else
      project_list = [{uri: "devspect", name: "DevSpect"}, {uri: "playground", name: "Sample Project"}]
    res.render "#{__dirname}/views/index",
      title: 'Home'
      stylesheet: 'style'
      projects: project_list

module.exports = routes
