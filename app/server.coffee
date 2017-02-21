log4js = require 'log4js'
log = log4js.getLogger 'shackspace-api'

config = require '../config'

app = require('./application')()

app.use require('koa-static')(config.staticFileDirectory)

app.on 'error', (err) ->
	log.error err

app.listen config.port, ->
	log.info 'server listening on port ' + config.port
