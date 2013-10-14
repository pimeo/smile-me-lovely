define ['cs!classes/Nav'], (NAV) ->  
  # NavManager
  class NavManager
    _classes: null
    _currentID: null

    constructor: ->

    set: (id) ->
      return if @_currentID == id
      @_currentID = id
      # dispatch view that will replace the previous view
      window.appEvents.nav.dispatch "$nav.eventWillChange", @_currentID
