"use strict"

class zoQ.Core

	@version = "2.0.2"
	self     = @

	constructor: (params = {}) ->
		Alerts = params.Alerts or true
		Popups = params.Popups or true
		Ajax   = 
			enable   : params.AjaxEnable or true
			container: params.AjaxContainer or "body"
			callback :
				done  : params.AjaxDone   or ->
				fail  : params.AjaxFail   or ->
				always: params.AjaxAlways or ->
				start : params.AjaxStart  or ->
				end   : params.AjaxEnd    or ->

		_components Alerts, Popups, Ajax
		_greeting()

	_components = (Alerts, Popups, Ajax) ->
		##################
		if Alerts
			Alerts   = new zoQ.Alerts()
			z_.alert = (params) ->
				Alerts.add params
				return
			z_.alert_last = ->
				Alerts.getLastAlert()
			z_.alert_remove = (alert, onRemove) ->
				Alerts.remove alert, onRemove
				return
		##################
		if Popups
			Popups   = new zoQ.Popups()
			z_.popup = (params) ->
				Popups.add params
				return
			z_.popup_last = ->
				Popups.getLastPopup()
			z_.popup_remove = (popup) ->
				Popups.remove popup
				return
		##################
		if Ajax.enable
			Ajax = new zoQ.Ajax
				container: Ajax.container
				callback : Ajax.callback
			z_.ajax_setPage = (url, callback) ->
				Ajax.setPage
					url     : url
					callback: callback
				return
			return
		##################

	_greeting = ->
		greeting = " zoQ_components v. #{self.version} "
		if /chrome|firefox/i.test(navigator.userAgent.toLowerCase())
			console.log "%c zoQ_components v. #{self.version} ", [
				"background: #ff8400"
				"color: #fff"
			].join ";"
		else
			console.log greeting
