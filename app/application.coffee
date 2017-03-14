config = require '../config'
send = require 'koa-send'
request = require 'co-request'
cheerio = require 'cheerio'
moment = require 'moment'
require 'moment/locale/de'
log4js = require 'log4js'
log = log4js.getLogger 'shackspace-api'

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
		rawPortalState = yield request
			url: config.portalUrl
			timeout: 5000
		return JSON.parse(rawPortalState.body)

	router.get '/v1/space', ->
		try
			portalState = yield getPortalState()
			@body =
				doorState:
					open: portalState.status == 'open'
		catch error
			log.error error
			@status = 503
			
	router.get '/v1/plena/next', ->
		plenumForWeek = (start) ->
			if start.week() % 2 is 0
				start.day('Donnerstag')
			else
				start.day('Mittwoch')
		plenumDate = moment().startOf('week')
		plenumForWeek plenumDate
		if moment().isAfter(plenumDate, 'day')
			plenumDate.day('Monday')
			plenumForWeek plenumDate
		
			
		@body =
			date: plenumDate.startOf('day').format()
	
	router.get '/v1/spaceapi', ->
		try
			portalState = yield getPortalState() 
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
		catch error
			log.error error
			@status = 503
			
	router.get '/v1/feinstaubalarm', ->
		widget = yield request 'http://www.stuttgart.de/feinstaubalarm/widget/wider'
		$ = cheerio.load(widget.body)
		isAlarm = $('body > div').hasClass('alarm-on')
		@body =
			feinstaubalarm: isAlarm

	app.use(router.routes()).use(router.allowedMethods())

	return app
