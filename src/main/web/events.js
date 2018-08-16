$(document).ready(function(){
	$('.user-guide').hide();

	$('#testai').on('click', function() {
    	$('#myModal').modal('show');
    });
	$('#btn1').on('click', function() {
    	$('#btn1').addClass('active');
        $('#inpFiles').val('yes');
        $('#btn21').show();
        $('#btn22').hide();
    	$('#btn23').hide();
    });
    $('#btn2').on('click', function() {
    	$('#btn2').addClass('active');
        $('#inpDBstruct').val('yes');
        $('#btn22').show();
        $('#btn21').hide();
    	$('#btn23').hide();
    });
    $('#btn3').on('click', function() {
    	$('#btn3').addClass('active');
        $('#inpUnused').val('yes');
        $('#btn23').show();
        $('#btn22').hide();
    	$('#btn21').hide();
    });
	$('.elements').on('click', function(){
		$('.active').removeClass('active');
		$(this).addClass('active');
	});
    $('#btn1-1').on('click', function() {
    	$('#btn1').addClass('active');
    	$('#btn21').addClass('active');
    	$('#btn21').html('Procedure');
        $('#inpType').val('11');
    });
    $('#btn1-2').on('click', function() {
    	$('#btn1').addClass('active');
    	$('#btn21').addClass('active');
    	$('#btn21').html('Class');
        $('#inpType').val('12');
    });
    $('#btn1-3').on('click', function() {
    	$('#btn1').addClass('active');
    	$('#btn21').addClass('active');
    	$('#btn21').html('Include');
        $('#inpType').val('13');
    });
    $('#btn1-4').on('click', function() {
    	$('#btn1').addClass('active');
    	$('#btn21').addClass('active');
    	$('#btn21').html('All');
        $('#inpType').val('14');
    });  
    $('#btn2-1').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: access');
        $('#inpType').val('21');
    });
    $('#btn2-2').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: update');
        $('#inpType').val('22');
    });
    $('#btn2-3').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: delete');
        $('#inpType').val('23');
    });
    $('#btn2-4').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: reference');
        $('#inpType').val('24');
    });
    $('#btn2-5').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: index');
        $('#inpType').val('25');
    });
    $('#btn2-6').on('click', function() {
    	$('#btn2').addClass('active');
    	$('#btn22').addClass('active');
    	$('#btn22').html('DB: all');
        $('#inpType').val('26');
    });
    $('#btn3-1').on('click', function() {
    	$('#btn3').addClass('active');
    	$('#btn23').addClass('active');
    	$('#btn23').html('Un: procedures');
        $('#inpType').val('31');
        $('#inpUnused').empty();
        $('#inpUnused').val('PROCEDURE');
        $(this).closest('form').submit();
    });
    $('#btn3-2').on('click', function() {
    	$('#btn3').addClass('active');
    	$('#btn23').addClass('active');
    	$('#btn23').html('Un: classes');
        $('#inpType').val('32');
        $('#inpUnused').empty();
        $('#inpUnused').val('CLASS');
        $(this).closest('form').submit();
    });
    $('#btn3-3').on('click', function() {
    	$('#btn3').addClass('active');
    	$('#btn23').addClass('active');
    	$('#btn23').html('Un: includes');
        $('#inpType').val('33');
        $('#inpUnused').empty();
        $('#inpUnused').val('INCLUDE');
        $(this).closest('form').submit();
    });
    $('#btn3-4').on('click', function() {
    	$('#btn3').addClass('active');
    	$('#btn23').addClass('active');
    	$('#btn23').html('Un: all');
        $('#inpType').val('34');
        $('#inpUnused').empty();
        $('#inpUnused').val('*');
        $(this).closest('form').submit();
    });
//    $('#btn3-1').on('click', function() {
//    	$('#btn3').addClass('active');
//    	$('#btn23').addClass('active');
//    	$('#btn23').html('Un:procedures');
//        $('#inpType').val('31');
//    });
//    $('#btn3-2').on('click', function() {
//    	$('#btn3').addClass('active');
//    	$('#btn23').addClass('active');
//    	$('#btn23').html('DB: update');
//        $('#inpType').val('32');
//    });
//    $('#btn3-3').on('click', function() {
//    	$('#btn3').addClass('active');
//    	$('#btn23').addClass('active');
//    	$('#btn23').html('DB: delete');
//        $('#inpType').val('33');
//    });
//    $('#btn3-4').on('click', function() {
//    	$('#btn3').addClass('active');
//    	$('#btn23').addClass('active');
//    	$('#btn23').html('DB: reference');
//        $('#inpType').val('34');
//    });
    $('#btn4').on('click', function() {
    	$('.about').hide();
        $('.user-guide').show();
        $('.form-holder').empty();
    });
    
    
    $('.elements').on('click', function(){
    	$('#btn2').html('DB structure');
    });
    $('.elements').on('click', function(){
    	$('#btn3').html('Unused');
    });
    $("#btnReport").click(function( event ) {
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

    $("#btnTree").click(function( event ) {
        let fValid = true;
        if ($('#inpName').val() == "") {
            $('#invFeedbackName').show();
            fValid = false;
        };
        if (fValid) {
        	console.log('Tree button submitted');
            $('.invalid-feedback').hide();
            $('#inpTree').val('yes');
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
    	$(this).closest('form').submit();
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