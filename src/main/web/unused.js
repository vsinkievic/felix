$(document).ready(function() {
	
	
    $('#btn7-1').on('click', function() {
    	$('#btn7').addClass('active');
    	$('#btn7').html('Un: procedures');
        $('#inpType').val('71');
    	$('.about').hide();
    	$('.form-holder').html("Report is being generated... 0 s");
    	var i = 0;
    	var int = setInterval(function() {
    		i = i + 1;
        	$('.form-holder').html("Report is being generated... " + i + " s");
    	}, 1000);
    	console.log('Reports holder added');
        
        let searchSys = $('#inpSystem').val();
        
            $.ajax({
                type: "POST",
                url: "unused.html",
                datatype: "application/json",
                data: {'systemName': searchSys},
                success: function(data){
                	console.log(data);
                    data = data.substring(0, data.indexOf('<') - 1);
                    let results = $.parseJSON(data);
                    let ttUnused = results.ttUnused;
                    console.log(ttUnused);
                    let resTable = $('<table></table>');
                    let resTableHead = $('<thead><th>Compile Unit</th><th>File Name</th></thead>');
                    resTableHead.appendTo(resTable);
                    
                    for (var i = 0; i < ttUnused.length; i++) {
                    	if (ttUnused[i].type == "PROCEDURE") {
	                    	let newRow = $('<tr>');
	                    	let newCompileUnit = $('<td>');
	                    	newCompileUnit.html(ttUnused[i].compileUnit);
	                    	let newFileName = $('<td>');
	                    	newFileName.html(ttUnused[i].name);
	                    	newCompileUnit.appendTo(newRow);
	                    	newFileName.appendTo(newRow);
	                    	newRow.appendTo(resTable);
                    	};
                    }
                    clearInterval(int);
                    $('.form-holder').empty();
                    resTable.appendTo($('.form-holder'));
                    
                },
                error: function() {
                    console.log("need fix");
                }
                
            });
        });

});
