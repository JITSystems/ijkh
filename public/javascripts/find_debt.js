	$( "form#find_debt_form" ).submit(function( event ) {

		  event.preventDefault();
	});

	var insert_info_here = $('#insert_info_here');

	var totalInfoRender = function(data){
		insert_info_here.hide();
    	insert_info_here.html(data);
    	insert_info_here.slideDown('fast');
	}

	$('#get_user_account_info').click(function () {

		var user_account = $('#search_by_user_account').val();
		var vendor_id = $('#vendor_id').val();
		var total_info = '';
		
		if ( user_account == '' )
		{	
			total_info = '<p class = "find_debt_line">Введите лицевой счёт.</p>';
			totalInfoRender(total_info);
		}	
		else
		{

			insert_info_here.html('<img src="/images/progressbar.gif" alt="progressbar">');

			$.ajax({
				dataType: 'json',
			    type: "POST",
			    url: "/find_debt",
			    data: { user_account: user_account, vendor_id: vendor_id } ,
			    success: function(result){ 


			    	if ($('#vendor_id').val() == 16) {
			    		total_info = '<p class = "find_debt_line">Баланс по договору ' + user_account + ':</p>' + '<p class = "find_debt_line">' + result + '</p>'
			    		if (result == null) {total_info = '<p class = "find_debt_line">Лицевой счёт не найден.</p>';}
			    	}
			    	else
			    	{
			    		if (result == "")
						    	{ 
						    		total_info = '<p class = "find_debt_line">Лицевой счёт не найден.</p>';
						    	}
						    	else
						    	{
							    	var apartment = '';
							    	if (result.apartment == null) { apartment = ''; }
							    	else { apartment = ', кв.' + result.apartment; }

							    	var invoice_amount = '';
							    	if (result.invoice_amount == null || result.invoice_amount == 0 ) { invoice_amount = ''; }
							    	else { invoice_amount = '<p class = "find_debt_line"><span class = "find_debt_title"> Сумма задолженности: </span>' + result.invoice_amount + ' руб. </p>'; }

			total_info = '<p class = "find_debt_line"><span class = "find_debt_title"> Лицевой счёт: </span>' + result.user_account + '</p>' +
							 '<p class = "find_debt_line"><span class = "find_debt_title"> Адрес: </span>г.' + result.city + ', ул.' +result.street + ', д.' + result.building + apartment +'</p>' +
							 '<p class = "find_debt_line"><span class = "find_debt_title"> Дата снятия показаний: </span>' + result.bypass + '</p>' +
							 '<p class = "find_debt_line"><span class = "find_debt_title"> Показания на дату: </span>' + result.data + '</p>' +
							 invoice_amount +
							 '<p class = "find_debt_line"><span class = "find_debt_title"> Показания счётика: </span>' + result.meter_reading + '</p>' ;

						    	}

			    	}

			    	totalInfoRender(total_info);
			    }
			});
		}
	});