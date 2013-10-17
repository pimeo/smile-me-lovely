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

      _tm       : null    
      _loopSmileMe : null 

      _voiceType: null
      _sexColor: null

      constructor: ->
        console.log 'EXPERIENCE CONTROLLER'
        BaseController.call @
        @_rootNode = $('#experience')

        # waiting for camera state
        window.appEvents.camera.add @_userActions

        @_canvas = new CanvasGL "experience-canvas"
      
      _userActions: (event) =>
        switch event                                                                                                                                                                                                     
          when "$camera.ready" then @_initUsers()
          when "$camera.refused" then @_deactivateUsers()
          else return 0


      # initialize users
      _initUsers: =>
        console.log @_sexColor
        @_user = new User 1, "player1", @_sexColor
        @_canvas.addUser @_user

        # start experience
        @startExperience()


      # remove users
      _deactivateUsers: =>


      _simulateCamera: =>
        console.log 'simulation camera ready'
        setTimeout (->
          window.appEvents.camera.dispatch "$camera.ready"
        ), 1000

      show: ->

        @_voiceType = if @sexColor == "boy" then "f" else "h"

        @_tm = new TimelineMax({paused: true, onComplete: @endExperienceAnimation})
        time = 0
        @_tm.to($('.experience__title'), 0.5, {autoAlpha: 1, ease: Cubic.easeOut}, time+=0.3)

        @_loopSmileMe = setInterval (=>
          soundManager.play 'sound-'+@_voiceType+'-13',
            volume: if @_voiceType == "f" then 30 else 60
        ), 10000

        @_tm.play()

        super

      endExperienceAnimation: =>
        console.log 'endExperienceAnimation'
        @_tm.kill()
        @_smile  = new SmileDetectManager();

        #@_canvas.update()
        #
        #@_simulateCamera()

      startExperience: =>
       TweenMax.to($('.experience__title'), 0.5, {autoAlpha: 0, marginTop: -30, ease: Cubic.easeOut, onComplete: =>
        #launch render canvas for canvasGL
          @_canvas.active = true
        })


      hide: ->
        clearInterval @_loopSmileMe
        super

      initListeners: ->

      initParams: (params) ->
        @_sexColor = params

      dispose: ->
        super
