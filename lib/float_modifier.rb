class FloatModifier
  # Modifies float values to be used in application
  def self.modify(float)
  	# All-in-one method. Gets float or float in string format, checks if it has a comma in notation,
  	# substitutes comma with dot, rounds float value up
  	float = substitute_comma(float)
  	float = round_up(float)
  end

  def self.substitute_comma(float)
  	# Substitutes comma with dot, if required
  	if float.to_s.index(',')
  	  float = float.to_s.split(',')
  	  float = float.first << '.' << float.last
  	end
  	float
  end

  def self.format(float)
    # Formats float value to 'xxx.xx', returns string
    float.to_s =~ /\d+.(\d+)/
    unless $1 =~ /\d\d/
      float = float.to_s + '0'
    end
    float.to_s
  end

protected

  def self.round_up(float)
  	# Rounds up float value
  	float = float.to_f
  	(float*100).ceil/100.0
  end

end