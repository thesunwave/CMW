class CMW.Prompts_handlers

	self = @

	Common = new CMW.Common()

	PATH = "/"

	constructor: ->
		self::where = new CMW.Prompts $.hook("prompt-settings-privacy")
		if location.pathname is PATH
			self::what  = new CMW.Prompts $.hook("prompt-what"), _what
			self::where = new CMW.Prompts $.hook("prompt-where"), _where
			$.hook("prompt-default").trigger "click"

	_what = (what) ->
		url = self::what.getState $.hook "prompt-what"
		if Common.urlSegment(2)
			url = "#{PATH}#{url}/#{Common.urlSegment(2)}/#{(location.hash || "")}"
		else
			url = "#{PATH}#{url}/#{(location.hash || "")}"
		_changeOther url
		return

	_where = (where) ->
		url = self::where.getState $.hook "prompt-where"
		url = "#{PATH}#{(Common.urlSegment(1) || "")}/#{url}/#{(location.hash || "")}"
		_changeOther url
		return

	window.onpopstate = ->
		_changeOther location.pathname
		return

	_changeOther = (url) ->
		$body = $ "body"
		url = url.replace "//", "/"
		Common.historyPush url
		Common.showLoading()
		$(document)
			.on "ajaxSend", ->
				$body.addClass "z-unloaded"
				return
			.on "ajaxComplete", ->
				$body.removeClass "z-unloaded"
				return
		$.ajax
			url : url
			type: "GET"
		.done (data) ->
			return
		.fail ->
			z_.alert
				type   : "warning"
				message: "Ошибка, связанная со страницей cmw.su#{url}."
			return
		.always ->
			Common.showLoading()
			return
		return
