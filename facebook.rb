require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'rubygems'

https_url="https://www.facebook.com/directory/people/"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def open_links(new_url)


  doc = Nokogiri::HTML open(new_url)
  links = doc.css(".fbDirectoryBox a")
  puts doc.css("title")[0].text

links.each do |link|
  if !doc.at_css(".direct_listing")
  return open_links link["href"]
  else
  puts new_url
  end

end

end

open_links(https_url)
