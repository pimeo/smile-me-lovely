require.config({
  paths: {
    jquery: '../bower_components/jquery/jquery',
    tweenMax: '../bower_components/greensock-js/src/minified/TweenMax.min',
    cs: '../bower_components/require-cs/cs',
    'coffee-script': '../bower_components/coffee-script/index',
  },
  exclude     : ['coffee-script'],
  stubModules : ['cs'],
});

require(['app', 'cs!classes/Application', 'cs!classes/modules/BaseController'], function (app, Application, BaseController) {
  'use strict';
  // launch application
  window.app = new Application()
});

