
$(document).ready(mask_inputs);

$(document).on('turbolinks:load', mask_inputs);

function mask_inputs() {
	$('.phone_with_ddd').mask('(00) 00000-0000');
	$('.cpf').mask('000.000.000-00', {reverse: true});
}