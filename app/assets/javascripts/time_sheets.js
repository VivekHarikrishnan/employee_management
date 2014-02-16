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