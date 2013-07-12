object @recipe => :recipe

attributes :id, :currency, :total, :amount, :po_tax, :service_tax, :updated_at, :user_id, :account_id, :service_id

node :total do |o|
	FloatModifier.format(o.total)
end