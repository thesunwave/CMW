"use strict"

class CMW.Panel

	self = @

	constructor: ->
		_top()

	goTop: ->
		$("html, body").stop().animate
			scrollTop: 0
		return

	_top = ->
		$.hook("scroll-top").on "click", ->
			self::goTop()
		return
