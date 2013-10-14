window.appEvents = null;

require.config({
  paths: {
    jquery          : '../bower_components/jquery/jquery',
    signals         : '../bower_components/js-signals/dist/signals.min', 
    tweenMax        : '../bower_components/greensock-js/src/minified/TweenMax.min',
    cs              : '../bower_components/require-cs/cs',
    'coffee-script' : '../bower_components/coffee-script/index',
  },
  exclude     : ['coffee-script'],
  stubModules : ['cs'],
});

require(['app', 'cs!classes/Application', 'cs!classes/modules/BaseController', 'signals'], function (app, Application, BaseController, signals) {
  'use strict';

  // launch signals events
  window.appEvents = {
    nav: new signals.Signal()
  }

  console.log(window.appEvents);
  // launch application
  window.app = new Application();
});

