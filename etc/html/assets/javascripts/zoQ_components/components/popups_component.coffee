"use strict"

class zoQ.Popups

	$body = $ "body"
	popup = false
	self  = @

	add: (params = {}) ->
		popup = 
			wrap    : params.wrap     or $ ".popupsWrap"
			addClass: params.addClass or ""
			title   : params.title    or ""
			content : params.content  or ""
			footer  : params.footer   or '<div class="button removePopup">Закрыть</div>'
			callback: params.callback or ->

		_clickRemove _add popup
		return

	remove: ($popup) ->
		$body.removeClass "noScroll"
		$popup.stop().fadeOut ->
			$popup.remove()
			return
		return

	getLastPopup: ->
		if self.popup
			self.popup
		else
			false

	_add = ($popup) ->
		$body.addClass "noScroll"
		$popupView = $ "<div class=\"overlay\"><div class=\"popup unnessesary #{$popup.addClass}\"><div class=\"header\">#{$popup.title}</div><div class=\"content\"><div class=\"popupAlert\"></div>#{$popup.content}</div><div class=\"footer\">#{$popup.footer}</div></div></div>"
		$popup.wrap.append $popupView
		self.popup = $popupView
		$popup.callback()  if $popup.callback and typeof ($popup.callback) is "function"
		$popupView

	_clickRemove = ($popup) ->
		$popup.on "click", ".removePopup", ->
			self::remove $popup
