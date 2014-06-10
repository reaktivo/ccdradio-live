url = require 'url'



module.exports = (app) ->

  # app.locals.stream = url.parse('http://stereo.wavestreamer.com:1801/Live')
  app.locals.stream = url.parse 'http://firewavestreamer.com:7721/Live'

  app.get '/', (req, res) ->
    res.render 'index', title: 'CCD Radio'

  app.get '/bios/:id', (req, res) ->
    res.render "bios/#{req.params.id}"