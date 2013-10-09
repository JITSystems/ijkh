object @recipe => :recipe

attributes :id, :currency, :total, :amount, :po_tax, :updated_at, :user_id, :account_id, :service_id

node :service_tax do |r|
	r.service_tax.to_s
end