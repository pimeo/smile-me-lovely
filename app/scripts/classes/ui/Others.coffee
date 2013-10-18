define [
    'TweenMax'
    'jquery',
    'cs!classes/display/Other.coffee',
  ], 
  (TweenMax, $, OtherGraphics) ->
    class Others extends PIXI.DisplayObjectContainer

      _users     	: null
      _indexUser  	: 0
      _usersLength   : 100

      constructor: (color)->
        super

        console.log @

        @_users = []

        timeAppears = 0
        for i in [0...@_usersLength]
          setTimeout (=>
            @_indexUser++
            c = new OtherGraphics(@_indexUser, color)
            @_users.push(c)
            @.addChild c
          ), timeAppears+=200

  
        console.log @_users

      update: (dt) ->
        for i in [0...@_users.length]
          @_users[i].update()

      dispose: =>


