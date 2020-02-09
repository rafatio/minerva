
$(document).ready(setup_profile_page);

$(document).on('turbolinks:load', setup_profile_page);


function setup_profile_page() {
	mask_inputs();
	setup_address();
	configure_brazil_address(false);
}


function mask_inputs() {
	$('.phone_with_ddd').mask('(00) 00000-0000');
	$('.cpf').mask('000.000.000-00', {reverse: true});
	$('.cep').mask('00.000-000', {reverse: true});

	var phone_options =  {
		onKeyPress: function(phone, e, field, options) {
		  var masks = ['+00 (00) 00000-0000', '+00 #'];
		  isBrazilianPhone = (phone.substr(0,3) === "+55");
		  var mask = isBrazilianPhone ? masks[0] : masks[1];
		  $('.phone_with_ddd_and_idd').mask(mask, options);
		  if (!isBrazilianPhone) {
			$('.phone_with_ddd_and_idd').attr('maxlength', "50");
		  }
	  }};

	current_val = $('.phone_with_ddd_and_idd').val();
	if (current_val !== undefined) {
		var masks = ['+00 (00) 00000-0000', '+00 #'];
		isBrazilianPhone = (current_val.substr(0,3) === "+55" || current_val.substr(0,2) === "55");
		var mask = isBrazilianPhone ? masks[0] : masks[1];
		$('.phone_with_ddd_and_idd').mask(mask, phone_options);
		if (!isBrazilianPhone) {
			$('.phone_with_ddd_and_idd').attr('maxlength', "50");
		}
	}
}

function setup_address() {
	$("select[name='address-country']").change(function() {
		configure_brazil_address(true);
	});
}

function configure_brazil_address(clear_zipcode) {
	isBrazil = ($("select[name='address-country']").val() === "Brasil");

	if (clear_zipcode) {
		$("input[name='address-cep']").val("");
		$("input[name='address-zipcode']").val("");
	}

	isPaymentsPage = document.location.pathname.indexOf("payments") > -1;
	required = isPaymentsPage || isBrazil;

	$("input[name='address-cep']").prop('required', isBrazil);
	$("input[name='address-zipcode']").prop('required', !isBrazil);
	$("input[name='address-neighborhood']").prop('required', required);
	$("input[name='address-city']").prop('required', required);
	$("input[name='address-state']").prop('required', required);

	$("input[name='address-cep']").prop('hidden', !isBrazil);
	$("label[for='address-cep']").prop('hidden', !isBrazil);

	$("input[name='address-zipcode']").prop('hidden', isBrazil);
	$("label[for='address-zipcode']").prop('hidden', isBrazil);

	if (isBrazil) {
		$("label[for='address-neighborhood']").addClass("font-weight-bold");
		$("label[for='address-city']").addClass("font-weight-bold");
		$("label[for='address-state']").addClass("font-weight-bold");

		if (!isPaymentsPage) {
			$("input[name='address-cep']").attr('oninvalid', "$('#collapseThree').collapse('show')");
			$("input[name='address-neighborhood']").attr('oninvalid', "$('#collapseThree').collapse('show')");
			$("input[name='address-city']").attr('oninvalid', "$('#collapseThree').collapse('show')");
			$("input[name='address-state']").attr('oninvalid', "$('#collapseThree').collapse('show')");
		}

	}
	else {
		$("label[for='address-neighborhood']").removeClass("font-weight-bold");
		$("label[for='address-city']").removeClass("font-weight-bold");
		$("label[for='address-state']").removeClass("font-weight-bold");

		if (!isPaymentsPage) {
			$("input[name='address-cep']").removeAttr('oninvalid');
			$("input[name='address-neighborhood']").removeAttr('oninvalid');
			$("input[name='address-city']").removeAttr('oninvalid');
			$("input[name='address-state']").removeAttr('oninvalid');
		}

	}
}
