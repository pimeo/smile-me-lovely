define [
    'jquery',
  ], 
  ($) ->
    class AudioLoader
      _ambiance     : []
      _voicesMen    : []
      _voicesWomen  : []

      constructor: ->
        @_voicesMen = [
          {id: 'sound-h-01', url: '../sounds/men/h-01.mp3'},
          {id: 'sound-h-02', url: '../sounds/men/h-02.mp3'},
          {id: 'sound-h-03', url: '../sounds/men/h-03.mp3'},
          {id: 'sound-h-04', url: '../sounds/men/h-04.mp3'},
          {id: 'sound-h-05', url: '../sounds/men/h-05.mp3'},
          {id: 'sound-h-06', url: '../sounds/men/h-06.mp3'},
          {id: 'sound-h-07', url: '../sounds/men/h-07.mp3'},
          {id: 'sound-h-08', url: '../sounds/men/h-08.mp3'},
          {id: 'sound-h-09', url: '../sounds/men/h-09.mp3'},
          {id: 'sound-h-10', url: '../sounds/men/h-10.mp3'},
          {id: 'sound-h-11', url: '../sounds/men/h-11.mp3'},
          {id: 'sound-h-12', url: '../sounds/men/h-12.mp3'},
          {id: 'sound-h-13', url: '../sounds/men/h-13.mp3'}
        ]

        @_voicesWomen = [
          {id: 'sound-f-01', url: '../sounds/women/f-01.mp3'},
          {id: 'sound-f-02', url: '../sounds/women/f-02.mp3'},
          {id: 'sound-f-03', url: '../sounds/women/f-03.mp3'},
          {id: 'sound-f-04', url: '../sounds/women/f-04.mp3'},
          {id: 'sound-f-05', url: '../sounds/women/f-05.mp3'},
          {id: 'sound-f-06', url: '../sounds/women/f-06.mp3'},
          {id: 'sound-f-07', url: '../sounds/women/f-07.mp3'},
          {id: 'sound-f-08', url: '../sounds/women/f-08.mp3'},
          {id: 'sound-f-09', url: '../sounds/women/f-09.mp3'},
          {id: 'sound-f-10', url: '../sounds/women/f-10.mp3'},
          {id: 'sound-f-11', url: '../sounds/women/f-11.mp3'},
          {id: 'sound-f-12', url: '../sounds/women/f-12.mp3'},
          {id: 'sound-f-13', url: '../sounds/women/f-13.mp3'}
        ]

        @_ambiance = [
          id: 'sound-a-01', url: '../sounds/ambiance/a-01.mp3'
        ]

        @_preloadAudio()

      _preloadAudio: ->
        for i in [0...@_voicesMen.length]
          @_voicesMen[i].autoLoad = true
          soundManager.createSound @_voicesMen[i] if @_voicesMen[i]
        for i in [0...@_voicesWomen.length]
          @_voicesWomen[i].autoLoad = true
          soundManager.createSound @_voicesWomen[i] if @_voicesWomen[i]
        for i in [0...@_ambiance.length]
          @_ambiance[i].autoLoad = true
          soundManager.createSound @_ambiance[i] if @_ambiance[i]

