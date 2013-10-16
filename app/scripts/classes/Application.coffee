define [
    'jquery',
    'cs!classes/NavManager', 
    'cs!classes/ModuleManager', 
    'cs!classes/Nav'
  ], 
  ($, NavManager, ModuleManager, NAV) ->
    class Application
      
      _navManager: null

      constructor: ->
        # instanciate NavManager
        @_navManager    = new NavManager()

        # instanciate ModuleManager
        @_moduleManager = new ModuleManager()

        # set default view
        @_navManager.set NAV.EXPERIENCE

        @initListeners()

      initListeners: =>
        $('button.link__internal, a.link__internal').on "click", @_setView

      _setView: (e) =>
        e.preventDefault() if e
        @_navManager.set $(e.target).attr('data-nav-id')