$(document).ready(function() {
    $('#inpName').keyup(function() {
        let datalist = $('#json-datalist');
        datalist.empty();
        let searchVal = $(this).val();
        let searchType = $('#inpType').val() + "";
        console.log(searchVal + " of type: " + searchType);
        if (searchVal.length > 2 && searchType != "0") {
            $.ajax({
                type: "POST",
                url: "field_search.html",
                datatype: "application/json",
                data: {'search': searchVal, 'type': searchType},
                success: function(data){
                    data = data.substring(0, data.indexOf('<') - 1);
                    let results = $.parseJSON(data);
                    let filteredResults = [];
                    let ttOut = results.ttOut;
                    for (var i = 0; i < ttOut.length; i++) {
                        let fResult = ttOut[i].fResult;
                        if ($.inArray(fResult, filteredResults) == -1 ) {
                            filteredResults.push(fResult);
                            };
                    };
                    if (filteredResults.length > 1) {
                    	for (var i = 0; i < filteredResults.length; i++) {
                    		let option = $('<option class="dropdown-option"></option>');
                    		option.val(filteredResults[i]);
                    		datalist.append(option);                    
                    };
                    };
                },
                error: function() {
                    console.log("need fix");
                }
            });
        };
    });
});
