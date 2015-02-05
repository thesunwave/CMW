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

		$.hook("panel").sticky()

		return
		
	loader: ->
		new CMW.Common()
		new CMW.Panel()
		new CMW.Settings()
		return

$ ->
	new CMW.Initialize()
	return
