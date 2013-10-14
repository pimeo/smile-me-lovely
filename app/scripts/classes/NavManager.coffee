define [
  'cs!classes/Nav', 
  'cs!classes/modules/HomeController', 
  'cs!classes/modules/ExperienceController'
  ], 
  (NAV, HomeController, ExperienceController) ->
  
    # NavManager
    class NavManager
      _classes: null
      _currentID: null
      
      constructor: ->
        # classes nav manager
        @_classes = []
        @_classes[NAV.HOME]      = HomeController;
        @_classes[NAV.EXPERIENCE] = ExperienceController;


      set: (id) ->
        return if @_currentID == id
        @_currentID = new @_classes[id]()
        console.log 'here', id