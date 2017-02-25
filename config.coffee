module.exports =
	port: process.env.NODE_ENV === 'production' ? 80 : 8080
	staticFileDirectory: '/'
	portalUrl: 'http://portal.shack:8088/status'
