class Instituicao < ActiveRecord::Base

	def sysup
		idIlha = self.idIlha
		servers=["30","100","50","101","80","1","10","11","12","13"]
		threads = []
		status = []
		servers.map do |s|
			threads << Thread.new { 
				service = Net::Ping::External.new("10.#{idIlha}.0.#{s}",7,1)
				if service.ping?
					status.push("#{s},up")
				else
					status.push("#{s},down")
				end
			}
		end
		threads.each { |t| t.join }
		status = self.organize(servers,status)
		status = self.optServices(status)
		self.status = islandStatus(status)
		status.map { |x| "#{x}" }
	end

	def organize(v1,v2)
		v1.each do |x|
			v2.each do |y|
				service = y.tr(",downup", "")
				status = y.tr(",012358", "")
				if x.eql? service
					v2[v2.index(y)], v2[v1.index(x)] = v2[v1.index(x)], v2[v2.index(y)]
					v2[v2.index(y)] = status
				end
			end
		end
		v2.map { |x| "#{x}" }
	end

	def optServices(v)
		if self.omf.eql? "on"
			service = Net::Ping::External.new("10.#{idIlha}.11.200",7,1)
      			if service.ping?
				v.insert(2, "up")
			else
				v.insert(2, "down")
			end
		else
			v.insert(2,"na")	
    		end
    		if self.vpn.eql? "on"
                	service = Net::Ping::External.new("10.#{idIlha}.0.70",7,1)
                        if service.ping?
                                v.insert(6, "up")
			else
				v.insert(6, "down")
			end
		else
                        v.insert(6,"na")
    		end
		v.map { |x| "#{x}" }
	end

	def islandStatus(v)
		if v.at(0).eql?	"up"
			"available"
			if v.at(3).eql? "up"
				"available"
				if v.at(4).eql? "up"
                        	        "available"
        	                        if (v.at(8).eql? "down") && (v.at(9).eql? "down") && (v.at(10).eql? "down") && (v.at(11).eql? "down")
                        			"not available"
                			else
                        			"available"
                			end
				else
                                	"not available"
	                        end
			else
				"not available"
			end
		else
			"not available"
		end
	end

end
