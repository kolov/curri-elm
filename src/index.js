'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('jquery/dist/jquery.js');
require('bootstrap/dist/css/bootstrap.css');
require('bootstrap/dist/js/bootstrap.js');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var remoteEnd = 'http://civi.akolov.com';
// The third value on embed are the initial values for incoming ports into Elm
var app = Elm.Main.embed(mountNode,
  {'endpoints': { 'auth': remoteEnd,
//                  'users': remoteEnd + '/service',
                  'users': 'http://localhost:8501/service',
                  'players': 'http://localhost:4000'
                }});