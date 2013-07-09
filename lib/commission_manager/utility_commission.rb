class UtilityCommission < CommissionManager
  def self.calculate(amount)
  	commission = {}
  	po_tax = 0.0
  	service_tax = 0.0
  	total = 0.0
  	amount = FloatModifier.modify(amount)

  	if amount.to_f < 500.00
  	  po_tax = 3.00
	  service_tax = po_tax + 0.03*amount.to_f
  	else
  	  po_tax = 0.00
	  service_tax = po_tax + 0.03*amount.to_f
  	end
  	
  	total = amount.to_f + service_tax.to_f
  	commission[:amount] = amount
  	commission[:total] = amount.to_f + total.to_f
  	commission[:service_tax] = service_tax
  	commission[:po_tax] = po_tax

  	commission
  end
end