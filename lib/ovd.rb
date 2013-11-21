#!/usr/bin/ruby -w
#encoding: utf-8
class Ovd
	def self.xls_parser
		s = Roo::Excel.new("база участковых.xls")
		(1..s.last_row).each do |i|
			address_ovd = s.cell(i, 2).split(", ")
			full_name 	= 	s.cell(i, 4).split(" ")
			sector	 	= 	s.cell(i, 5).split("; ")
			
			Precinct.create!(
					ovd: 				s.cell(i, 1),
					ovd_town: 			address_ovd[0],
					ovd_street: 		address_ovd[1],
					ovd_house: 			address_ovd[2],
					ovd_telnumber: 		s.cell(i, 3) ? s.cell(i, 3).to_i : s.cell(i, 3),
					surname: 			full_name[0],
					name: 				full_name[1],
					middlename: 		full_name[2]
			)
			sector.each do |ad|
				address = []
				address = ad.split(",")
				PrecinctStreet.create!(street: address[0].lstrip) unless PrecinctStreet.where(street: address[0]).first
				
				(1..address.size).each do |i|
					next if address[i] == nil || address[i] == " "
					houses = []
					houses << case address[i].gsub(' ', '')
							  when /(\d+)-(\d+)/
								array = []
								address[i].gsub(' ', '') =~ /(\d+)-(\d+)/
								array << ($1..$2).to_a.each { |x| x.to_i }
								array.flatten!.uniq	
							  else
								address[i]
							  end
					houses.flatten.each do |house|
						PrecinctHouse.create!(
							precinct_id: 		Precinct.where(surname: full_name[0], name: full_name[1]).first.id,
							precinct_street_id: PrecinctStreet.where(street: address[0].lstrip).first.id,
					    	house: 				house.lstrip
						)
					end
				end
			end
		end
	end
end