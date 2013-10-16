define [
    'jquery'
    'cs!classes/display/User'
    'cs!classes/ui/Radar'
  ], 
  ($, User, Radar) ->

    class CanvasGL
      
      _w      : null
      _h      : null
      _el     : null

      _user  : null
      _radar: null

      _stage    : null
      _renderer : null
      _userGRDispContainer : null

      constructor: (container) ->
        @_el = document.getElementById(container)

        w = window
        for vendor in ['ms', 'moz', 'webkit', 'o']
            break if w.requestAnimationFrame
            w.requestAnimationFrame = w["#{vendor}RequestAnimationFrame"]
            w.cancelAnimationFrame = (w["#{vendor}CancelAnimationFrame"] or
                                      w["#{vendor}CancelRequestAnimationFrame"])

        targetTime = 0
        w.requestAnimationFrame or= (callback) ->
            targetTime = Math.max targetTime + 16, currentTime = +new Date
            w.setTimeout (-> callback +new Date), targetTime - currentTime
        w.cancelAnimationFrame or= (id) -> clearTimeout id


        # create canvas
        @_createCanvas()

        @update()
        
        # resize
        $(window).resize @_resize
        setTimeout @_resize, 0

      _createCanvas: =>
        @_stage             = new PIXI.Stage(0xED146F)
        @_stage.interactive = true
        @_renderer          = new PIXI.CanvasRenderer(@_w, @_h,null, false)
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

      # GLOBAL REDRAWING STAGE
      update: (dt) =>
        requestAnimationFrame @update
        @_user.update() if @_user
        @_radar.update() if @_radar
        @_renderer.render @_stage

      stop: =>
        cancelAnimationFrame @update



