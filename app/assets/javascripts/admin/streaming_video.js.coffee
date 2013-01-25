class window.StreamingVideo
  constructor: (venue_id, url, container) ->
    @streamName = venue_id + ".stream"
    @url = url # exp: 'http://54.243.187.20:1935/loadbalancer'
    @container = container
    # @ajaxStreamingVideo()
    # @loadPlayer("54.243.187.20")
    @showPlayer(url, venue_id)


  ajaxStreamingVideo: =>
    jQuery.ajax
      type: "GET"
      url: @url
      dataType: 'text'
      # async: false
      success: (result) =>
        console.log "succeeded"
        @parseResponse(result)
      error: (errors, status) =>
        console.log "failed"
        if @url.match(/http:\/\/www/)
          from = 10
        else if @url.match(/http:\/\//)
          from = 7
        else
          from = 0

        if @url.search(/:[0-9]/) != -1
          to = @url.search(/:[0-9]/)
        else
          @url.length
        ip = @url.substring(from, to) # exp: 54.243.187.20
        @loadPlayer(ip)

  parseResponse: (data) =>
    str = data
    ip = str.substring(10, str.length)
    @loadPlayer(ip)

  loadPlayer: (ip) =>
    console.log "http://" + ip + "/live/" + @streamName + "/playlist.m3u8"
    jwplayer(@container).setup
      'id': @container
      'width': '480'
      'height': '360'
      'provider': "rtmp"
      'streamer': "rtmp://" + ip + "/live/"
      'allowscriptaccess': 'always'
      'autostart': true
      'file': @streamName
      'flashplayer': "/jwplayer/player.swf"
      # 'modes': [
      #   type: "flash"
      #   src: "jwplayer/player.swf"
      # ,
      #   type: "html5"
      #   config:
      #     'file': "http://" + ip + "/live/" + @streamName + "/playlist.m3u8"
      #     provider: "video"
      # ]

  showPlayer: (url, venue_id) =>
    console.log "#{url}/StreamInfo?id=#{venue_id}&type=flash"
    jwplayer(@container).setup
      id: @container
      flashplayer: "/jwplayer/player.swf"
      playlistfile: "#{url}/StreamInfo?id=#{venue_id}&type=flash"
      autostart: true
      allowscriptaccess: 'always'
      width: '640'
      height: '360'
      plugins:
        "/jwplayer/pip.swf":
          pWidth: "20"
          pHeight: "20"
          bottom: "100"
          right: "200"
          playlistfile: "#{url}/StreamInfo?id=#{venue_id}&type=flash"

        "/jwplayer/zoom.swf":
          pluginWidth: "160"
          pluginHeight: "90"
          left: "50"
          bottom: "50"
