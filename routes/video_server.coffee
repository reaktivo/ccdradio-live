
Paparazzo = require 'paparazzo'
# 192.168.2.20/video3.mjpg
host = process.env.VIDEO_SERVER or "192.168.2.20"
path = process.env.VIDEO_PATH or "/video3.mjpg"
auth = 'admin:'
image = ''

module.exports = (app) ->

  paparazzo = new Paparazzo { host, path, auth }

  paparazzo.on "update", (data) =>
    image = data

  paparazzo.on 'error', (error) =>
    console.log "Webcam Error: #{error.message}"

  paparazzo.start()

  app.get '/camera', (req, res, next)->
    return do next unless image
    res.status 200
    res.set
      'Content-Type': 'image/jpeg'
      'Content-Length': image.length
    res.end image, 'binary'
