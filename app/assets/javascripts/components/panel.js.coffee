"use strict"

class CMW.Panel

	constructor: ->
		_top()
		_sticky()

	_top = ->
		$.hook("scroll-top").on "click", ->
			$("html, body").stop().animate
				scrollTop: 0
			return
		return

	_sticky = ->
		$window = $ window
		$window.on "resize.stick", ->
			if $.hook("panel").outerHeight() < $window.height()
				$.hook("panel").sticky()
			else
				$.hook("panel").unstick()
			return
		$window.trigger "resize.stick"
		return
