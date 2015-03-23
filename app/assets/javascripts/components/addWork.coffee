"use strict"

class CMW.Add_work
	constructor: ->
		_tags()

	_tags = ->
		$("#tagBox").tagging
			"tag-box-class"           : "b-input_text b-input_tag"
			"close-class"             : "b-tag_remove"
			"tag-char"                : ""
			"close-char"              : ""
			"no-duplicate-callback"   : ->
				_error "Вы уже ввели этот тег."
			"forbidden-chars-callback": ->
				_error "Нельзя вводить этот символ."
		return

	_error = (text) ->
		z_.alert
			type   : "warning"
			message: text
			timeout: 10000
		CMW.Panel::goTop()
		return
