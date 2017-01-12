// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){
	$('.toggle_published a').on('click', function(){


			var button = $(this).find('.publish-switch');

			console.log($(this).attr('link_publish'));

			if(button.hasClass('active')){
				button.removeClass('active');

				
				console.log($(this));

				$(this).attr('href', $(this).attr('link_unpublish'));
			}
			else{
				button.addClass('active');


				$(this).attr('href', $(this).attr('link_publish'));
			}
		});
})
