"use strict"

class CMW.Comments

	constructor: ->
		_init()
		
	_init = ->
		$(".b-comments__form1").on "submit", (event) ->
			event.preventDefault()
			$(@).serialize()
			console.log $(@).serialize()
			$.ajax
				url : "/comments"
				type: "GET"
			.done (data) ->
				console.log data
				return
			.fail ->
				z_.alert
					type   : "warning"
					message: "Ошибка."
				return
			.always (data) ->
				console.log data
				return
			return
		return
