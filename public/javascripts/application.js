// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var Application={
	config: {
		'icon_root': "http://www.vajrachakra.com/common/assets/images/icons/fugue"
	}
}
$(function() {

	//Add icons to each link with attribute icon specified 
	$('a[icon]').each(function() {
		var icon_filename=$(this).attr('icon')+".png";	
		$(this).before($("<img>",{
			'src': Application.config.icon_root+"/"+icon_filename,
			'class':'link-icon'
		}));
	});

	//Initialize datepickers on applicable fields
	$('input.date').datepicker();
});
