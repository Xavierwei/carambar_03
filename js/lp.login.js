/*
 * page base action
 */
LP.use(['jquery' , 'api'] , function( $ , api ){
    'use strict'




    //for comment action
    LP.action('login' , function( data ){
        var name = $('#name').val();
        var password = $('#password').val();
        api.ajax('login', {company_email:name, password: password}, function(data){
            if(data.success) {
                window.location.href = "index.html";
            }
        });
    });

    $(document).keydown(function( ev ){
        switch( ev.which ){
            case 13: // enter
                LP.triggerAction('login');
                break;
        }
    });

    $(document).ready(function(){
alert(1);
        alert($('#player'));
        $('#player').prepend('body');
    });


});