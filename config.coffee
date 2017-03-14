module.exports =
	port: if process.env.NODE_ENV is 'production' then 80 else 8080
	staticFileDirectory: 'docs/public'
	portalUrl: 'http://portal.shack:8088/status'
