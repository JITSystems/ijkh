class CommissionManager

  def calculate(amount, commission=0.0)
  	commission = {}
  	amount = FloatModifier.modify(@amount)
  	commission[:total] = amount + amount*(@commission/100.00)
  	commission[:service_tax] = amount*(@commission/100.00)
  	commission[:po_tax] = 0.0

  	commission
  end
end