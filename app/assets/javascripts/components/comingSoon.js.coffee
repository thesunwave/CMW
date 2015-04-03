"use strict"

class CMW.Coming_soon

	PATH = "/coming_soon/"

	constructor: ->
		_sender()

	_sender = ->
		$form = $.hook "coming-soon"
		$form.on "submit", (event) ->
			event.preventDefault()
			coming_soon_email_val = $.hook("coming-soon-email").val().trim()
			if _validateEmail(coming_soon_email_val)
				$.ajax
					url : PATH
					type: "POST"
					data: $form.serialize()
				.done (data, textStatus, jqXHR) ->
					if jqXHR.status == 200
						z_.alert
							timeout: 10000
							type   : "success"
							message: "Ваш email добавлен в базу. Спасибо, что Вы с нами :)"
					else
						_error "Непредвиденная ошибка. Не волнуйтесь, мы уже знаем о ней."
					return
				.fail ->
					_error "Email уже зарегистрирован."
					return
			else
				_error "Похоже, вы допустили ошибку."
			return
		return

	_validateEmail = (email) ->
		re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
		re.test email

	_error = (message) ->
		z_.alert
			timeout: 5000
			type   : "warning"
			message: message
		return
