jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

# PreLoad
$ ->
  $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable()

# PreLoad
$(document).ready ->
  jQuery(".nav-main .primary").children().bind "click", ->
    jQuery(".current").removeClass "current"
    $(this).addClass "current"

  # Create modal in button confirm
  $("a[data-confirm]").click (ev) ->
    href = $(this).attr("href")
    method = $(this).attr("data-method")
    $("body").append "<div id='dataConfirmModal' class='modal' role='dialog' aria-labelledby='dataConfirmLabel' aria-hidden='true'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button><h3 id='dataConfirmLabel'>Confirmação</h3></div><div class='modal-body'></div><div class='modal-footer'><button class='btn left' data-dismiss='modal' aria-hidden='true'>Cancelar</button><a class='btn btn-primary' id='dataConfirmOK'>Confirmar</a></div></div>"  unless $("#dataConfirmModal").length
    $("#dataConfirmModal").find(".modal-body").text $(this).attr("data-confirm")
    $("#dataConfirmOK").attr "href", href
    $("#dataConfirmOK").attr "data-method", method
    $("#dataConfirmModal").modal show: true
    false

  # Create modal in button confirm
  $("input[data-confirm]").click (ev) ->
    $(this).parents("form").append "<div id='dataConfirmModal' class='modal' role='dialog' aria-labelledby='dataConfirmLabel' aria-hidden='true'><div class='modal-header'><a type='button' class='close' data-dismiss='modal' aria-hidden='true' onclick='javascript:$(\"#dataConfirmModal\").fadeOut(\"slow\", function(){ $(\"#dataConfirmModal\").remove() });'>×</a><h3 id='dataConfirmLabel'>Confirmação</h3></div><div class='modal-body'></div><div class='modal-footer'><a class='btn left' data-dismiss='modal' aria-hidden='true' onclick='javascript:$(\"#dataConfirmModal\").fadeOut(\"slow\", function(){ $(\"#dataConfirmModal\").remove() });'>Cancelar</a><button class='btn btn-primary' id='dataConfirmOK' onclick='javascript:$(\"#dataConfirmModal\").fadeOut(\"slow\", function(){ $(\"#dataConfirmModal\").remove(); $(\"#loading\").show();})'>Confirmar</button></div></div>"  unless $("#dataConfirmModal").length
    $("#dataConfirmModal").find(".modal-body").text $(this).attr("data-confirm")
    false



# Close Modal with ESC button
$(document).keypress (e) ->
  if e.keyCode is 27
    $("#message_modal .close").click() 
    $("#dataConfirmModal").fadeOut "slow", ->
      $("#dataConfirmModal .close").click()

# JQuery Mask - Define variable 'A'
$.mask.definitions['A'] = "[A-Z]"
