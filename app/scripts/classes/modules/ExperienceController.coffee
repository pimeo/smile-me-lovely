define [
    'tweenMax', 
    'jquery',
    'cs!classes/modules/BaseController',
    'cs!classes/ui/CanvasContainer'
  ],
  (TweenMax, $, BaseController, CanvasContainer) ->
    class ExperienceController extends BaseController
      
      _rootNode : null
      _canvas   : null

      constructor: ->
        console.log 'EXPERIENCE CONTROLLER'
        BaseController.call @
        @_rootNode = $('#experience')

        @_canvas = new CanvasContainer "#experience-canvas"
        console.log @_canvas
      
      show: ->
        super

      hide: ->
        super

      initListeners: ->

      dispose: ->
        super
