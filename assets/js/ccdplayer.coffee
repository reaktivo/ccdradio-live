#= require jquery.shoutcast

class CCDPlayer

  text: 'CCD Radio'
  isPlaying: no

  constructor: (opts) ->
    @host = opts.host
    @port = opts.port
    @btn = $ opts.btn
    @audio = $ 'audio', @btn
    @playIcon = $ '.play', @btn
    @nowPlaying = $ '.now-playing', @btn
    @btn.click @toggle_audio
    do @setup_shoutcast

  toggle_audio: =>
    if @isPlaying
      @audio[0].pause()
      @playIcon.show()
    else
      @audio[0].play()
      @playIcon.hide()
    @isPlaying = not @isPlaying
    $('body').toggleClass 'is-playing', @isPlaying
    return false

  setup_shoutcast: =>
    self = this
    $.SHOUTcast
      host: self.host
      port: self.port
      stats: -> self.update_status @get('songtitle')
    .startStats()

  update_status: (text) =>
    return if @text is text
    @text = text
    @nowPlaying
      .text(text)
      .attr('title', text)