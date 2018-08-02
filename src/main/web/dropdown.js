$(document).ready(function() {
	
	$('#autocomplete').hide();
	
    $('#inpName').keyup(function() {
    	$('#autocomplete').hide();
    	$('#autocomplete').empty();
        let searchVal = $(this).val();
        let searchType = $('#inpType').val() + "";
        let searchSys = $('#inpSystem').val();
        if (searchVal.length > 2 && searchType != "0") {
        	$('#autocomplete').show();
        	let iwid = $('#inpName').width();
            $.ajax({
                type: "POST",
                url: "field_search.html",
                datatype: "application/json",
                data: {'search': searchVal, 'type': searchType, 'systemName': searchSys},
                success: function(data){
                    data = data.substring(0, data.indexOf('<') - 1);
                    let results = $.parseJSON(data);
                    let filteredResults = [];
                    let ttDetails = results.ttDetails;
                    for (var i = 0; i < ttDetails.length; i++) {
                        let fResult = ttDetails[i].info;
                        if ($.inArray(fResult, filteredResults) == -1 ) {
                            filteredResults.push(fResult);
                            };
                    };
                    if (filteredResults.length > 0) {
                    	let listHead = $('<lh>Available items:</lh>');
                    	listHead.appendTo('#autocomplete');
                    	for (var i = 0; i < filteredResults.length; i++) {
                    		let listItem = $('<li class="autocomplete-list-items"></li>');
                    		listItem.attr('id', 'list' + i);
                    		listItem.html(filteredResults[i]);
                    		listItem.appendTo('#autocomplete');
                            listItem.click(function() {
                            	let cName = $(this).html();
                            	$('#inpName').val(cName);
                            	$('#autocomplete').empty();
                            });
                    	};
                    };
                    let listHeight = -50;
                    if (filteredResults.length < 20) {
                    	listHeight = -1 * filteredResults.length * 10 - 5;
                    };
                	$('#autocomplete').css('transform', 'translate(100px, ' + listHeight + 'px)');
                    if (filteredResults.length > 10) {
                    	$('#autocomplete').css('overflow-y', 'scroll');
                    } else {
                    	$('#autocomplete').css('overflow-y', 'hidden');
                    };
                },
                error: function() {
                    console.log("need fix");
                }
                
            });
        };
    });
});
