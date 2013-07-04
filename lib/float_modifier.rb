class FloatModifier
  def self.modify(float)
  	float = substitute_comma(float)
  	float = round_up(float)
  	float = format(float)
  end

  def self.substitute_comma(float)
  	if float.to_s.index(',')
  	  float = float.to_s.split(',')
  	  float = float.first << '.' << float.last
  	end
  	float.to_f
  end

protected

  def self.round_up(float)
  	(float*100).ceil/100.0
  end

  def self.format(float)
  	float.to_s =~ /\d+.(\d+)/
  	unless $1 =~ /\d\d/
  	  float = float.to_s + '0'
  	end
  	float
  end

end