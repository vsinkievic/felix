


$(document).ready(function(){

	$('.user-guide').hide();
	
	$('.elements').on('click', function(){
		$('.active').removeClass('active');
		$(this).addClass('active');
	});
	
    $('#btn1').on('click', function() {
        $('#inpType').val('1');
    });
    $('#btn2').on('click', function() {
        $('#inpType').val('2');
    });
    $('#btn3').on('click', function() {
        $('#inpType').val('3');
    });
    $('#btn4-1').on('click', function() {
    	$('#btn4').addClass('active');
    	$('#btn4').html('DB: access');
        $('#inpType').val('41');
    });
    $('#btn4-2').on('click', function() {
    	$('#btn4').addClass('active');
    	$('#btn4').html('DB: update');
        $('#inpType').val('42');
    });
    $('#btn5').on('click', function() {
        $('#inpType').val('5');
    });
    $('#btn6').on('click', function() {
    	$('.about').hide();
        $('.user-guide').show();
        $('.form-holder').empty();
    });
    $('#btn7-1').on('click', function() {
    	$('#btn7').addClass('active');
    	$('#btn7').html('Un: procedures');
        $('#inpType').val('71');
        $('#inpUnused').val('PROCEDURE');
        $(this).closest('form').submit();
    });
    $('#btn7-2').on('click', function() {
    	$('#btn7').addClass('active');
    	$('#btn7').html('Un: classes');
        $('#inpType').val('72');
        $('#inpUnused').val('CLASS');
        $(this).closest('form').submit();
    });
    $('#btn7-3').on('click', function() {
    	$('#btn7').addClass('active');
    	$('#btn7').html('Un: includes');
        $('#inpType').val('73');
        $('#inpUnused').val('INCLUDE');
        $(this).closest('form').submit();
    });
    $('#btn7-4').on('click', function() {
    	$('#btn7').addClass('active');
    	$('#btn7').html('Un: all');
        $('#inpType').val('74');
        $('#inpUnused').val('*');
        $(this).closest('form').submit();
    });
    $('.elements').on('click', function(){
    	$('#btn4').html('DB field');
    });
    $('.elements').on('click', function(){
    	$('#btn7').html('Unused');
    });
    


    $("#btnShort").click(function( event ) {
        let fValid = true;

        if ($('#inpName').val() == "") {
            $('#invFeedbackName').show();
            fValid = false;
        };
        if ($('#inpType').val() == "0") {
            $('#invFeedbackType').show();
            fValid = false;
        };
        if (fValid) {
            $('.invalid-feedback').hide();
            $('#inpDetails').val('no');
            $("#xrefForm").submit();
        } else {
        event.preventDefault();
        }
    });


    $("#btnDetailed").click(function( event ) {
        let fValid = true;

        if ($('#inpName').val() == "") {
            $('#invFeedbackName').show();
            fValid = false;
        };
        if ($('#inpType').val() == "0") {
            $('#invFeedbackType').show();
            fValid = false;
        };
        if (fValid) {
            $('.invalid-feedback').hide();
            $('#inpDetails').val('yes');
            $("#xrefForm").submit();
        };
    });

    $("#btnTreeShort").click(function( event ) {
        let fValid = true;
        if ($('#inpName').val() == "") {
            $('#invFeedbackName').show();
            fValid = false;
        };
        if (fValid) {
        	console.log('Tree button submitted');
            $('.invalid-feedback').hide();
            $('#inpTreeShort').val('yes');
            $("#xrefForm").submit();
        } else {
        event.preventDefault();
        }
    });
    
    $("#btnTreeDetailed").click(function( event ) {
        let fValid = true;
        if ($('#inpName').val() == "") {
            $('#invFeedbackName').show();
            fValid = false;
        };
        if (fValid) {
        	console.log('Tree button submitted');
            $('.invalid-feedback').hide();
            $('#inpTreeDetailed').val('yes');
            $("#xrefForm").submit();
        } else {
        event.preventDefault();
        }
    });
    
    
    $(".systems-select").click(function() {
        $(".systems-list").children().removeClass('systems-select-active');
        $(this).addClass("systems-select-active");
        let sysName = $(this).attr("value");
        $('#inpSystem').val(sysName);

    });

    
    $(".tree-bucket-entries").click(function() {
    	console.log("click");
    	let target = $(this).attr("value");
    	$("#cf" + target).submit();
    });
    
    
    
    
    /*--------- SCROLL BACK TO TOP ARROW:   ----------*/

    $(window).scroll(function() {
        if ($(this).scrollTop() >= 200) {
            $('#return-to-top').fadeIn(200);
        } else {
            $('#return-to-top').fadeOut(200);
        }
    });
    $('#return-to-top').click(function() {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
    });

    /*--------- HIGHLIGHT ACTIVE BUTTON:   ----------*/
    
    var header = document.getElementById("elements-holder");
    var btns = header.getElementsByClassName("elements");
    for (var i = 0; i < btns.length; i++) {
      btns[i].addEventListener("click", function() {
        var current = document.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        this.className += " active";
      });
    };

    
})

