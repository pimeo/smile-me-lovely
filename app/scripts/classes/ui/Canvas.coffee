define [
    'jquery',
  ], 
  ($) ->
    class Canvas
        @_w = 0
        @_h = 0

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

        @_rootNode.append @_canvas

        @_initWebGL();

      _initWebGL : =>
        try
          console.log "webGL rocks !"
          @_ctx = @_canvas.getContext "webgl" || @_canvas.getContext "experimental-webgl"
        catch e
          alert "Unable to intialize WebGL. Your browser may not support it" if !@_ctx

      _resize: =>
        @_canvas.width  = @_w  = $(window).width()
        @_canvas.height = @_h  = $(window).height()
        @_ctx.viewport 0, 0, @_canvas.width, @_canvas.height