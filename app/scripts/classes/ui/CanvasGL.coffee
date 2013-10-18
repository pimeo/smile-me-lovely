define [
    'jquery'
    'cs!classes/display/User'
    'cs!classes/ui/Radar'
    'cs!classes/ui/Others'
  ], 
  ($, User, Radar, Others) ->

    class CanvasGL
      
      _w      : null
      _h      : null
      _el     : null

      _user  : null
      _radar: null
      _others : null

      _stage    : null
      _renderer : null
      _userGRDispContainer : null

      active: false

      constructor: (container) ->

        window.canvasGL = @
        
        @_el = document.getElementById(container)

        # create canvas
        @_createCanvas()

        # dispatch start to main application 
        window.appEvents.canvas.dispatch "start"
        
        # resize
        $(window).resize @_resize
        setTimeout @_resize, 0

      _createCanvas: =>
        # 0xED146F
        @_stage             = new PIXI.Stage()
        @_stage.interactive = true
        @_renderer          = new PIXI.CanvasRenderer(@_w, @_h, null, true)
        @_el.appendChild(@_renderer.view)
        @_renderer.view.style.position = "absolute"
        @_renderer.view.style.top      = @_renderer.view.style.left = "0px"
        @_renderer.view.style.display  = "block"

        @_userDispContainer = new PIXI.DisplayObjectContainer()
        @_stage.addChild @_userDispContainer

        # create Radar
        @_radar = new Radar()
        @_stage.addChild @_radar

      _resize: =>
        @_w = window.innerWidth
        @_h = window.innerHeight
        @_renderer.resize @_w, @_h

      # graphic create point
      addUser: (entity) =>
        @_user = new User(entity)
        @_userDispContainer.addChild @_user

        # add others
        @_others = new Others(entity.getOpposedColor(entity.sexColor))
        @_stage.addChild @_others
        @_stage.swapChildren @_userDispContainer, @_others

        # add choosen one

      # GLOBAL REDRAWING STAGE
      update: (dt) =>
        #requestAnimationFrame @update
        @_user.update() if @_user
        @_radar.update() if @_radar
        @_others.update() if @_others
        @_renderer.render @_stage