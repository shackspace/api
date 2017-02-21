config = require '../config'
send = require 'koa-send'

module.exports = ->
	koa = require 'koa'
	Router = require 'koa-router'
	koaBody = require('koa-body')()
	cors = require 'koa-cors'
	app = koa()

	app.use(cors())
	routers = require './routers'

	router = Router()
	sendIndex = ->
		yield send @, 'index.html', root: config.staticFileDirectory

	router.get '/v1/open'
	router.get '/v1/shackapi'
	router.post '/api/v2/login', koaBody, routers.auth.login

	app.use(router.routes()).use(router.allowedMethods())

	return app
