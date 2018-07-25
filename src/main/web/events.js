$(document).ready(function(){

	
	$('.user-guide').hide();
	
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
    $('.elements').on('click', function(){
    	$('#btn4').html('DB field');
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


    $(".systems-select").click(function() {
        $(".systems-list").children().removeClass('systems-select-active');
        $(this).addClass("systems-select-active");
        let sysName = $(this).attr("value");
        $('#inpSystem').val(sysName);

    });

    // scroll back to top arrow

    $(window).scroll(function() {
        if ($(this).scrollTop() >= 200) {
            $('#return-to-top').fadeIn(200);
        } else {
            $('#return-to-top').fadeOut(200);
        }
    });
    $('#return-to-top').click(function() {
        $('body,html').animate({
            scrollTop : 0
        }, 500);
    });

    // Add active class to the current button (highlight it)
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

