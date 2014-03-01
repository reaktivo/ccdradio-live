fs = require 'fs'

dir = "ccdradio-live"

opts =
  host: 'drop.reaktivo.com'
  username: 'root'
  privateKey: fs.readFileSync '/Users/reaktivo/.ssh/id_rsa'

plan = new (require 'flightplan')

plan.briefing
  debug: no
  destinations:
    production: opts

plan.local (local) ->
  local.git 'push'

plan.remote (remote) ->
  remote.git "clone git@github.com:reaktivo/#{dir}.git", failsafe: yes
  remote.chdir dir, ->
    remote.git 'pull'
    remote.npm 'install --production'
    remote.exec "pm2 reload ccdradio"

module.exports = plan