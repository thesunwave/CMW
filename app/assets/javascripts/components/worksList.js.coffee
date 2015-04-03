"use strict"

class CMW.Works_list

	Common = new CMW.Common()

	constructor: ->
		_changeView()
		_changeViewViaUrl()

	_changeViewViaUrl = ->
		if location.hash is "#grid"
			$(".b-news__view_change__item_grid").trigger "click"
		else
			$(".b-news__view_change__item_list").trigger "click"
		return

	_changeView = ->
		$(".b-news__view_change")
			.on "click", ".b-news__view_change__item_list", ->
				_pathReplace()
				_changeViewLogic $(@), location.pathname + "#list"
				_changeDateView "list"
				$(".b-news-wrapper").removeClass("b-news_grid").addClass "b-news_list"
				$(".b-new").find(".b-new__content").show()
				return
			.on "click", ".b-news__view_change__item_grid", ->
				_pathReplace()
				_changeViewLogic $(@), location.pathname + "#grid"
				_changeDateView "grid"
				$(".b-news-wrapper").removeClass("b-news_list").addClass "b-news_grid"
				_gridHover()
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

	_gridHover = ->
		$(".b-news_grid").find(".b-new")
			.on "mouseenter", ->
				if $(".b-news-wrapper").is(".b-news_grid")
					$(@).find(".b-new__content").stop().fadeIn 250
				return
			.on "mouseleave", ->
				if $(".b-news-wrapper").is(".b-news_grid")
					$(@).find(".b-new__content").stop().fadeOut 250
				return
		return

	_changeDateView = (type) ->
		$added = $ ".b-new__service__item__content_added"
		if type is "list"
			$added.html $added.data "list-date"
		else
			$added.html $added.data "grid-date"
		return
		
