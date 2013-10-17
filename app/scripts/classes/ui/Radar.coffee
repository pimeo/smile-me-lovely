define [
    'TweenMax'
    'jquery',
    'cs!classes/display/Radar.coffee',
    'cs!classes/display/ArcSpectrum.coffee',
  ], 
  (TweenMax, $, RadarGraphics, ArcSpecGraphics) ->
    class Radar extends PIXI.DisplayObjectContainer

      _circles      : null
      _indexCircle  : 0
      _arc          : null

      constructor: ->
        super

        @_circles = []

        setInterval (=>
          @_indexCircle++
          #console.log @_circles.length
          c = new RadarGraphics(@_indexCircle)
          @_circles.push(c)
          @.addChild c
          c.start(@dispose)
        ), 1500


        @_arc = new ArcSpecGraphics()
        @_arc.position.x = 100
        @_arc.position.y = 100
        @.addChild @_arc

      update: (dt) ->
        for i in [0...@_circles.length]
          @_circles[i].update()

        @_arc.update() if @_arc
        
      dispose: =>
        c = @_circles.shift()
        @.removeChild c











