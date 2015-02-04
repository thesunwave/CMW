"use strict"

class CMW.Common
	constructor: ->
		_disableHover()

	_disableHover = ->
		$body = $ "body"
		timer = 0
		$(window).on "scroll", ->
			clearTimeout timer
			$body.addClass "g-hover_disabled"  unless $body.hasClass "g-hover_disabled"
			timer = setTimeout(->
				$body.removeClass "g-hover_disabled"
				return
			, 150)
			return
		return
