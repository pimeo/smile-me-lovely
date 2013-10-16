define [
    'jquery',
    'cs!classes/utils/SmileDetector'
  ], 
  ($, SmileDetector) ->
    class SmileDetectManager
      
      _smileDetector      : null
      _videoContainer     : null
      _videoID            : null
      _showCamera         : 'hidden'

      _smileState  : null


      constructor: ->
        console.log 'SmileDetectManager'
        @_videoID         = "video-camera-smile"
        @_videoContainer  = $("#experience-camera-smile") 
        @_videoContainer.append "<video id='#{@_videoID}' height='426' width='640' style='visibility:#{@_showCamera};' autoplay></video>"

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
        window.appEvents.camera.add @_cameraStatesHandler

      _cameraStatesHandler: (event) =>
        switch event
          when "$camera.ready"   then @_cameraReady()
          when "$camera.refused" then @_cameraPermissionRefused()
          else return 0

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


