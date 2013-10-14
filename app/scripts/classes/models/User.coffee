# USER
define [
  'cs!classes/models/BaseUser',
  'cs!class/ui/LovePoint'
  ],
  (BaseUser, LovePoint) ->
    class User extends BaseUser

      _id: null
      _username: null
      _point: null

      construct: ->
        BaseUser.call @

      addUser: ->
        super

      addPoint: (point) ->

      removePoint: (point) ->
