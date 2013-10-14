define [
  'tweenMax', 
  'jquery',
  'cs!classes/modules/BaseController',
  # ui
  'cs!classes/ui/CanvasManager'
  
  ],
  (TweenMax, $, BaseController, CanvasManager) ->
    class ExperienceController extends BaseController
      
      _rootNode : null
      _canvas   : null

      constructor: ->
        console.log 'EXPERIENCE CONTROLLER'
        BaseController.call @
        @_rootNode = $('#experience')

        @_canvas = new CanvasManager("#experience-canvas")
      
      show: ->
        super

      hide: ->
        super

      initListeners: ->

      dispose: ->
        super
