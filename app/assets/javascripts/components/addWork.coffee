"use strict"

class CMW.Add_work

	constructor: ->
		$("#uploadImage").on "change", ->
			_readURL this
			return
		# Dropzone.autoDiscover = false
		# _tags()
		# _upload()

	_tags = ->
		$("#tagBox").tagging
			"tag-box-class"           : "b-input_text b-input_tag"
			"close-class"             : "b-tag_remove"
			"tag-char"                : ""
			"tags-input-name"         : "tags"
			"close-char"              : ""
			"no-duplicate-callback"   : ->
				_error "Вы уже ввели этот тег."
			"forbidden-chars-callback": ->
				_error "Нельзя вводить этот символ."
		return
	
	_upload = ->
		$("#work_image").dropzone
			maxFilesize   : 5
			paramName     : "work[image]"
			addRemoveLinks: true
			url           : location.href
		return

	_error = (text) ->
		z_.alert
			type   : "warning"
			message: text
			timeout: 10000
		CMW.Panel::goTop()
		return

	_readURL = (input) ->
		if input.files and input.files[0]
			reader = new FileReader
			reader.onload = (e) ->
				$('#image').attr 'src', e.target.result
				return
			reader.readAsDataURL input.files[0]
		return

