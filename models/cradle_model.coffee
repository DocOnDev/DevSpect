cradle = require 'cradle'

class CradleModel

  constructor: (args...) ->
    connect = new cradle.Connection {
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

    @initialize(args...)

    @databaseName ?= "devspect"

    @db = connect.database @databaseName

exports.CradleModel = CradleModel