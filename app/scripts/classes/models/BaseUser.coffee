# BaseUser
define [], () ->
    class BaseUser

      _id       : null
      username  : null
      point     : null
      sex       : null
      sexColor  : null

      params    : null

      constructor: (id, username, sex)->
        @_id        = id
        @username   = username
        @sex        = if !sex then "girl" else sex
        @point      = {}

        @sexColor   = if @sex == "girl" then "0xF2C4D0" else "0xBAD9D3"

      # add point to user
      _addPoint: (point) ->

      # set point coordinates
      setPoint: (point) ->

      # remove user point
      removePoint: (point) ->

      # dispose
      dispose: =>

      # get params click
      initParams: (params) ->
        @params = params

      getOpposedColor: (color) ->
        _c = null
        if @sexColor == "0xF2C4D0"
          _c = "0xBAD9D3"
        else
          _c = "0xF2C4D0"
        _c

