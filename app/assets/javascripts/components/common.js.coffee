"use strict"

class CMW.Common

	self = @

	constructor: ->

	urlSegments: ->
		window.location.pathname.split "/"

	urlSegment: (segment) ->
		self::urlSegments()[segment]

	historyPush: (url) ->
		history.pushState "", "New URL: " + url, url
		return
