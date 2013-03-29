require 'gmail'

username = "test.council.worker@gmail.com"
password = "eternal1234"


Gmail.new(username, password) do |gmail|

gmail.inbox.emails.each do |mail|
	puts mail.subject
	puts mail.body
end

gmail.logout
end
