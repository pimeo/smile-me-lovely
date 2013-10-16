define [
  'TweenMax', 
  'jquery',
  'cs!classes/modules/BaseController'
  ],
  (TweenMax, $, BaseController) ->
    class HomeController extends BaseController
      _rootNode : null
      _point: null

      constructor: ->
        console.log 'HOME CONTROLLER'
        BaseController.call @
        @_rootNode = $('#home')

        #@_point = new Point(200, 300)
        #console.log @_point

      show: ->
        super

      hide: ->
        super

      dispose: ->
