require "csv"

print "Enter the key port number :"
port     = (gets.to_s).chomp
print "Enter the key protocol (tcp or udp) :"
protocol = (gets.to_s).chomp
CSV.open("service-names-port-numbers.csv","r") do |csv|
	csv.each do |row|
		if row[1] == port
			if row[2] == protocol
				print row[0]
			end
		end
	end
end