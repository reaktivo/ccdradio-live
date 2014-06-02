#= require underscore
#= require jquery.transit
#= require ./ccdplayer
#= require ./viewport

{ each } = _

class Main

  main: $ '#main'
  sections: $ '> div', '#main'
  nav_links: $ '#main-nav a'
  transform:
    hide: { opacity: 0, scale: 0.95 }
    show: { opacity: 1, scale: 1 }

  constructor: ->
    @activeSection = $ '.escucha', @main
    @nav_links.click @nav_click
    $(window).resize(@layout).resize()
    @player = new CCDPlayer
      btn: '.escucha-btn'
      host: window.STREAM.hostname
      port: window.STREAM.port

  nav_click: (e) =>
    classStr = '.' + $(e.currentTarget).attr('href').substr(1)
    @activeSection.animate @transform.hide, =>
      @activeSection.hide()
      @activeSection = $(classStr, @main)
        .css(@transform.hide).show()
        .animate @transform.show
    return false

  layout: =>
    @sections.css height: $.viewport().height

$(document).ready ->
  window.app = new Main