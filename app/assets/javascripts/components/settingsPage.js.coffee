"use strict"

class CMW.Settings
	
	constructor: ->
		_save()

	_save = ->
		$.hook("save-settings").on "submit", (event) ->
			event.preventDefault()
			$form = $ @
			z_.popup
				title   : "Введите пароль"
				content : '<h2>для изменения настроек безопасности нужно повторно ввести пароль</h2><div><input type="password" value="" class="b-input_text" data-hook="settings-current-password" /></div>'
				footer  : '<div class="b-button b-button_yellow b-button_last b-button_settings b-settings__commit-button" data-hook="settings-go">Подтвердить</div><div class="b-button b-button_yellow b-button_last b-button_settings b-settings__commit-button" data-hook="settings-close">Назад</div>'
				callback: ->
					$thisPopup = z_.popup_last()
					$.hook("settings-go").on "click", ->
						currentPassword = $.hook("settings-current-password")[0].val()
						if currentPassword
							$.hook("settings-current").value currentPassword
							$form.submit()
						else
							$(@).addClass "z-button_warning"
							z_.alert
								wrap   : z_.popup_last().find ".z-popup__alert"
								type   : "warning"
								message: "Пароль не введен."
							return
					return

