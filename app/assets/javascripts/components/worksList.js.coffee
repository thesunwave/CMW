"use strict"

class CMW.Works_list

	Common = new CMW.Common()

	constructor: ->
		_changeView()

	_changeView = ->
		$(".b-news__view_change")
			.on "click", ".b-news__view_change__item_list", ->
				_pathReplace()
				_changeViewLogic $(@), location.pathname + "#list"
				return
			.on "click", ".b-news__view_change__item_grid", ->
				_pathReplace()
				_changeViewLogic $(@), location.pathname + "#grid"
				return
		return

	_changeViewLogic = (el, url) ->
		$(".b-news__view_change__item").removeClass "b-news__view_active"
		el.addClass "b-news__view_active"
		Common.historyPush url
		return

	_pathReplace = ->
		PATH = location.pathname.replace "#list", ""
		PATH = location.pathname.replace "#grid", ""
		return
