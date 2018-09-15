
$(document).ready(mask_currency_inputs);

$(document).on('turbolinks:load', mask_currency_inputs);

function mask_currency_inputs() {
	$(".input-currency").maskMoney({prefix:'R$ ', allowNegative: false, thousands:'.', decimal:',', affixesStay: false});
}