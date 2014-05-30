#= require jquery.shoutcast
#= require underscore

{ toArray, each } = _

class Main

  path: '/camera'
  containers: $('.image')
  index: 0
  isPlaying: no
  els: ['#warning', '#listen', '#what']

  constructor: ->
    $('#what a[href=#acerca]').click (e) =>
      e.preventDefault()
      @modal('#about')

    $('#what a[href=#programacion]').click (e) =>
      e.preventDefault()
      @modal('#programacion')

    $('#listen').click @toggle_audio
    $('#close').click (e) =>
      e.preventDefault()
      do @hide
    do @setup_shoutcast

  toggle_audio: (e) =>
    e.preventDefault()
    if @isPlaying
      $('#stream')[0].pause()
      $('.pause', '#listen').hide()
      $('.play', '#listen').show()
    else
      $('#stream')[0].play()
      $('.pause', '#listen').show()
      $('.play', '#listen').hide()
    @isPlaying = not @isPlaying
    $('body').toggleClass 'is-playing', @isPlaying

  setup_shoutcast: =>
    $.SHOUTcast
      host: window.STREAM.hostname
      port: window.STREAM.port
      stats: @update_status
    .startStats()

  modal: (el, time = 500) =>
    fadeIn = => @modalEl.delay(time).fadeIn()
    if @modalEl
      @modalEl.fadeOut(fadeIn)
    else
      fadeIn()
    @modalEl = $(el)
    $('#close').fadeIn()

    each @els, (sel) ->
      $(sel).fadeOut()

  hide: (time = 500) =>
    @modalEl.fadeOut()
    $('#close').fadeOut()
    each @els, (sel) =>
      $(sel).delay(time).fadeIn()

  update_status: ->
    $('.now-playing').text @get 'songtitle'

$(document).ready -> window.app = new Main