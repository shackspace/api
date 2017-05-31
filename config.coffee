module.exports =
	port: if process.env.NODE_ENV is 'production' then 80 else 8080
	staticFileDirectory: 'docs/public'
	portalUrl: 'http://api.shack/v1/portal'
	wikiUrl: 'https://wiki.shack.space/'
