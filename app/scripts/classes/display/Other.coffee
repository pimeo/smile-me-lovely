define [
    'TweenMax'
    'jquery',
    'cs!classes/models/User',
  ], 
  (TweenMax, $, User) ->
    class Other extends PIXI.Graphics

      _user   : null
      _r      : null
      _c      : null
      _n      : null
      _d      : null
      _points : null

      _loopTM   : null 
      _isPaused : false

      userReady: false

      constructor: (id, sexColor) ->
        super
        @_user = new User id, "other"+id, sexColor
        @_r = 0
        @_d = 10 * 2
        @_n = 100
        @_c = @_user.sexColor
        @_points = []
        @show()


      draw: ->
        @clear()
        @beginFill(@_c, 1)
        @drawCircle(@_user.point.x, @_user.point.y, @_r)
        @endFill()

      show: ->
        TweenMax.fromTo(@, 0.8, {_r: 0}, {_r: 80, ease: Cubic.easeOut, onComplete: @_userShown})

      _userShown: =>
        @userReady = true

      randomRange: (min, max) ->
        Math.floor( (Math.random() * (max - min + 1) ) + min)


      move: ->
        console.log 'qzdqzdz'

      update: (dt) ->
        @move if @userReady
        @draw()