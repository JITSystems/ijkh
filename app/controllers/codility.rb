class Solution 
	attr_reader :array

	def initialize(a)
		@array = a
	end

	def peak?(l, c ,r)
		l < c && c > r
	end

	def peaks
	@peaks ||= (array.each_with_index.map do |val, index|
                  unless index == 0 || index == array.length - 1
                    index if peak?(array[index-1], array[index], array[index+1])
                  end
                end).select {|el| !el.nil?}
  	end

	def can_set_flags?(nr)
		return false if peaks.length < nr

		last_index = peaks[0]
		sum = 1
		peaks.each_with_index do |val, index|
			if index != 0 && (val - last_index) >= nr
				last_index = val
				sum += 1
			end
		end
		sum >= nr
	end

	def solve
		(1..peaks.length).lazy.map {|nr| can_set_flags?(nr)}.take_while {|can| can}.count
	end
end

def solution(a)
	puts Solution.new(a).solve
end