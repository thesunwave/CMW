"use strict"

class CMW.Settings
	constructor: ->
		_privateSettings()

	_privateSettings = ->
		$.hook("private-settings-modal").on "click", (event) ->
			event.preventDefault();
			z_.popup
				title   : "Проверить значение"
				content : '<div>Значение в инпуте должно быть "Test"</div><input type="text" value="Test" data-hook="myPopup-watch-input" />'
				footer  : '<div class="b-button" data-hook="myPopup-test-value">Проверить</div>'
				callback: ->
					$thisPopup = z_.popup_last()
					$.hook("myPopup-test-value").on "click", ->
						# Проверка на значение
						if $.hook("myPopup-watch-input").val() is "Test"
							# Добавляем класс success к кнопке и удаляем класс warning, если он есть
							$(@).removeClass("z-button_warning").addClass "z-button_success"
							# Если значение совпадает с нужным, вызываем вложенный алерт с сообщением об успехе
							z_.alert
								wrap   : $thisPopup.find ".z-popup__alert"
								type   : "success"
								message: "Успех! Можно продолжать"
							# И уничтожаем попап через 1 секунду
							setTimeout ->
								z_.popup_remove $thisPopup
								return
							, 1000
							return
						else
							# Добавляем класс warning к кнопке
							$(@).addClass "z-button_warning"
							# Если значение не совпадает с нужным, то вызываем вложенный алерт с сообщением об ошибке
							z_.alert
								wrap   : z_.popup_last().find ".z-popup__alert"
								type   : "warning"
								message: "Значение в поле должно быть \"Test\""
							return
					return
