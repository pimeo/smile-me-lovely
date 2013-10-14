#MODULE MANAGER
define [
    'cs!classes/Nav'
    'cs!classes/modules/HomeController', 
    'cs!classes/modules/ExperienceController'
  ], 
  (NAV, HomeController, ExperienceController) ->

    class ModuleManager

      _currentModule: null
      _nextModule: null
      _modules: null

      constructor: ->
        # classes nav manager
        @_modules = []
        @_modules[NAV.HOME]      = HomeController;
        @_modules[NAV.EXPERIENCE] = ExperienceController;

        window.appEvents.nav.add @_eventNavWillChange

      # before change modules
      _eventNavWillChange: (event, module) =>
        @_nextModule = module 
        if @_currentModule == null then @_show() else @_hide()

      _show: =>
        # save previous module
        @_currentModule = new @_modules[@_nextModule]()
        @_currentModule.show()

      _hide: =>
        @_currentModule.hide();
        @_show();

      deactivate: =>
        window.appEvents.nav.remove @_eventNavWillChange