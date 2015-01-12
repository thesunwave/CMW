"use strict"

class zoQ.Alerts

	alert = false
	self  = @

	add: (params = {}) ->
		##################
		alert = 
			wrap    : params.wrap          or $ ".alertsWrap"
			type    : params.type          or "info"
			addClass: params.addClass      or ""
			timeout : params.timeout       or 30000
			message : params.message       or ""
			onAdd   : params.onAdd         or ->
			onRemove: params.onRemove      or ->
		close = 
			target  : params.closeTarget   or ".close"
			text    : params.closeText     or ""
			addClass: params.closeAddClass or ""
		##################
		$alert = _add alert, close
		##################
		_timeoutRemove $alert, alert.timeout, alert.onRemove
		_clickRemove   $alert, close.target,  alert.onRemove
		##################
		alert.onAdd()  if alert.onAdd and typeof (alert.onAdd) is "function"
		return

	remove: ($alert, onRemove = ->) ->
		$alert.stop().fadeOut ->
			onRemove()  if onRemove and typeof (onRemove) is "function"
			$alert.remove()
			return
		return

	getLastAlert: ->
		if self.alert
			self.alert
		else
			false

	_add = (alert, close) ->
		$alert     = $ "<div class=\"alert #{alert.addClass} #{alert.type}\"><div class=\"message\">#{alert.message}</div><div class=\"close #{close.addClass}\">#{close.text}</div></div>"
		alert.wrap.append $alert
		self.alert = $alert
		$alert

	_timeoutRemove = ($alert, timeout, onRemove) ->
		if timeout
			setTimeout ->
				self::remove $alert, onRemove
				return
			, timeout
			return

	_clickRemove = ($alert, target, onRemove) ->
		$alert.on "click", target, ->
			self::remove $alert, onRemove
			return
		return
