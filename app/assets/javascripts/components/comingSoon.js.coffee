"use strict"

class CMW.Coming_soon

	constructor: ->
		_sender()

	_sender = ->
		$form = $.hook "coming-soon"
		$form.on "submit", (event) ->
			event.preventDefault()
			coming_soon_email_val = $.hook("coming-soon-email").val().trim()
			if _validateEmail(coming_soon_email_val)
				$.ajax
					url: "/coming_soon/"
					type: "POST"
					data: $form.serialize()
				.done (data) ->
					try
						json = JSON.parse(data)
						z_.alert
							timeout: 10000
							type: json.type
							message: json.message
					catch e
						_unknownError()
					return
				.fail ->
					_unknownError()
					return
				.always (data) ->
					console.log data.responseText
			else
				z_.alert
					timeout: 10000
					type   : "warning"
					message: "Похоже, вы допустили ошибку."
			return
		return

	_validateEmail = (email) ->
		re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
		re.test email

	_unknownError = ->
		z_.alert
			timeout: 10000
			type: "warning"
			message: "Непредвиденная ошибка. Не волнуйтесь, мы уже знаем о ней."
		return

