$(document).ready(setupTables);

$(document).on('turbolinks:load', setupTables);

function setupTables() {
	setupSecondaryMailsTable();
	setupPreviousCompaniesTable();
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
        counter -= 1
    });
}

function setupPreviousCompaniesTable() {
	var counter = $('#table-previous-companies tbody tr').length - 1;
	$("#addrow-previous-company").unbind("click");
    $("#addrow-previous-company").click( function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="text" class="form-control" name="professional-previous-company' + counter + '"/></td>';


        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Excluir"></td>';
        newRow.append(cols);
        $("#table-previous-companies").append(newRow);
        counter++;
    });



    $("#table-previous-companies").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();
        counter -= 1
    });
}

