# shackapi-space-docs

Public shackspace api currently hosted at https://api.shackspace.de/

Provides endpoints ( see app/application.coffee and config.coffee )
- /v1/space -> http://api.shack/v1/portal  
_Implemented by internal [api-space](https://github.com/shackspace/api-space)_
- /v1/stats/portal -> http://api.shack/v1/stats/portal  
_Implemented by internal [api-space](https://github.com/shackspace/api-space)_
- /v1/spaceapi  
_Implemented here but fetches open-state from internal [api-space](https://github.com/shackspace/api-space)_
- /v1/online -> http://api.shack/v1/online  
_Implemented by internal [api-space](https://github.com/shackspace/api-space)_
- /v1/plena/next  
_Implemented here_
- /v1/feinstaubalarm  
_Implemented here_


### Setup

- make sure [node.js](http://nodejs.org) and [roots](http://roots.cx) are installed
- clone this repo down and `cd` into the folder
- run `npm install`
- run `roots watch`
- ???
- get money

### Deploying

- If you just want to compile the production build, run `roots compile -e production` and it will build to public.
- To deploy your site with a single command, run `roots deploy -to XXX` with `XXX` being whichever [ship](https://github.com/carrot/ship#usage) deployer you want to use.
