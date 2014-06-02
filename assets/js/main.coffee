#= require underscore
#= require jquery.transit
#= require ./ccdplayer
#= require ./viewport

{ each } = _

class Main

  main: $ '#main'
  sections: $ '> div', '#main'
  nav_links: $ '#main-nav a'
  bio_container: $ '.bio-container'
  transform:
    hide2: { opacity: 0, scale: 1.1 }
    hide: { opacity: 0, scale: 0.95 }
    show: { opacity: 1, scale: 1 }

  constructor: ->
    @activeSection = $ '.escucha', @main
    $('.calendario .show').click @show_detail
    $('.bio-container').on 'click', 'a[href="#volver"]', @hide_detail
    @nav_links.click @nav_click
    $(window).resize(@layout).resize()
    @player = new CCDPlayer
      btn: '.escucha-btn'
      host: window.STREAM.hostname
      port: window.STREAM.port

  nav_click: (e) =>
    classStr = '.' + $(e.currentTarget).attr('href').substr(1)
    animateIn = =>
      @activeSection.hide()
      @activeSection = $(classStr, @main)
        .css @transform.hide
        .show()
        .transition @transform.show
    @activeSection.transition @transform.hide, animateIn

    return false

  show_detail: (e) =>
    href = e.currentTarget.href
    calendar = $('.calendario')
    @bio_container.show().css @transform.hide2
    @bio_container.load href, =>
      @bio_container.transition @transform.show
      calendar.transition @transform.hide
    false

  hide_detail: (e) =>
    calendar = $('.calendario').show()
    calendar.transition @transform.show
    @bio_container.transition @transform.hide2, => @bio_container.hide()
    false

  layout: =>
    viewportH = $.viewport().height
    footerH = $('footer').outerHeight()
    @sections.css height: viewportH - footerH

$(document).ready ->
  window.app = new Main