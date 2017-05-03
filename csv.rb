require "csv"

@db = CSV.read("./protocolslist/service-names-port-numbers.csv", headers: false)



def getprotocolname(port, protocol)
	@db.each do |row|
		if row[1] == port
			if row[2] == protocol.downcase
				 @service_name = row[0]
			end
		end
	end

	if @service_name then
		return @service_name
	else
		return 'unknown'
	end
end

p getprotocolname('4', 'tcp')
p getprotocolname('23', 'tcp')
p getprotocolname('23', 'tcp')
p getprotocolname('23', 'tcp')
