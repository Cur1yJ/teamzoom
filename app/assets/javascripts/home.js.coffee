# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.homeObject =
  setup: ->
    @homeSection = $(".home")
    @video_pop()
    return


		video_pop: -> 
			$("#video").on "show", ->
				$("#video div.modal-body").html('<iframe src="http://www.youtube.com/v/Exd7nqV5-cE&amp;rel=0&amp;autohide=1&amp;showinfo=0&amp;autoplay=1" width="500" height="281" frameborder="0" allowfullscreen=""></iframe>')
				return
			return