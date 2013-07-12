object @place_account

attributes :title, :amount, :place_id, :service_account

node :amount do |o|
  o.amount.to_s
end