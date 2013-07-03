$('select[name="Hot Fuzz"]')



$('input[name="service[meter_reading]"]').each(function(){

});





  $.ajax({
    url: "/service",
    type: "POST",
    data: {
        service: 
            {
                vendor_id: $('select[name="service[vendor_id]"]').val(), 
                service_type_id: $('select[name="service[service_type_id]"]').val(), 
                place_id: $('input[name="service[place_id]"]').val(), 
                user_account: $('input[name="service[user_account]"]').val(), 
                    tariff: 
                    {
                        tariff_template_id: $('select[name="service[tariff_template_id]"]').val(), 

                        'fields[]': 
                        {

                        	field_template_id: $('input[name="service[field_template_id]"]').val(), 

                        	meter_reading: { reading: $('input[name="service[meter_reading]"]').val() }  

                    	}

                    } 
            }
         },
    success: console.log('Чёт ушло')
});



'fields[]': 
{
	{
		field_template_id: айдишник, 
		meter_reading: { reading: ридинг }
	},

	{
		field_template_id: айдишник), 
		meter_reading: { reading: ридинг }  
	},

	{
		field_template_id: айдишник), 
		meter_reading: nil
	},	

}