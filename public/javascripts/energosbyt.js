	$( "form#energosbyt_form" ).submit(function( event ) {

		  event.preventDefault();
	});

	var totalInfoRender = function(data){
		$('#insert_info_here').hide();
    	$('#insert_info_here').html(data);
    	$('#insert_info_here').slideDown('fast');
	}

	$('#get_user_account_info').click(function () {

		var user_account = $('#search_by_user_account').val();
		var total_info = '';
		
		if ( user_account == '' )
		{	
			total_info = '<p class = "energosbyt_line">Введите лицевой счёт.</p>';
			totalInfoRender(total_info);
		}	
		else
		{

			$('#insert_info_here').html('<img src="/images/progressbar.gif" alt="progressbar">');

			$.ajax({
				dataType: 'json',
			    type: "POST",
			    url: "/energosbyt",
			    data: { user_account: user_account } ,
			    success: function(result){ 

			       	if (result == "")
			    	{ 
			    		total_info = '<p class = "energosbyt_line">Лицевой счёт не найден.</p>';
			    		totalInfoRender(total_info);
			    	}
			    	else
			    	{
				    	var apartment = '';
				    	if (result.apartment == null) { apartment = ''; }
				    	else { apartment = ', кв.' + result.apartment; }

				    	var invoice_amount = '';
				    	if (result.invoice_amount == null || result.invoice_amount == 0 ) { invoice_amount = ''; }
				    	else { invoice_amount = '<p class = "energosbyt_line"><span class = "energosbyt_title"> Сумма задолженности: </span>' + result.invoice_amount + ' руб. </p>'; }

total_info = '<p class = "energosbyt_line"><span class = "energosbyt_title"> Лицевой счёт: </span>' + result.user_account + '</p>' +
				 '<p class = "energosbyt_line"><span class = "energosbyt_title"> Адрес: </span>г.' + result.city + ', ул.' +result.street + ', д.' + result.building + apartment +'</p>' +
				 '<p class = "energosbyt_line"><span class = "energosbyt_title"> Дата снятия показаний: </span>' + result.bypass + '</p>' +
				 '<p class = "energosbyt_line"><span class = "energosbyt_title"> Показания на дату: </span>' + result.data + '</p>' +
				 invoice_amount +
				 '<p class = "energosbyt_line"><span class = "energosbyt_title"> Показания счётика: </span>' + result.meter_reading + '</p>' ;

				    	totalInfoRender(total_info);
			    	}
			    }
			});
		}
	});