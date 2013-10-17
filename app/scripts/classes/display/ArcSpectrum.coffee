define [
    'TweenMax'
    'jquery',
  ], 
  (TweenMax, $) ->
    class ArcSpectrum extends PIXI.Graphics

      _id: 0
      _arcSprite: null

      constructor: (id)->
        super
        @_id      = id 
        @_color   = "0xF25790"
        @_rayon   = 0
        @_opacity = 1

        console.log @

      #(p_angle - 90) * Math.PI / 180;
      draw: ->
        #@beginFill()
        #@lineStyle 1, 0x00FF00, 1
        #@drawArc 0, 0, (30 * Math.PI / 180), 0, 30
        #@endFill()

      update: (dt) ->
        @draw()

      clear: ->
        super

      drawArc: ->
        super






