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

//      проверки импутов

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
        $('.menulistLiDrop').find('.dropdownMenu').slideDown('fast').show();
        $('.menulistLiDrop').hover(function() {
        }, function(){ 
        $('.menulistLiDrop').find(".dropdownMenu").slideUp('fast'); 
        });
    })


$(".pay_text a:first-child").attr("class","object_selected"); //выделение первого элемента списка объектов/"счетов"
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


//  при наведении на объекты при платеже

            $('.object').mouseenter(function(){
               // $(this).css('background-color','#e8eef2');
                    $('.object').click(function(){
                    $('.pay_text').find('.object_selected').attr('class','object')
                    $(this).attr('class','object_selected');
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
        // console.log('Услуга');
        $('#service_vendor_id').removeAttr('disabled').trigger('refresh');
        $('#service_vendor_id').val('0').trigger('refresh');
        $('#service_tariff_template_id').val('0').trigger('refresh');
        var serviceTypeId=thisEl.getAttribute("id");
        $("[listtype=vendor]").hide();
        $("[servicetypeid="+serviceTypeId+"]").show();
        $('#serviceFreeze').css('height','50%');
        $("div#service_vendor_id").css("background-color", "#e8eef2");
        $("div#service_vendor_id").css("color", "#00558d");        

        $("#field_templates_box").html('');
        break

        case 'userTariff':
        $('#serviceFreeze').css('height','33%');
        $("[vendorid="+0+"]").show();
        break

        case 'vendor':
        // console.log('Вендор');
        $('#service_tariff_id').removeAttr('disabled').trigger('refresh');
        $('#service_tariff_id').val('0').trigger('refresh');
        var vendorId=thisEl.getAttribute("id");
        $("[listtype=tariff]").hide();
        $("[vendorid="+vendorId+"]").show();
        $('#serviceFreeze').css('height','17%');
        $("div#service_tariff_template_id").css("background-color", "#e8eef2");
        $("div#service_tariff_template_id").css("color", "#00558d");

        $("#field_templates_box").html('');
        break

        case 'tariff':
        // console.log('Тариф');
        var hasReadings=thisEl.getAttribute("hasReadings");
        var tariffTemplateId = thisEl.getAttribute("id");
        $(".field_template_section").hide();

        $('.dog_number').removeAttr("disabled");
        $("#field_templates_box").html(f_t_box_content);

        $('.field_template_section').each(
                function(){
                    if ($(this).attr('tarifftemplateid') != tariffTemplateId ) {$(this).remove();}
                }
            );

        $("[tarifftemplateid="+tariffTemplateId+"]").slideDown();

        break

        case 'catalog':
        var catalogId=thisEl.getAttribute("id");
        $('.catalog_category').hide();
        $("#freelance_category_"+catalogId).show();
        $("#non_utility_service_type_"+catalogId).show();
        //alert("[freelance_category_"+catalogId+"]");
        break

        case 'showAllCategories':
        $('.catalog_category').show();
        break

        default:
        break
     }
}




