url = require 'url'



module.exports = (app) ->

  app.locals.stream = url.parse('http://stereo.wavestreamer.com:1801/Live')

  app.get '/', (req, res) ->
    res.render 'index', title: 'CCD Radio'