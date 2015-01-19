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

		return
		
	loader: ->
		new CMW.Common()
		return

$ ->
	new CMW.Initialize()
	return
