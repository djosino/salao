$('header').remove('#asn-warning');
$('header').prepend("<div id=\"asn-warning\" ><a href=\"http://browsehappy.com//\" style=\"color: #4F4D3B; text-decoration: none; font: normal 9pt/14px 'Trebuchet MS', Arial, Helvetica; padding-right: 30px; display: block;\" target=\"_blank\"><span id=\"asn-outofdate\" style=\"display: block;  color: #fff; float: left; padding: 10px 18px 10px 8px; background: #bd695b url('http://www.updateyourbrowser.net/_static/imagens/arrow.gif') no-repeat right -2px; \">Navegador desatualizado! </span><span style=\"display: block; padding: 10px 10px; float: left;\">Você está usando uma versão antiga do <strong>"+BrowserDetect.browser+"</strong>. Para uma melhor experiência, por favor <span style=\"text-decoration: underline;\">atualize seu navegador</span>.</span></a> <a href=\"javascript://\" id=\"asn-close\" style=\"position: relative; text-decoration: none; float: right; width: 14px; border: none; padding: 3px; top: 8px; right: 14px; color: #4F4D3B; height: 14px; font: normal 8pt/14px 'Trebuchet MS', Arial, Helvetica; background-image: url('http://www.updateyourbrowser.net/_static/imagens/close_03.gif');\"></a></div>");
$('#asn-warning').fadeIn(1000);
$('#asn-close').click(function(){$('#asn-warning').hide('fast');});
$('#asn-warning a').mouseover(function(){ $(this).css('color','#8F8D7B'); });
$('#asn-warning a').mouseout(function(){  $(this).css('color','#4F4D3B'); });