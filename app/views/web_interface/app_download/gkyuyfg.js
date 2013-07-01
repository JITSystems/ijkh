$.ajax({
    url: "/api/1.0/servicetype",
    type: "POST",
    data: {service: 
	    	{
	             field: 1, 
	             field2: 2, 
	             	tariff: {
	             		field: 1, 
	             		field2: 2
	             	} 
	        }
         },
    success: console.log('Ничего не произошло')
});