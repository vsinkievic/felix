function unusedAjax (searchType) {
	
$('.about').hide();
$('.user-guide').hide();
$('.form-holder').empty();
var i = 0;
var int = setInterval(function() {
	i = i + 1;
	//$('.form-holder').first().html("Report is being generated... " + i + " s");
	$('.form-holder').first().html('<center><img valign = "middle" class="loader-img" src="/felix/ajax-loader.gif" alt=""></center>');
	console.log(i);
}, 1000);



let searchSys = $('#inpSystem').val();

    $.ajax({
        type: "POST",
        url: "unused.html",
        datatype: "application/json",
        data: {'systemName': searchSys},
        success: function(data){
            data = data.substring(0, data.indexOf('<') - 1);
            let results = $.parseJSON(data);
            let ttUnused = results.ttUnused;
            let resTable = $('<table></table>');
            let resTableHead = $('<thead><th class="t-linecounter"></th><th>Compile Unit</th><th>File Name</th></thead>');
            resTableHead.appendTo(resTable);
            
            for (var i = 0; i < ttUnused.length; i++) {
            	if (ttUnused[i].type == searchType || searchType == "ALL") {
                	let newRow = $('<tr>');
                	let newLineCount = $('<td>');
                	newLineCount.html((i + 1));
                	let newCompileUnit = $('<td>');
                	newCompileUnit.html(ttUnused[i].compileUnit);
                	let newFileName = $('<td>');
                	newFileName.html(ttUnused[i].name);
                	newLineCount.appendTo(newRow);
                	newCompileUnit.appendTo(newRow);
                	newFileName.appendTo(newRow);
                	newRow.appendTo(resTable);
            	};
            }
            clearInterval(int);
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
