class CommissionManager
  def self.calculate(amount)
  	commission = {}
  	amount = FloatModifier.modify(amount)
  	commission[:total] = amount
  	commission[:service_tax] = 0.0
  	commission[:po_tax] = 0.0

  	commission
  end
end