//Функция показа пароля
$(function(){
    $(".showpassword").each(function(index,input) {
        var $input = $(input);
        $('<label class="showpasswordlabel"/>').append(
            $(" <input type='checkbox' id='show_pass_input' class='showpasswordcheckbox reg_freeze'>").click(function() {
                var change = $(this).is(":checked") ? "text" : "password";
                var rep = $("<input type='" + change + "' />")
                    .attr("id", $input.attr("id"))
                    .attr("name", $input.attr("name"))
                    .attr('class', $input.attr('class'))
                    .attr('placeholder', $input.attr('Пароль'))
                    .val($input.val())
                    .insertBefore($input);
                $input.remove();
                $input = rep;
                $input.attr('placeholder','Пароль');
             })
        ).append($("<span class='login_input_check_pass' />").html("<p>Показать пароль</p>")).insertAfter($input);
    });
});


$(document).ready(function($) {

    f_t_box_content = $("#field_templates_box").html();
    $("#field_templates_box").html('');
    $('#service_tariff_id').attr('disabled','disabled').trigger('refresh');
    $('#service_vendor_id').attr('disabled','disabled').trigger('refresh');
    $('.jq-selectbox__dropdown > ul>li:first-child').hide();


//      синий квадрат в чекбоксе off/on

    $('.login_input_check').click(function(){
        if ($('#some_input').is(':checked')){
            $('.login_input_check').css('background-image','url(/images/checkbox_off.png)')
        }
        else {
            $('.login_input_check').css('background-image','url(/images/checkbox_on.png)')
        }
    })

    $('.login_input_check_pass').click(function(){
        if ($('#show_pass_input').is(':checked')){
            $('.login_input_check_pass').css('background-image','url(/images/checkbox_off.png)')
        }
        else {
            $('.login_input_check_pass').css('background-image','url(/images/checkbox_on.png)')
        }
    })

//      проверки инпутов

    $('.login_input_check_oferta').click(function(){
        if ($('#some_input_oferta').is(':checked')){
            $('.login_input_check_oferta').css('background-image','url(/images/checkbox_off.png)')
            $('.oferta_link_disable').css('display','block');
            $('.submit_button_oferta').css('background-color','#8da9bc');
            $('.submit_button_oferta').css('color','#6a7f8d');
            $('.submit_button_oferta').css('text-shadow','1px 1px 0px #FFF');
        }
        else {
            $('.login_input_check_oferta').css('background-image','url(/images/checkbox_on.png)');
            $('.oferta_link_disable').css('display','none');
            $('.submit_button_oferta').css('background-color','#0071bc');
            $('.submit_button_oferta').css('color','#FFF');
            $('.submit_button_oferta').css('text-shadow','none');
        }
    })


    $('#reg_oferta_second_check').click(function(){
        if ($('.accept_oferta').find('#some_input').is(':checked')){
            $('.reg_oferta_second_check').css('background-image','url(/images/checkbox_off.png)')
            $('.reg_disable').css('display','block');
            $('.accept_data_button').css('background-color','#8da9bc');
            $('.accept_data_button').css('color','#6a7f8d');
            $('.accept_data_button').css('text-shadow','1px 1px 0px #FFF');
            $('.accept_data_button').attr('disabled','disabled');
        }
        else {
            $('.reg_oferta_second_check').css('background-image','url(/images/checkbox_on.png)');
            $('.reg_disable').css('display','none');
            $('.accept_data_button').css('background-color','#0071bc');
            $('.accept_data_button').css('color','#FFF');
            $('.accept_data_button').css('text-shadow','none');
            $('.accept_data_button').removeAttr('disabled');
        }
    });

//      всплытие дивов регистрации

    $('.accept_data_button').click(function(){
        $('#div_place').fadeIn('slow');
        //var HeightScreen = $(window).height();
        //$(HeightScreen).scrollBottom('slow')
    })

//  наполнение карточки объекта
    $('#accept_place_button').click(function(){
        var name = $('#reg_place_name').attr('value')
        var city = $('#reg_place_city').attr('value')
        var street = $('#reg_place_street').attr('value')
        var building = $('#reg_place_building').attr('value')
        var apartment = $('#reg_place_apartment').attr('value')
        $('.object_name').find('input').attr('value', name).show('slow');
        $('.object_adress').find('p').show('slow');
        $('.object_adress').find('.adress_blue').attr('value', city + ', ' + street + ', ' + building + ', ' + apartment).show('slow');
        $('#place_box').fadeOut('slow',function(){
            $('#service_box').fadeIn('fast');
        });
    })
         

//  меню

    $('.menulistLiDrop').mouseenter(function(){
        $( this ).find('.dropdownMenu').slideDown('fast').show();
        $('.menulistLiDrop').hover(function() {
        }, function(){ 
        $( this ).find(".dropdownMenu").slideUp('fast'); 
        });
    })


$(".pay_text a:first-child").addClass("object_selected"); //выделение первого элемента списка объектов/"счетов"
$(this).remove();

//     всплытие окон в профиле

    $('#profile_edit_button').click(function(){
        var ValueCheck = $('#profile_edit_button').attr('value')
        if (ValueCheck == 'Редактировать'){
            $('#profile_container').fadeOut('fast',function(){
                $('#profile_edit_container').fadeIn('slow')
                $('#profile_edit_button').attr('value','Сохранить')
                $('#profile_edit_button').prop('type','submit')
            })
        }
        else {
            $('#profile_edit_container').fadeOut('fast',function(){
                $('#profile_container').fadeIn('slow')
                $('#profile_edit_button').attr('value','Редактировать')
                $('#profile_edit_button').prop('type','button')
            })
        }
        
    })


    placeEdit = function(){
        var ValueCheck = $('#place_edit_button').attr('value')
        if (ValueCheck == 'Редактировать'){
            $('#place_info_container').fadeOut('fast',function(){
                $('#place_edit_container').fadeIn('slow');
                $('#place_edit_button').val('Сохранить');
                $('#place_edit_button').prop('type','submit');
            })
        }
        else {
            // $('#place_edit_container').fadeOut('fast',function(){
            //     $('#place_info_container').fadeIn('slow');
            //     $('#place_edit_button').val('Редактировать');
            //     $('#place_edit_button').prop('type','button');
            // })
    console.log("Place has been edited");
        }
        
    }


     $('span#recipe_is_paid_span').click(function(){

        $('div.cards_list').hide();
        
        if ($("input.recipe_check").attr("checked") != "checked")
        {
            $("div.end .end_button").hide(); 
            $("#save_amount_form").fadeIn(); 
            $("#save_amount_form input.end_button").fadeIn(); 
        }
        else
        {
            $("#save_amount_form").hide();
            $("div.end .end_button").fadeIn(); 
            $("#save_amount_form input.end_button").hide(); 
            

        }
        

    })



//  при наведении на объекты при платеже

            $('.object').mouseenter(function(){
               // $(this).css('background-color','#e8eef2');
                    $('.object').click(function(){
                    $('.pay_text').find('.object_selected').attr('class','object')
                    $(this).addClass('object_selected');
                })


                var TrueClass = $(this).attr('class')
                $(this).mouseleave(function(){
                 //   $('.object').css('background-color','#d5e6f2');
                    
                })
            })

});

