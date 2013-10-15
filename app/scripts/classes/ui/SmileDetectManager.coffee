define [
    'jquery',
    'cs!classes/utils/SmileDetector'
  ], 
  ($, SmileDetector) ->
    class SmileDetectManager
      
      _smileDetector   : null
      _videoContainer  : null
      _videoID  : null

      constructor: ->
        console.log 'SmileDetectManager'

        @_videoContainer = $("#experience-camera-smile") 
        @_videoContainer.append "<video id='{{#@_videoID}}' height='426' width='640' style='visibility:hidden;' autoplay></video>"
        @_smileDetector   = new SmileDetector "video-camera-smile"

        @_smileDetector.onSmile @_onSmileHandler

      _onSmileHandler: (isSmile) =>
        if isSmile
          window.appEvents.smile.dispatch "$detect.smile"
        else
          window.appEvents.smile.dispatch "$detect.notSmile"

      start: (interval, callback) =>
        @_smileDetector.start(interval, callback)

      stop: (callback) =>
        @_smileDetector.stop(callback)


      dispose: ->
        
