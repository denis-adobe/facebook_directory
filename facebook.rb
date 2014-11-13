require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'rubygems'

require './sqlite.rb'

https_url="https://www.facebook.com/directory/people/"
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def open_links(new_url)

      doc = Nokogiri::HTML open(new_url)
      links = doc.css(".fbDirectoryBox a")
      p doc.css("title")[0].text

links.each do |link|

if !doc.at_css(".direct_listing")# Keine Nutzerliste
open_tree = open_links(link["href"])
#elsif # Sicherheitskontrolle

else# Nutzerliste
File.open("links.txt", 'a') { |file| file.write(link["href"] + "\n") }
end#if
end#each
end#def

def char_select(site_url)

site = Nokogiri::HTML open(site_url)
p site.at_css("title")
chars = site.css(".alphabet_list a")
chars.each do |char|
p char["href"]
open_link = open_links(char["href"])
end#each

end


char_select(https_url)
