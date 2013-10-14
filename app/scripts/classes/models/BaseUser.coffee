# BaseUser
define [], () ->
    class BaseUser

      _id       : null
      _username : null
      _point    : null

      construct: ->

      # add user
      addUser: (id, username) ->
        @_id        = id
        @_username  = username

      # remove user
      removeUser: ->


      # add point to user
      addPoint: (point) ->

      # remove user point
      removePoint: (point) ->

