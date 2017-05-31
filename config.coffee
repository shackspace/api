module.exports =
	port: if process.env.NODE_ENV is 'production' then 80 else 8080
	staticFileDirectory: 'docs/public'
	portalUrl: 'http://api.shack/v1/portal'
	shacklesUrl: 'http://api.shack/v1/online'
	wikiUrl: 'https://wiki.shack.space/'
