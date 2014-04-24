# encoding: utf-8
class MoveTable

  def initialize(url, from_table)
    @url = url
    @from_table = from_table
  end

  def auth_token 
    response = HTTParty.post( "#{@url}/users/sign_in.json",
      :body => { :user =>  { :email => "test@iz.ru", :password => "qwerty" }}.to_json,
      :headers => { 'Content-Type' => 'application/json' })
    response.parsed_response["user"]["auth_token"]
  end

  def move
    # line_data, data, lenth = {}, {}, 1
    # attrs = @from_table.constantize.column_names
    # @from_table.constantize.all.each do |line|
    #   attrs.each {|a| line_data[a] = line.send(a)}
    #   data[lenth] = line_data
    #   lenth += 1
    # end
    response = HTTParty.post( "http://192.168.0.100/users?auth_token=LuNXcS4tAGMgj8xwr7LR",
      :body => { test: {lol: "lollol"}}.to_json,
      :headers => {'Content-Type' => 'application/json'})
  end
end

      # :body => { data: data, metadata: { lenth: lenth }}.to_json,
