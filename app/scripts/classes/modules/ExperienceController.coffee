define [
  'tweenMax', 
  'jquery',
  'cs!classes/modules/BaseController'
  ],
  (TweenMax, $, BaseController) ->
    class ExperienceController extends BaseController
      
      _rootNode : null
      _canvas   : null
      _ctx      : null 

      constructor: ->
        console.log 'EXPERIENCE CONTROLLER'
        BaseController.call @
        @_rootNode = $('#experience')
      
      show: ->
        super


      hide: ->
        super

      initListeners: ->

      dispose: ->
        super