//  при наведении на объекты при платеже
function servicePayClick(thisElem)
{
    $('.service_pay_block').find('.service_pay_selected').attr('class','service_pay')
    $(thisElem).attr('class','service_pay_selected');
}

// рендер плашек
function popUpRender(message)
{
    var scrolled = window.pageYOffset || document.documentElement.scrollTop;

    var scrollBottomValue = document.documentElement.scrollHeight - document.documentElement.clientHeight - scrolled;
    //alert(scrollBottomValue);
    if (scrollBottomValue >97){
        scrollBottomValue=97;
    }

    scrollBottomValue = 115 - scrollBottomValue;
    $('.for_pop_up').css('bottom',scrollBottomValue+'px');
    $('.for_pop_up').prepend('<div onclick="this.remove();" class="pop_up_div">' + '<h3>Информация</h3><p>' +  message + '</p></div>'); 
    $('.pop_up_div').fadeIn(1000);

    setTimeout('$(".for_pop_up").html("")', 10000);
    //var intervalID = setInterval(function() { $(".for_pop_up div:last-child").remove(); }, 3000);
    //setInterval(function() { if ($(".for_pop_up").html()==' ') {clearInterval(intervalID);} }, 1000);
    // $(".for_pop_up div:last-child").delay(2000).fadeOut(1000);
}

//Отслеживание скроллинга для отображения всплывающих сообщений

window.onscroll = function() { 

  var scrolled = window.pageYOffset || document.documentElement.scrollTop;

  var scrollBottomValue = document.documentElement.scrollHeight - document.documentElement.clientHeight - scrolled;
    if (scrollBottomValue >97){
        scrollBottomValue=97;
    }
    
  scrollBottomValue = 115 - scrollBottomValue;
   $('.for_pop_up').css('bottom',scrollBottomValue+'px');

}


// Функция сортировки услуг.

