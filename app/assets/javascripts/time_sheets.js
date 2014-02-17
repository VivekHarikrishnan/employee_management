// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
	$("form#new_time_sheet").bind("ajax:before", function(){
		$(".submitAction").find("img").show();
	}).bind("ajax:complete", function(){
		$(".submitAction").find("img").hide();
	});
});

function showOverLay() {
	$(".timeSheetOverlay").show();
}

function hideOverLay() {
	$(".timeSheetOverlay").hide();
}

function setSelectedTab(elem) {
	$(elem).siblings("a").removeClass("selectedTab");
	$(elem).siblings("a").addClass("unSelectedTab");
	$(elem).addClass("selectedTab");
}

function bindSheetActions() {
	$(".timeSheetActionIcon").unbind("click");
	$(".timeSheetActionIcon").bind("click", function(){
		var action_url = $(this).attr("action-to");
		var action_type = $(this).attr("action-type");
		var data = "";		
		var trigger_ajax = true; // By default trigger ajax action
		var overlay = $(this).parents("td").find(".overlayAction");
		var element = $(this);
		if(action_type === "PUT") {
			data = $(this).parents("tr").find("td.tFromTo").find("select").serialize();
		}
		else if(action_type == "DELETE") {
			if(confirm("Are you sure?")) {
				trigger_ajax = true;
			} else {
				trigger_ajax = false;
			}
		}

		if(trigger_ajax) {
			$.ajax({
				type: action_type,
				url: action_url,
				data: data,
				beforeSend: function() {
					element.hide();
					overlay.css("display", "inline-block");
				},
				complete: function() {					
					overlay.hide();					
				}
			});
		}
	});
}