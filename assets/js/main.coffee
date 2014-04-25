#= require jquery.shoutcast

class Main

  path: '/camera'
  containers: $('.image')
  index: 0
  isPlaying: no

  constructor: ->
    $('#what a[href=#acerca]').click @toggle_about
    $('#what a[href=#programacion]').click @toggle_programacion
    $('#listen').click @toggle_audio
    do @setup_shoutcast
    # do @update_image

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

  update_image: =>
  #   container = $ @containers[@index++]
  #   other_container = $ @containers.not(container)
  #   @index = 0 if @index >= @containers.length
  #   rand_path = @path + "?" + Math.random()
  #   $('<img>').attr('src', rand_path).load ->
  #     $(this).remove()
  #     container
  #       .css backgroundImage: "url(#{rand_path})"
  #       .show()
  #     setTimeout (=> other_container.hide()), 50
  #     setTimeout @update_image, 1000

  toggle_about: =>
    $('#warning').fadeToggle()
    $('#listen').fadeToggle()
    $('#about').fadeToggle()
    no

  toggle_programacion: =>
    $('#programacion').fadeToggle()
    $('#warning').fadeToggle()
    $('#listen').fadeToggle()
    no

  setup_shoutcast: =>
    # $.SHOUTcast
    #   host: window.STREAM.hostname
    #   port: window.STREAM.port
    #   stats: @update_status
    # .startStats()

  update_status: ->
    $('.now-playing').text @get 'songtitle'

$(document).ready -> new Main