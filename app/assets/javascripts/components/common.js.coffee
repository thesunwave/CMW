"use strict"

class CMW.Common

	self = @
	title = document.title

	constructor: ->

	urlSegments: ->
		window.location.pathname.split "/"

	urlSegment: (segment) ->
		self::urlSegments()[segment]

	historyPush: (url) ->
		url = url.replace "//", "/"
		history.pushState "", "New URL: " + url, url
		return

	showLoading: ->
		if $("body").is ".z-unloaded"
			document.title = "Загрузка. Подождите пожалуйста."
		else
			document.title = title
		return			
		
