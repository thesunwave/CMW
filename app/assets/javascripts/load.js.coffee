"use strict"

class CMW.Initialize
	constructor: ->
		@plugins()
		@loader()

	plugins: ->
		new zoQ.Init
			Alerts    : true
			Popups    : true
			AjaxEnable: false

		$.hook("panel").stick_in_parent()

		return
		
	loader: ->
		new CMW.Common()
		new CMW.Panel()
		return

$ ->
	new CMW.Initialize()
	return
