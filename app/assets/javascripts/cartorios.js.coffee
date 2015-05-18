//= require bootstraps/bootstrap.controllers.js
jQuery("#cartorio_cep").mask "99999-999"
jQuery("#cartorio_telefone").mask "(99) 9999-9999"

$("#cartorio_forma_pagamento").change ->
  if $(this).val() is "PRAZO"
    $("#parcelado").show()
    $("#parcelado1").show()
  else
    $("#parcelado").hide()
    $("#parcelado1").hide()
  return
