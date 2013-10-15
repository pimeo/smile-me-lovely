define [
    'jquery',
    'cs!classes/utils/SmileDetector'
  ], 
  ($, SmileDetector) ->
    class SmileDetectManager
      
      _smileDetector      : null
      _videoContainer     : null
      _videoID            : null

      _smileState  : null


      constructor: ->
        console.log 'SmileDetectManager'
        @_videoID         = "video-camera-smile"
        @_videoContainer  = $("#experience-camera-smile") 
        @_videoContainer.append "<video id='#{@_videoID}' height='426' width='640' style='visibility:visible;' autoplay></video>"

        @_initEvents()
        # false : noSmile // true : smile
        @_smileState = false
        @_smileDetector   = new SmileDetector @_videoID

        #@_smileDetector.onSmile @_onSmileHandler
        @_smileDetector.onSmile @_onSmileHandler

      _onSmileHandler: (isSmile) =>
        preventSmileEvent = if @_smileState != isSmile then true else false 

        if isSmile
          # dispatch only one status per action
          if preventSmileEvent
            window.appEvents.smile.dispatch "$detect.smile"
            console.log 'smile'
        else
          if preventSmileEvent
            window.appEvents.smile.dispatch "$detect.noSmile"
            console.log 'no smile'

        @_smileState = isSmile

      _initEvents: =>
        window.appEvents.smile.add @_eventsHandler

      _eventsHandler: (event) =>
        switch event
          when "$detect.ready"   then @_cameraReady()
          when "$detect.refused" then @_cameraPermissionRefused()
          else console.log event

      # camera activated by user
      _cameraReady: =>
        console.log 'CAMERA ACTIVATED'
        # start camera
        @start 100

      _cameraPermissionRefused: =>
        console.log 'CAMERA PERMISSION REFUSED'


      start: (interval, callback) =>
        @_smileDetector.start(interval, callback)

      stop: (callback) =>
        @_smileDetector.stop(callback)

      dispose: ->


