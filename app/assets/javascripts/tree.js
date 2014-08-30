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
		$(selector).show(500);
	} else {
		$(selector).hide(500);
	}
}

function show_or_hide_body_text(selector) {
	var branch_body_text_id = selector.replace('#', '#branch_body_text_');
	var branch_header_id 		= selector.replace('#', '#branch_header_');
	
	show_or_hide(branch_body_text_id);
	$(branch_header_id).toggleClass('shown');
}

function expand_or_collapse_children(num) {
	var parent = $('#' + num);
	var list_of_children = $('#ul_' + num);
	
	if( list_of_children.css('display') === 'none' ) {
		list_of_children.show(500);
	} else {
		parent.find('ul').hide(500);
	}
}

function expand_or_collapse_descendants(num) {
	var parent = $('#' + num);
	var list_of_children = $('#ul_' + num);
	
	if( list_of_children.css('display') === 'none' ) {
		parent.find('ul').show(500);
	} else {
		parent.find('ul').hide(500);
	}
}
