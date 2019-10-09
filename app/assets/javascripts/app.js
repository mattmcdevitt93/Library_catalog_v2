'use strict'
var Module = Module || {};

$(document).on('ready turbolinks:load', function() {
    $(document).foundation();
});

$(document).ready(function() {
	console.log('Ready!')
    Module.bindings();
    // Module.toolbar_resize();
});

Module.bindings = function () {
    	console.log('Bindings')
}

Module.toolbar_slide = function () {
	// $('#toolbar-switch').click(function() {
       if( $('#toolbar').hasClass("toolbar-hidden")) {
    	// console.log('Slide Out')
        $('#toolbar').animate({"margin-left": '+=220'});
        $('#yield').animate({"width": '-=220'});
        $('#toolbar').removeClass("toolbar-hidden");
    } else {
    	// console.log('Slide In')
        $('#toolbar').animate({"margin-left": '-=220'});
        $('#yield').animate({"width": '+=220'});
        $('#toolbar').addClass("toolbar-hidden"); }

    // });
}

Module.toolbar_rotate = function () {
	console.log('rotate')
	if( $('#toolbar-switch').hasClass("active")) {
     $('#toolbar-switch').rotate({ animateTo:-25, duration: 500})
     $('#toolbar-switch').removeClass("active");

 } else {
     $('#toolbar-switch').rotate({ animateTo:0, duration: 500})
     $('#toolbar-switch').addClass("active"); }
}