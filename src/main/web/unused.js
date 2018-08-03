function unusedAjax (searchType) {
	
$('.about').hide();
$('.user-guide').hide();
$('.form-holder').empty();
$('.form-holder').first().html('<div class="spinner-wrapper"><br><h3>Please wait</h3><br><img class="spinner" src="/felix/ajax-loader.gif" alt="Please wait"></div>');



let searchSys = $('#inpSystem').val();
console.log("before ajax");

    $.ajax({
        type: "POST",
        url: "unused.html",
        datatype: "application/json",
        data: {'systemName': searchSys},
        success: function(data){
        	console.log("ajax success");
            data = data.substring(0, data.indexOf('<') - 1);
            let results = $.parseJSON(data);
            let ttUnused = results.ttUnused;
            let resTable = $('<table></table>');
            let resTableHead = $('<thead><th class="t-linecounter">#</th><th>Type</th><th>Compile Unit</th><th>File Name</th></thead>');
            resTableHead.appendTo(resTable);
            
            for (var i = 0; i < ttUnused.length; i++) {
            	if (ttUnused[i].type == searchType || searchType == "ALL") {
                	let newRow = $('<tr>');
                	let newLineCount = $('<td>');
                	newLineCount.html((i + 1));
                	let newType = $('<td>');
                	newType.html(ttUnused[i].type);
                	let newCompileUnit = $('<td>');
                	newCompileUnit.html(ttUnused[i].compileUnit);
                	let newFileName = $('<td>');
                	newFileName.html(ttUnused[i].name);
                	newLineCount.appendTo(newRow);
                	newType.appendTo(newRow);
                	newCompileUnit.appendTo(newRow);
                	newFileName.appendTo(newRow);
                	newRow.appendTo(resTable);
                
            	};
            }
            $('.form-holder').empty();
            resTable.appendTo($('.form-holder').first());
            
        },
        error: function() {
            console.log("need fix");
        }
    });
};

$(document).ready(function() {

	$('#btn7-1').on('click', function() {
		$('#btn7').addClass('active');
		$('#btn7').html('Un: procedures');
		unusedAjax('PROCEDURE');
	});
	$('#btn7-2').on('click', function() {
		$('#btn7').addClass('active');
		$('#btn7').html('Un: classes');
	    unusedAjax('CLASS');
	});
	$('#btn7-3').on('click', function() {
		$('#btn7').addClass('active');
		$('#btn7').html('Un: includes');
	    unusedAjax('INCLUDE');
	});
	$('#btn7-4').on('click', function() {
		$('#btn7').addClass('active');
		$('#btn7').html('Un: all');
	    unusedAjax('ALL');
	});
});
