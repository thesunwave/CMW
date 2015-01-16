(function() {
  $(function() {

    /*
    	Document ready
     */

    /*
    	Initializing framework with default parametres
     */
    new zoQ.Init({
      Alerts: true,
      Popups: true,
      AjaxEnable: false
    });

    /*
    	 * Example popup with input validation inside inside
    	 * z_.popup
    	 * 	title   : "Проверить значение"
    	 * 	content : '<div>Значение в инпуте должно быть "Test"</div><input type="text" value="Test" data-hook="myPopup-watch-input" />'
    	 * 	footer  : '<div class="button" data-hook="myPopup-test-value">Проверить</div>'
    	 * 	callback: ->
    	 * 		$thisPopup = z_.popup_last()
    	 * 		$.hook("myPopup-test-value").on "click", ->
    	 * 			# Проверка на значение
    	 * 			if $.hook("myPopup-watch-input").val() is "Test"
    	 * 				# Добавляем класс success к кнопке и удаляем класс warning, если он есть
    	 * 				$(@).removeClass("warning").addClass "success"
    	 * 				# Если значение совпадает с нужным, вызываем вложенный алерт с сообщением об успехе
    	 * 				z_.alert
    	 * 					wrap   : $thisPopup.find ".popupAlert"
    	 * 					type   : "success"
    	 * 					message: "Успех! Можно продолжать"
    	 * 				# И уничтожаем попап через 1 секунду
    	 * 				setTimeout ->
    	 * 					z_.popup_remove $thisPopup
    	 * 					return
    	 * 				, 1000
    	 * 				return
    	 * 			else
    	 * 				# Добавляем класс warning к кнопке
    	 * 				$(@).addClass "warning"
    	 * 				# Если значение не совпадает с нужным, то вызываем вложенный алерт с сообщением об ошибке
    	 * 				z_.alert
    	 * 					wrap   : z_.popup_last().find ".popupAlert"
    	 * 					type   : "warning"
    	 * 					message: "Значение в поле должно быть \"Test\""
    	 * 				return
    	 * 		return
     */

    /*
    	 * Calling the last popup
    	 * z_.popup_last()
     */

    /*
    	 * Calling the last alert
    	 * z_.alert_last()
     */

    /*
    	 * Removing the last popup
    	 * z_.popup_remove z_.popup_last()
     */

    /*
    	 * Removing the last alert
    	 * z_.alert_remove z_.alert_last()
     */

    /*
    	 * Default alert parametres
    	 * z_.alert
    	 * 	wrap         : $ ".alertsWrap"
    	 * 	type         : "info"
    	 * 	addClass     : ""
    	 * 	timeout      : 30000
    	 * 	message      : ""
    	 * 	closeTarget  : ".close"
    	 * 	closeText    : ""
    	 * 	closeAddClass: ""
    	 * 	onAdd        : ->
    	 * 	onRemove     : ->
     */

    /*
    	 * Default popup parametres
    	 * z_.popup
    	 * 	wrap    : $ ".popupsWrap"
    	 * 	addClass: ""
    	 * 	title   : ""
    	 * 	content : ""
    	 * 	footer  : ""
    	 * 	callback: ->
     */
  });

}).call(this);
