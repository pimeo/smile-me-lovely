define [
    'jquery',
    'cs!classes/NavManager', 
    'cs!classes/ModuleManager', 
    'cs!classes/Nav',
    'cs!classes/utils/AudioLoader',
    'cs!classes/utils/AudioManager',
  ], 
  ($, NavManager, ModuleManager, NAV, AudioLoader, AudioManager) ->
    class Application
      
      _navManager: null

      constructor: ->
        # instanciate NavManager
        @_navManager    = new NavManager()

        new AudioLoader()

        @_audioManager  = new AudioLoader() 

        # instanciate ModuleManager
        @_moduleManager = new ModuleManager()

        # set default view
        @_navManager.set NAV.HOME

        @initListeners()

      initListeners: =>
        $('button.link__internal, a.link__internal').on "click", @_setView

      _setView: (e) =>
        e.preventDefault() if e
        @_navManager.set $(e.target).attr('data-nav-id')