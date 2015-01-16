"use strict"

class CMW.Initialize
	constructor: ->
		@plugins()
		@loader()

	plugins: ->
		FastClick.attach document.body
		return
		
	loader: ->
		new CMW.Common()
		return

$ ->
	new CMW.Initialize()
	return
