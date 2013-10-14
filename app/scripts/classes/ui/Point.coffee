# User Point
define [], () ->
  class Point

    _x: null
    _y: null

    _w: null
    _h: null

    constructor: (x, y) ->
      console.log 'point !'
      @_x = 0
      @_y = 0

      @_w = $(window).width()
      @_h = $(window).height()


    # start : random coordinates
    randomCoordinates: =>
      @_x = Math.floor(Math.random() * @_w)
      @_y = Math.floor(Math.random() * @_h)
      #[@_x, @_y]