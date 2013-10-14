define ['jquery'], ($) ->
  class BaseController

    _rootNode: null

    # constructor
    constructor: ->
      console.log 'BaseController'
      @initListeners()

    # show module
    show: ->
      @_rootNode.removeClass 'hide'

    # hide module
    hide: ->
      @_rootNode.addClass 'hide'
      @dispose()

    # listeners
    initListeners: ->

    # dispose
    dispose: ->
