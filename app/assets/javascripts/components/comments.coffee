"use strict"

class CMW.Comments

	constructor: ->
		# _init()
		_send()
		
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

	_send = ->
		$("#comment_text").on "keyup", ->
			if $(@).val() != ""
				$("#comment_rating").removeAttr "disabled"
			else
				$("#comment_rating").attr "disabled", ""
			return
		return
