$(document).ready(function($) {
	$('.login_input_check').click(function(){
		if ($('#some_input').is(':checked')){
			$('.login_input_check').css('background-image','url(images/checkbox_off.png)')
		}
		else {
			$('.login_input_check').css('background-image','url(images/checkbox_on.png)')
		}
	})

//      проверки импутов

	$('.login_input_check_oferta').click(function(){
		if ($('#some_input_oferta').is(':checked')){
			$('.login_input_check_oferta').css('background-image','url(images/checkbox_off.png)')
			$('.oferta_link_disable').css('display','block');
            $('.submit_button_oferta').css('background-color','#8da9bc');
			$('.submit_button_oferta').css('color','#6a7f8d');
			$('.submit_button_oferta').css('text-shadow','1px 1px 0px #FFF');
		}
		else {
			$('.login_input_check_oferta').css('background-image','url(images/checkbox_on.png)');
			$('.oferta_link_disable').css('display','none');
            $('.submit_button_oferta').css('background-color','#0071bc');
			$('.submit_button_oferta').css('color','#FFF');
			$('.submit_button_oferta').css('text-shadow','none');
		}
	})
    $('#reg_oferta_second_check').click(function(){
        if ($('.accept_oferta').find('#some_input_oferta').is(':checked')){
            $('.reg_oferta_second_check').css('background-image','url(images/checkbox_off.png)')
            $('.reg_disable').css('display','block');
            $('.accept_data_button').css('background-color','#8da9bc');
            $('.accept_data_button').css('color','#6a7f8d');
            $('.accept_data_button').css('text-shadow','1px 1px 0px #FFF');
        }
        else {
            $('.reg_oferta_second_check').css('background-image','url(images/checkbox_on.png)');
            $('.reg_disable').css('display','none');
            $('.accept_data_button').css('background-color','#0071bc');
            $('.accept_data_button').css('color','#FFF');
            $('.accept_data_button').css('text-shadow','none');
        }
    });

//      всплытие дивов регистрации

    $('.accept_data_button').click(function(){
        $('#div_place').fadeIn('slow');
        //var HeightScreen = $(window).height();
        //$(HeightScreen).scrollBottom('slow')
    })
    
//      отрисовка селектов

$('select').each(function(){
	var select = $(this)
    var selectBoxContainer = $('<div>',{
        width       : '100%',
        class   	: 'tzSelect',
        html        : '<div class="selectBox" class=' + this.id + '></div>'
    });
 
    var dropDown = $('<ul>',{class:'dropDown'});
    var selectBox = selectBoxContainer.find('.selectBox');
    
    // Цикл по оригинальному элементу select
    
        select.find('option').each(function(i){
            var option = $(this);
            
            if(i==select.is('selected')){
                selectBox.html(option.text());
            }
            if(option.data('skip')){
                return true;
            }

 //' + 'id=' + option.attr('id') + '" class="' + option.attr('class') + '" 

            var li = $('<li>' ,{
                   html:   '<p>'+option.text()+'</p>'

                });

           li.attr("class", option.attr('class'));
           li.attr("id", option.attr('id'));
           li.attr("listType", option.attr('listType'));
           li.attr("serviceTypeId", option.attr('serviceTypeId'));
           li.attr("vendorId", option.attr('vendorId'));
           li.attr('onclick','myFun(this);');

            li.attr('rel',option.val());
                if (li.attr('rel') % 2 == 0){
                   li.addClass('secondcolor')
                 // li.attr("class", option.attr('class'))
            }  

            li.click(function(){
                 
                selectBox.html(option.text());
                dropDown.trigger('hide');
                 
                // Когда происходит событие click, мы также отражаем
                // изменения в оригинальном элементе select:
                select.val(option.val());
                 
                return false;
            });
             
            dropDown.append(li);
    });     
    selectBoxContainer.append(dropDown.hide());
    select.hide().after(selectBoxContainer);
     
    // Привязываем пользовательские события show и hide к элементу dropDown:
     
    dropDown.bind('show',function(){
       if(dropDown.is(':animated')){
            return false;
        }
         
        selectBox.addClass('expanded');
        dropDown.slideDown();

    }).bind('hide',function(){
         
        if(dropDown.is(':animated')){
            return false;
        }         

        selectBox.removeClass('expanded');
        dropDown.slideUp();        

    }).bind('toggle',function(){
        if(selectBox.hasClass('expanded')){
            dropDown.trigger('hide');
        }
        else dropDown.trigger('show');
    });
     
    selectBox.click(function(){
        dropDown.trigger('toggle');
        return false;
    }); 
    // Если нажать кнопку мыши где-нибудь на странице при открытом элементе dropDown,
    // он будет спрятан:
    $(document).click(function(){
        dropDown.trigger('hide');
    });
});

 $(this).remove();
 //$(".vendors_option").hide();
});



function myFun(thisEl){
   // var myClass="'" + bla.attr("id")+ "'"; $(myClass).hide();
     //console.log(thisEl.getAttribute("listType"));
    listType=thisEl.getAttribute("listType");
    //serviceTypeId=thisEl.getAttribute("serviceTypeId");
     

     //$(".vendors_option").show();
     //$("."+listId).hide();
     // var listType = thisEl.getAttribute("class");

     switch (listType)
     {
        case 'serviceType':
        console.log('Услуга');
        var serviceTypeId=thisEl.getAttribute("id");
        $("[listtype=vendor]").hide();
        $("[servicetypeid="+serviceTypeId+"]").show();
        break
        
        case 'vendor':
        console.log('Вендор');
        var vendorId=thisEl.getAttribute("id");
        $("[listtype=tariff]").hide();
        $("[vendorid="+vendorId+"]").show();
        break

        case 'tariff':
        console.log('Тариф');
        break

        default:
        break
     }
}