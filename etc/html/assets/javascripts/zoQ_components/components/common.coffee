$.extend hook: (hookName) ->
	if not hookName or hookName is "*"
		selector = "[data-hook]"
	else
		selector = "[data-hook~=\"#{hookName}\"]"
	$ selector

$body = $ "body"

hoverOff = ->
	timer = 0
	$(window).on "scroll", ->
		clearTimeout timer
		$body.addClass "hoverOff"  unless $body.hasClass "hoverOff"
		timer = setTimeout(->
			$body.removeClass "hoverOff"
			return
		, 500)
		return
	return

unLoadHolder = ->
	$body.removeClass "unloaded"

disabledElements = ->
	$(".disabled").on "click", (event) ->
		event.preventDefault()

hoverOff()
unLoadHolder()
disabledElements()