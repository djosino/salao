$('input[type="checkbox"].checkbox').checkbox({});
//$('input.datepicker').datepicker();
$('.tooltip').tooltip();
$('.tooltip').removeClass('tooltip');
$('span.zoom').zoom({ on:'click', magnify: 0.4 });

$('.data').mask('99/99/9999');
$('#initial_date').mask('99/99/9999');
$('#final_date').mask('99/99/9999');

jQuery(".datepicker-days .table-condensed tbody").bind("click", function() { 
  jQuery(".datepicker.dropdown-menu").fadeOut('fast'); 
});

jQuery("input.with_loading").bind("click", function() { 
  $("#loading").show();
});

$('#datetimepicker').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy hh:mm:ss'
});

$('#datetimepicker2').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy hh:mm:ss'
});

$('#datetimepicker3').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy hh:mm:ss'
});

$('#datepicker').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy', 
  pickTime: false
});

$('#datepicker2').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy', 
  pickTime: false
});

$('#datepicker3').datetimepicker({
  language: 'pt-BR',
  format: 'dd/MM/yyyy', 
  pickTime: false
});

$('.loading').click(function(){
  $(".bg_loading").show();
  $("#loading").show();
})

/*$(document).ready(function() {
  $(".bclose").click(function() {
    $(".bg_loading").hide();
    $("#loading").hide();
  });

  $(".close").click(function() {
    $(".bg_loading").hide();
    $("#loading").hide();
  });
});
*/


/*
function create() {
  $('#loading_image').show();
  $.ajax({
    type: 'POST',
    url: 'www.google.com',
    data: $('form').serialize(),
    success: createSuccessHandler,
    error: createErrorHandler,
    complete: hideLoadingImage
  });
}

function createSuccessHandler(data) {
  alert("User created!")
}

function createErrorHandler(data) {
  alert("It failed, ffs!")
}

function hideLoadingImage() {
  $('#loading_image').hide()
}
*/
