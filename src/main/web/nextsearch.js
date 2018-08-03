var timeout;

function ajaxOnMouseOver() {
	
			clearTimeout(timeout);
        	
            let searchVal = $(this).attr("value");
            let searchSys = $('#inpSystem').val();
            let id = parseInt($(this).closest('form').attr('id'));

            
            timeout = setTimeout(function(){
    			$(".mouse-over-list").empty();

                $.ajax({
                    type: "POST",
                    url: "next_search.html",
                    datatype: "application/json",
                    data: {'name': searchVal, 'systemName': searchSys},
                    success: function(data){
                        data = data.substring(0, data.indexOf('<') - 1);
                        let results = $.parseJSON(data);
                        let filteredResults = [];
                        let ttElements = results.ttElements;
                        for (var i = 0; i < ttElements.length; i++) {
                            let fResult = ttElements[i];
                            if ($.inArray(fResult, filteredResults) == -1 ) {
                                filteredResults.push(fResult);
                                };
                        };
                        if (filteredResults.length >= 0) {
                        	let wrapper = $('#cd' + id);
                        	wrapper.mouseenter(function(){
                        		wrapper.removeClass('mouse-over-list');
                        		wrapper.addClass('mouse-over-list-active');
                        		clearTimeout(timeout);
                        	});
                        	wrapper.mouseleave(function(){
                        		wrapper.removeClass('mouse-over-list-active');
                        		wrapper.addClass('mouse-over-list');
                        	});
                        	
                        	let listHead = $('<lh>' + searchVal + ' uses:</lh>');
                        	listHead.appendTo(wrapper);
                        	for (var i = 0; i < filteredResults.length; i++) {
                        		let listItem = $("<form id=" + (id + 1000 + i) + " action='front.html'></form>");
                        		let listItemCore = $("<span class='tree-bucket-entries' value='" + filteredResults[i].name + "'>" + 
                        				"<span>" + (i + 1) + ". </span><span class='tree-bucket-entries-type'>(" + 
                        				filteredResults[i].type + ") </span>" + filteredResults[i].name + "</span>" + 
                        				"<input type='hidden' name='treeShort' value='yes'>" + "<input id='ce" + (id + 1000 + i) + 
                        				"' type='hidden' name='name' value=" + filteredResults[i].name + 
                        				"><input type='hidden' name='system' value=" + searchSys + ">");
                        		listItemCore.appendTo(listItem);
                        		listItem.appendTo(wrapper);
                                let nextList = $('<div class="mouse-over-list" id="cd' + + (id + 1000 + i) + '"></div>');
                                nextList.appendTo(wrapper);

                                listItemCore.mouseenter(ajaxOnMouseOver);
                                listItemCore.mouseleave(function(){
	                                clearInterval(timeout);
	                                listItemCore.click(function() {
	                                  	$(this).closest('form').submit();
	                                });
                                });
                        	};
                    		$('#cd' + id).css('transform', 'translate(110px, -20px)');
                    		$('#cd' + id).show();
                        };
                    },
                    error: function() {
                        console.log("need fix");
                    }
                });  
            }, 700);
}




$(document).ready(function() {

	$('.tree-bucket-entries').mouseenter(ajaxOnMouseOver);
	$('.tree-bucket-entries').mouseleave(function(){
		clearInterval(timeout);
	});
	
});



