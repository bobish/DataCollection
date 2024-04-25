
require 'nokogiri'
require 'csv'
require 'open-uri'

url = "https://www.calyxsoftware.com/products/point/partners-vendors-integrations"
page = Nokogiri::HTML(URI.open(url))

CSV.open("calyx.csv","a+") do |csv|
	csv << ["Service Type","Company", "Phone Number", "Website"]
end

CSV.open("calyx.csv","a+") do |csv|

	page.css("div.category-row.table-row").each do |row|
		ser = com = ph = web = ""
		row.css("div.category-row-flex").each do |nextrow|
			ser = nextrow.css("div")[0].text.strip
			com = nextrow.css("div")[1].text.strip
			ph = nextrow.css("div")[2].text.strip
			if nextrow.css("div")[3].css("a").length > 0
				web = nextrow.css("div")[3].css("a")[0]['href']
			end
			puts ser, com, ph, web
			csv << [ser, com, ph, web]
		end

	end

end
