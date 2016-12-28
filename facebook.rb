require 'nokogiri'
require 'open-uri'
require 'openssl'

FBDirectory="https://www.facebook.com/directory/people/"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#
# Open Links recursively until Accountnames are reached
#
def open_links(new_url)
	doc = Nokogiri::HTML open(new_url)
	links = doc.css(".fbDirectoryBox a")
	p doc.css("title")[0].text

	links.each do |link|
		if !doc.at_css(".direct_listing")# no userlist found
			open_tree = open_links(link["href"])
		else
			File.open("links.txt", 'a') { |file| file.write(link["href"] + "\n") }
		end
	end
end

#
# Select all Characters from div.alphabet_list a
# and use the links to iterate the link list
#
def char_select(site_url)
	site = Nokogiri::HTML open(site_url)
	p site.at_css("title")
	chars = site.css(".alphabet_list a")
	chars.each do |char|
		p char["href"]
		open_link = open_links(char["href"])
	end
end

char_select(FBDirectory)
