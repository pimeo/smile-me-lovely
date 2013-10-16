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

      constructor: (user) ->
        super
        @_user = user
        @_r = 20
        @_d = 10 * 2
        @_n = 100
        @_c = @_user.sexColor
        @_points = []

        @show()

      show: ->
        TweenMax.fromTo(@, 0.8, {_r: 0}, {_r: @_r, ease: Cubic.easeOut, onComplete: @_loop})

      hide: ->
        TweenMax.fromTo(@, 0.8, {_r: 20}, {_r: 0, ease: Cubic.easeOut})

      _loop: =>
        _loopTM = new TimelineMax({paused: @_isPaused, repeat: -1})
        time = 0
        _loopTM.to(@, 3, {_r: 10, ease:Ease.easeInOut}, time)
        _loopTM.to(@, 3, {_r: 20, ease:Ease.easeInOut}, time+=3)

      draw: ->
        @clear()
        @beginFill(@_c, 1)
        @drawCircle(@_user.point.x, @_user.point.y, @_r)
        @endFill()

      update: (dt) ->
        @draw()

      clear: ->
        super

      getCirclePoints: ->
        #for i in [1...@_n + 1]
          #x = @_user.point.x + @_r * Math.sin(i*2*Math.PI/@_n)
          #y = @_user.point.y + @_r * Math.cos(i*2*Math.PI/@_n)
          #@_points.push([x, y])

      pause: ->
        @_isPaused = !@_isPaused





