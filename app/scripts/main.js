window.appEvents = null;

var GreenSockAMDPath = "greensock";


require.config({

  paths: {
    jquery          : '../bower_components/jquery/jquery',
    HAAR            : '../libs/js/haar-detector',
    signals         : '../bower_components/js-signals/dist/signals.min', 
    TweenMax        : '../bower_components/greensock-js/src/minified/TweenMax.min',
    TimelineMax     : '../bower_components/greensock-js/src/minified/TimelineMax.min',
    cs              : '../bower_components/require-cs/cs',
    'coffee-script' : '../bower_components/coffee-script/index',
  },
  shim: {
    'TweenMax': {
      exports: 'TweenMax'
    }
  },

  exclude     : ['coffee-script'],
  stubModules : ['cs'],
  waitSeconds: 10
});

// Load all modules
define(function(require) {
  var modules = [
      '../bower_components/pixi/bin/pixi',
      'cs!classes/Application', 
      'cs!classes/modules/BaseController',
      'signals'
  ];

  require(modules, function (Pixi, Application, BaseController, signals) {
  'use strict';

  // launch signals events
  window.appEvents = {
    nav   : new signals.Signal(),
    smile : new signals.Signal() ,
    camera  : new signals.Signal()
  }

  // launch application
  window.app = new Application();
});

});

