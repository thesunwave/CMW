"use strict"

class CMW.Common
	constructor: ->
		_disableHover()

	_disableHover = ->
		$body = $("body")
		timer = 0
		$(window).on "scroll", ->
			clearTimeout timer
			$body.addClass "disableHover"  unless $body.hasClass "disableHover"
			timer = setTimeout(->
				$body.removeClass "disableHover"
				return
			, 500)
			return
		return
