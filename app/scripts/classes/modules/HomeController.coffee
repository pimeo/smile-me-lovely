define [
  'tweenMax', 
  'jquery',
  'cs!classes/modules/BaseController'
  ],
  (TweenMax, $, BaseController) ->
    class HomeController extends BaseController
      _rootNode : null

      constructor: ->
        console.log 'HOME CONTROLLER'
        BaseController.call @
        @_rootNode = $('#home')

      show: ->
        super

      hide: ->
        super

      dispose: ->