config = require '../config'
send = require 'koa-send'
request = require 'co-request'

module.exports = ->
	koa = require 'koa'
	Router = require 'koa-router'
	koaBody = require('koa-body')()
	cors = require 'koa-cors'
	app = koa()

	app.use(cors())

	router = Router()
	sendIndex = ->
		yield send @, 'index.html', root: config.staticFileDirectory
	
	getPortalState = ->
		rawPortalState = yield request(config.portalUrl)
		return JSON.parse(rawPortalState.body)

	router.get '/v1/open', ->
		@body =
			status: getPortalState().status
			
	router.get '/v1/spaceapi', ->
		portalState = getPortalState() 
		@body =
			api: "0.13"
			space: "shackspace - stuttgart hackerspace"
			logo: "https://rescue.shackspace.de/images/logo_shack_brightbg_highres.png"
			url: "https://shackspace.de"
			icon:
				open: "https://shackspace.de/sopen/img/png"
				closed: "https://shackspace.de/sopen/img/png"
			location:
				address: "Ulmer Strasse 255, 70327 Stuttgart, Germany"
				lon: 9.236
				lat: 48.777
			contact:
				phone: "+49.711.21729823"
				twitter: "@shackspace"
				email: "kontakt@shackspace.de"
				ml: "public@shackspace.de"
				irc: "irc://freenode.net/#shackspace"
			issue_report_channels: ["email"]
			state:
				icon:
					open: "http://shackspace.de/sopen.gif"
					closed: "http://shackspace.de/sopen.gif"
				open: portalState.status == 'open'
				lastchange: portalState.timestamp
			projects: [
				"http://shackspace.de/wiki/doku.php?id=projekte"
				"http://github.com/shackspace"
			]

	app.use(router.routes()).use(router.allowedMethods())

	return app
