# encoding: utf-8
class MoveTable

  def initialize(from_table)
    @from_table = from_table
  end

  def move
    data = {}
    attrs = @from_table.constantize.column_names
    @from_table.constantize.where('id < 30').each do |line|
      attrs.each {|a| data[a] = line.send(a)}
    end
  end
end