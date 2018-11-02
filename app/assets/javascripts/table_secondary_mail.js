$(document).on('turbolinks:load', setupSecondaryMailsTable);

function setupSecondaryMailsTable() {
	var counter = $('#table-secondary-mail tbody tr').length - 1;
	$("#addrow-secondary-mail").unbind("click");
    $("#addrow-secondary-mail").click( function () {
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="text" class="form-control" name="contact-secondary-mail' + counter + '"/></td>';


        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Excluir"></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);
        counter++;
    });



    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        counter -= 1
    });
}