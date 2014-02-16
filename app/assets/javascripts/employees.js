// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  $("input[type=text], textarea").bind("focus", function(){
    $(this).css("border-color", "").css("background-color", "")
  });

  $("input[type=submit]").bind("click", function(){
    var valid_form = true;

    $.each($("input[type=text], textarea"), function(i, e){
      if($(e).val() == "") {
        $(e).css("border-color", "#B94A48").css("background-color", "#F2DEDE");
        valid_form = false;
      }  
    });

    if(!valid_form) {
      $(".errorMessage").show();
    }
    

    return valid_form;
  });
});