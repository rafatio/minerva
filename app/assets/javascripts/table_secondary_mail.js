$(document).ready(setupTables);

$(document).on('turbolinks:load', setupTables);

function setupTables() {
	setupSecondaryMailsTable();
	setupPreviousCompaniesTable();
	setupEducationInformation();
}

function setupSecondaryMailsTable() {
	var counter = $('#table-secondary-mail tbody tr').length - 1;
	$("#addrow-secondary-mail").unbind("click");
    $("#addrow-secondary-mail").click( function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="text" class="form-control" name="contact-secondary-mail' + counter + '"/></td>';


        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Excluir"></td>';
        newRow.append(cols);
        $("#table-secondary-mail").append(newRow);
        counter++;
    });



    $("#table-secondary-mail").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
    });
}

function setupPreviousCompaniesTable() {
	var counter = $('#table-previous-companies tbody tr').length - 1;
	$("#addrow-previous-company").unbind("click");
    $("#addrow-previous-company").click( function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="text" class="form-control" name="professional-previous-company-name' + counter + '"/></td>';
        cols += '<td><input type="text" class="form-control" name="professional-previous-company-position' + counter + '"/></td>';


        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Excluir"></td>';
        newRow.append(cols);
        $("#table-previous-companies").append(newRow);
        counter++;
    });



    $("#table-previous-companies").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
    });
}

function setupEducationInformation() {
	var counter = $('#div-education-information .education-information-row').length;
	$("#addrow-education-information").unbind("click");
    $("#addrow-education-information").click( function () {
        var newRow = $("<div class='row mb-3 education-information-row'>");
        var cols = "";

		var educationLevels = $.map($('#list-education-levels option'), function(e) { if (e.value !== "") return e.value; });
		
        //cols += '<div class="col-2"><input type="text" class="form-control" name="education-level' + counter + '" required/></div>';
		cols += '<div class="col-2"><select name="education-level' + counter + '" class="form-control selectpicker" required><option hidden disabled selected value></option>';
		for (var i=0; i<educationLevels.length; i++) {
			cols += '<option value="' + educationLevels[i] + '">' + educationLevels[i] + '</option>'
		}
		cols += '</select></div>'
		
		cols += '<div class="col-3"><input type="text" class="form-control" name="education-institution' + counter + '" required/></div>';
		cols += '<div class="col-3"><input type="text" class="form-control" name="education-course' + counter + '" required/></div>';
		cols += '<div class="col-2"><input type="number" pattern="\\d+" class="form-control" name="education-conclusion-year' + counter + '"/></div>';
		

        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Excluir"></td>';
        newRow.append(cols);
        $("#div-education-information").append(newRow);
        counter++;
    });



    $("#div-education-information").on("click", ".ibtnDel", function (event) {
        $(this).closest("div .education-information-row").remove();
    });
}
