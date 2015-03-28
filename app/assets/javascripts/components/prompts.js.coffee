"use strict"

class CMW.Prompts

	self = @

	constructor: (prompt, callback) ->
		_init prompt
		_select prompt, callback

	_init = (prompt) ->
		prompt
			.on "mouseover", ->
				self::show $(@)
				return
			.on "mouseout", ->
				self::hide $(@)
				return
		return

	show: (prompt) ->
		prompt.find(".b-prompt__modal").addClass "b-prompt__modal_showen"
		return

	hide: (prompt) ->
		prompt.find(".b-prompt__modal").removeClass "b-prompt__modal_showen"
		return

	_select = (el, callback) ->
		el.on "click", ".b-prompt__modal__line", ->
			$(@).siblings(".b-prompt__modal__line").removeClass "b-prompt__active"
			$(@).addClass "b-prompt__active"
			el.find(".b-prompt__modal__line").removeClass "b-prompt__active"
			$(@).addClass "b-prompt__active"
			el.find(".b-prompt__current").text $(@).text()
			callback()
			return
		return

	getState: (prompt) ->
		prompt.find(".b-prompt__active").data "state"


class CMW.Prompts_handlers

	self = @

	Common = new CMW.Common()

	PATH = "/views/index/"

	constructor: ->
		self::what  = new CMW.Prompts $.hook("prompt-what"), _what
		self::where = new CMW.Prompts $.hook("prompt-where"), _where
		$.hook("prompt-default").trigger "click"

	_what = (what) ->
		url = self::what.getState $.hook("prompt-what")
		url = PATH + url + "/" + (Common.urlSegment(4) || "")
		_changeOther url
		return

	_where = (where) ->
		url = self::where.getState $.hook("prompt-where")
		url = PATH + Common.urlSegment(3) + "/" + url
		_changeOther url
		return

	window.onpopstate = ->
		_changeOther location.pathname
		return

	_changeOther = (url) ->
		$body = $ "body"
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
			history.pushState "", "New URL: " + url, url
			return
		.fail ->
			return
		.always ->
			return
		return