function sortFun(thisEl){

    listType=thisEl.getAttribute("listtype");

     switch (listType)
     {
        case 'serviceType':
        var serviceTypeId=thisEl.getAttribute("id");
        $('#service_vendor_id').attr('disabled','disabled').trigger('refresh');
        $('#service_vendor_id').val('0').trigger('refresh');
        $('#service_tariff_id').attr('disabled','disabled').trigger('refresh');
        $('#service_tariff_id').val('0').trigger('refresh');
        $("div#user_account_box").slideUp();
        $('#accept_service_submit').attr("disabled","disabled");
        $("#field_templates_box").html('');
        $('.dog_number').attr("disabled","disabled");
        $('.dog_number').val("");   
        $('#service_vendor_id-styler .jq-selectbox__select-text').html('<img src="/images/progressbar.gif" alt="progressbar">');
        $.ajax({
                    type: "POST",
                    url: "/get_vendors",
                    data: { service_type_id: serviceTypeId },
                    success: function(result){ 
                        $("[listtype=userTariff]").val('');
                        $('#service_vendor_id').removeAttr('disabled').trigger('refresh');
                        $('#service_vendor_id').val('0').trigger('refresh');
                        $("[servicetypeid="+serviceTypeId+"]").show();
                        $("[listtype=userTariff]").attr('servicetypeid',serviceTypeId);
                        $("[listtype=userTariff]").val('0');
                    }
        });

        // $("[listtype=userTariff]").val('');
        // $('#service_vendor_id').removeAttr('disabled').trigger('refresh');
        // $('#service_vendor_id').val('0').trigger('refresh');
        // $('#service_tariff_id').attr('disabled','disabled').trigger('refresh');
        // $('#service_tariff_id').val('0').trigger('refresh');
        // $("[listtype=vendor]").hide();
        // $("[servicetypeid="+serviceTypeId+"]").show();
        // $("#field_templates_box").html('');
        // $("[listtype=userTariff]").attr('servicetypeid',serviceTypeId);
        // $("[listtype=userTariff]").val('0');
        // $("div#user_account_box").slideUp();
        // $('.dog_number').attr("disabled","disabled");
        // $('.dog_number').val("");
        // $('#accept_service_submit').attr("disabled","disabled");
        // $('li.optgroup').hide();


        // $('li.optgroup').each(function(){ 
        //     if (serviceTypeId == 1 || serviceTypeId == 3 ) { $( this ).hide(); }
        //     if (serviceTypeId == 5 || serviceTypeId == 4 ) { 
        //         if ($( this ).text() == "Тольятти") { 
        //             $( this).hide(); 
        //         } 
        //      }
        //     });


        break

        case 'userTariff':
        var userTariffId=thisEl.getAttribute("servicetypeid");
        $('#service_tariff_id').removeAttr('disabled').trigger('refresh');
        $('#service_tariff_id').val('0').trigger('refresh');
        $("[listtype=tariff]").hide();
        $("li[listType='tariff'][vendorid=0]").show();
        $("li[listType='tariff'][servicetypeid!=" + userTariffId + "]").hide();
        $("div#user_account_box").slideUp();
        $("#field_templates_box").html('');
        $('.dog_number').attr("disabled","disabled");
        $('.dog_number').val("");
        $('#accept_service_submit').attr("disabled","disabled");
        break

        case 'vendor':
        $('#service_tariff_id').removeAttr('disabled').trigger('refresh');
        $('#service_tariff_id').val('0').trigger('refresh');
        var vendorId=thisEl.getAttribute("id");
        $("[listtype=tariff]").hide();
        $("[vendorid="+vendorId+"]").show();
        $("#field_templates_box").html('');
        $('.dog_number').attr("disabled","disabled");
        $('.dog_number').val("");
        $("div#user_account_box").slideDown();
        $('#accept_service_submit').attr("disabled","disabled");
        break

        case 'tariff':
        var hasReadings=thisEl.getAttribute("hasReadings");
        var tariffTemplateId = thisEl.getAttribute("id");
        $(".field_template_section").hide();
        $('.dog_number').removeAttr("disabled");
        $("#field_templates_box").html(f_t_box_content);
        $('#accept_service_submit').removeAttr("disabled");
        $('.field_template_section').each(
                function(){
                    if ($(this).attr('tarifftemplateid') != tariffTemplateId ) {$(this).remove();}
                }
            );

        if(thisEl.getAttribute('vendorid') == 0) 
        {
            $('.service_tariff_value').removeAttr('disabled');
        }

        $("[tarifftemplateid="+tariffTemplateId+"]").slideDown();
        break

        case 'catalog':
        var catalogId=thisEl.getAttribute("id");
        $('.catalog_category').hide();
        $("#freelance_category_"+catalogId).show();
        $("#non_utility_service_type_"+catalogId).show();
        break

        case 'showAllCategories':
        $('.catalog_category').show();
        break

        default:
        break
     }
}




