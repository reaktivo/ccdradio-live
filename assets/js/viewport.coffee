jQuery.viewport = ->
  if typeof window.innerWidth is 'undefined'
    width: document.documentElement.clientWidth
    height: document.documentElement.clientHeight
  else
    width: window.innerWidth
    height: window.innerHeight