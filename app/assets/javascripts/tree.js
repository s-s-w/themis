function show_all() {
	$('.branch_body_text').show(1000);
	$('.branch_header').removeClass('shown').addClass('shown');
}

function hide_all() {
	$('.branch_body_text').hide(1000);
	$('.branch_header').removeClass('shown');
	//$('.response').css('display', 'visible');
}

function show_or_hide(selector) {
	if( $(selector).css('display') === 'none' ) {
			$(selector).show(400);
	} else
		{ $(selector).hide(400); }
}

function show_or_hide_body_text(selector) {
	var branch_body_text_id = selector.replace('#', '#branch_body_text_');
	var branch_header_id 		= selector.replace('#', '#branch_header_');
	
	show_or_hide(branch_body_text_id);
	$(branch_header_id).toggleClass('shown');
}
