$ ->
	$(".watch_this_video").live "click", ->
		s_id = $(@).attr("id")
		$.ajax
			url: "/schedules/"+parseInt(s_id, 10)
			data: {id: parseInt(s_id, 10)}
			async: false
			cache: false
			statusCode:
				404: ->
					alert("your request is not completed yet due to server request error.")
					return
		return