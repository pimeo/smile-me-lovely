define [
    'TweenMax'
    'jquery',
  ], 
  (TweenMax, $) ->
    class User extends PIXI.Graphics

      _user   : null
      _r      : null
      _c      : null
      _n      : null
      _d      : null
      _points : null

      _loopTM   : null 
      _isPaused : false

      _preventSmileAnimation: false
      _isUserSmiling: false

      userReady : false

      constructor: (user) ->
        super
        @_user = user
        @_r = 0
        @_d = 10 * 2
        @_n = 100
        @_c = @_user.sexColor
        @_points = []


        # create point loop
        @_loopTM = new TimelineMax({paused: @_isPaused, repeat: -1})
        time = 0
        @_loopTM.to(@, 3, {_r: 40, ease:Ease.easeInOut}, time)
        @_loopTM.to(@, 3, {_r: 80, ease:Ease.easeInOut}, time+=3)        

        setTimeout (=>
           @userReady = true
           window.appEvents.smile.add @_smileActionsHandle
        ), 1000

        #@show()

      show: ->
        TweenMax.fromTo(@, 0.8, {_r: 0}, {_r: 80, ease: Cubic.easeOut, onComplete: @_userShown})

      hide: ->
        TweenMax.fromTo(@, 0.8, {_r: @_r}, {_r: 0, ease: Cubic.easeOut, onComplete: @_userHidden})

      _userShown: =>
        #restart loop
        console.log "user shown"
        @_preventSmileAnimation = false
        @_loopTM.restart()

      _userHidden: =>
        @_preventSmileAnimation = false

        # we can ask user smiling

      draw: ->
        @clear()
        @beginFill(@_c, 1)
        @drawCircle(@_user.point.x, @_user.point.y, @_r)
        @endFill()

      update: (dt) ->
        @draw() if @userReady

      clear: ->
        super

      getCirclePoints: ->
        #for i in [1...@_n + 1]
          #x = @_user.point.x + @_r * Math.sin(i*2*Math.PI/@_n)
          #y = @_user.point.y + @_r * Math.cos(i*2*Math.PI/@_n)
          #@_points.push([x, y])

      pause: ->
        @_isPaused = !@_isPaused

      _smileActionsHandle: (event) =>
        if @_preventSmileAnimation
          return

        console.log "user :: event", event

        @_loopTM.stop()

        if event == "smile"
          if !@_isUserSmiling
            console.log "user :: show"
            @_preventSmileAnimation = true
            @show()
            @_isUserSmiling = true
        else
          if @_isUserSmiling
            console.log "user :: hide"
            @_preventSmileAnimation = true
            @hide()
            @_isUserSmiling = false










