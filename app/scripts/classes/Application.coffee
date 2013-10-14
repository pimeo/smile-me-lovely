define ['jquery', 'cs!classes/NavManager', 'cs!classes/Nav'], ($, NavManager, NAV) ->
  class Application
    
    _navManager: null

    constructor: ->
      # launch signal for event

      # instanciate NavManager
      @_navManager = new NavManager()

      # set default view
      @_navManager.set( NAV.HOME )