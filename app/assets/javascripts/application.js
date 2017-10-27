// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

  (function(n,i,_n,j,a){
    n.addEventListener("DOMContentLoaded", function() {
    i['liveninja'] = ["https://messenger.liveninja.com/w/57fe679218762378ba14f064?frame=true"];
    var _n = n.createElement('script');
    var j = n.getElementsByTagName('script')[0];
    _n.async = 1;
    _n.src='https://messenger.liveninja.com/w/assets/widget.js';
    j.parentNode.insertBefore(_n, j);
  })})(document, window);
