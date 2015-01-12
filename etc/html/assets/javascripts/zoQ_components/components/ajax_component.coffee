"use strict"

class zoQ.Ajax

	$body = $ "body"
	self  = @
		
	constructor: (params = {}) ->
		self.container = $ params.container

		$body.on "click", "a", (event) ->
			event.preventDefault()
			$(@).addClass "unloaded"
			href = @href
			self::setPage
				url     : href
				callback: params.callback
			history.pushState "", "New URL: " + href, href
			return

		window.onpopstate = ->
			self::setPage
				url: location.pathname
			return

	setPage: (params = {}) ->
		if params.url.indexOf(document.domain) > -1 or params.url.indexOf(":") is -1
			params.callback.start()  if params.callback and params.callback.start and typeof (params.callback.start) is "function"
			params.url = _changeSymbol params.url
			$.ajax
				url : params.url
				type: "GET"
			.done (data) ->
				params.callback.done()  if params.callback and params.callback.done and typeof (params.callback.done) is "function"
				self.container.html data
				_setTitle()
				return
			.fail ->
				params.callback.fail()  if params.callback and params.callback.fail and typeof (params.callback.fail) is "function"
				return
			.always ->
				$body.removeClass "unloaded"
				params.callback.always()  if params.callback and params.callback.always and typeof (params.callback.always) is "function"
				params.callback.end()     if params.callback and params.callback.end    and typeof (params.callback.end)    is "function"
				return
		else
			window.location.href = params.url
		return

	_changeSymbol = (url) ->
		if url.indexOf("?") + 1
			url = "#{url}&ajax"
		else
			url = "#{url}?ajax"

	_setTitle = ->
		$title = self.container.find "#title"
		document.title = unescape $title.val().trim()  if $title.length
		return