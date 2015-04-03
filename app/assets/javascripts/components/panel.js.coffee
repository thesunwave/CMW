"use strict"

class CMW.Panel

  constructor: ->
    _top()

  _top = ->
    $.hook("scroll-top").on "click", ->
      $("html, body").stop().animate
        scrollTop: 0
      return
    return