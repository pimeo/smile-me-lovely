define [
    'TweenMax', 
    'jquery',
    'cs!classes/modules/BaseController',
    'cs!classes/ui/CanvasGL'
    'cs!classes/ui/SmileDetectManager'
    'cs!classes/models/User'
  ],
  (TweenMax, $, BaseController, CanvasGL, SmileDetectManager, User) ->
    class ExperienceController extends BaseController
      
      _rootNode : null
      _canvas   : null
      _user     : null

      constructor: ->
        console.log 'EXPERIENCE CONTROLLER'
        BaseController.call @
        @_rootNode = $('#experience')

        # waiting for camera state
        window.appEvents.camera.add @_userActions

        @_canvas = new CanvasGL "experience-canvas"
        @_canvas.update
        #@_smile  = new SmileDetectManager();
        @_simulateCamera()
      
      _userActions: (event) =>
        switch event
          when "$camera.ready" then @_initUsers()
          when "$camera.refused" then @_deactivateUsers()
          else return 0


      # initialize users
      _initUsers: =>
        @_user = new User 1, "player1"
        @_canvas.addUser @_user


      # remove users
      _deactivateUsers: =>


      _simulateCamera: =>
        console.log 'simulation camera ready'
        setTimeout (->
          window.appEvents.camera.dispatch "$camera.ready"
        ), 1000

      show: ->
        super

      hide: ->
        super

      initListeners: ->

      dispose: ->
        super
