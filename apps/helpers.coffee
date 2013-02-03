
helpers = (app) ->

  app.dynamicHelpers
    username: (req, res) ->
      username = null
      if req.user
        console.log "Helper User is #{req.user.twitterName}"
        console.log req.user
        username = req.user.name
      username
    flash: (req, res) -> req.flash()
    
  app.helpers
    cssClassForState: (expected, actual) ->
      if actual is expected
        [expected, 'on']
      else
        expected
    cssClassForPieAge: (pie) ->
      pieAge = (new Date).getTime() - pie.stateUpdatedAt
      minutes = (num) -> 1000 * 60 * num
      switch pie.state
        when 'making'
          if pieAge > minutes(1)
            'almost-ready'
          else
            'not-ready'
        when 'ready'
          if pieAge < minutes(1)
            'pipin-hot'
          else if pieAge < minutes(2)
            'hot'
          else
            'warm'
        else
          null

module.exports = helpers
