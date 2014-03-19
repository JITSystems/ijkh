class AddRegexpToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :regexp, :string

    Vendor.all.each do |v|
    	case v.id
    	when 58  then v.update_attributes(regexp: "/([\d]){3}-([\d]){2}/")
    	when 55  then v.update_attributes(regexp: "/([\d]){1}-([\w]){2}|([\d]){1}-([\w]){1}/")
    	when 38, 46, 63, 64, 15, 114, 50, 127, 129, 112, 216, 171, 172, 181, 190, 192, 167, 175, 173, 166, 149, 161, 111, 139 then v.update_attributes(regexp: "/([\d]){1}|([\d]){2}|([\d]){3}")
    	when 163 then v.update_attributes(regexp: "/([\d]){13}/")
    	when 40, 146 then v.update_attributes(regexp: "/([\d]){5}|([\d]){6}/")
    	when 65, 93, 92, 59, 99, 56, 20, 122, 126, 124, 125, 119, 123, 66, 141, 193, 177, 169, 162, 118, 142, 109 then v.update_attributes(regexp: "/([\d]){1}|([\d]){2}/")
    	when 49, 189 then v.update_attributes(regexp: "/([\d]){4}/")
    	when 150 then v.update_attributes(regexp: "/([\d]){6}/")
    	when 110 then v.update_attributes(regexp: "/([\d]){9}/")
    	when 225, 33 then v.update_attributes(regexp: "/([\d]){1}|([\d]){2}|([\d]){3}|([\d]){5}/")
    	when 183 then v.update_attributes(regexp: "/([\d]){3}|([\d]){4}/")
    	when 148 then v.update_attributes(regexp: "/([\d]){5}/")
    	when 47  then v.update_attributes(regexp: "/([\d]){4}|([\d]){5}|([\d]){6}|([\d]){7}|([\d]){8}/")
    	when 5 	 then v.update_attributes(regexp: "/([\d]){1}|([\d]){2}|([\d]){3}|([\d]){4}|([\d]){5}|([\d]){6}/")
    	when 213 then v.update_attributes(regexp: "/([\d]){3}|([\d]){4}|([\d]){5}/")
    	else
    	end
    end
  end
end
