"use strict"

class CMW.Prompts

	self = @

	constructor: (prompt, callback = ->) ->
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
