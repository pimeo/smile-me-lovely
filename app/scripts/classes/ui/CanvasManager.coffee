define ['jquery'], ($) ->
  class CanvasManager
    _w  : null
    _h  : null
    _el : null

    construct: (el) ->
      console.log('gererere')
      @_w = 0
      @_h = 0

      @_el = $(el)

      # create canvas
      @_createCanvas()
      # resize
      $(window).resize @_resize
      setTimeout @_resize, 0

    _createCanvas: =>
      @_canvas = document.createElement('canvas')
      $(@_canvas).css
        position: 'absolute'
        top: 0
        left: 0
        zIndex: 1
        width: @_w
        height: @_h

      @_el.append @_canvas

      try
        console.log "webGL rocks !"
        @_ctx = @_canvas.getContext "webgl" || @_canvas.getContext "experimental-webgl"
      catch e
        alert "Unable to intialize WebGL. Your browser may not support it" if !@_ctx

      unless @_ctx
        throw new Error "cannot create webGL context"

    _resize: =>
      @_canvas.width  = @_w  = $(window).width()
      @_canvas.height = @_h  = $(window).height()
      @_ctx.viewport 0, 0, @_canvas.width, @_canvas.height