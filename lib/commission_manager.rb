class CommissionManager

  def calculate(amount, commission=0.0)
  	commission_hash = {}
  	amount = FloatModifier.modify(amount)
  	commission_hash[:total] = FloatModifier.modify(amount + amount*(commission/100.00))
  	commission_hash[:service_tax] = FloatModifier.modify(amount*(commission/100.00))
  	commission_hash[:po_tax] = 0.0

  	commission_hash[:total] = FloatModifier.format(commission_hash[:total])
  	commission_hash[:service_tax] = FloatModifier.format(commission_hash[:service_tax])
  	commission_hash[:po_tax] = FloatModifier.format(commission_hash[:po_tax])
  	commission_hash
  end
end