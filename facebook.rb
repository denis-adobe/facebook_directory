require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'rubygems'

https_url="https://www.facebook.com/directory/people/"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def open_links(new_url,*array)

      doc = Nokogiri::HTML open(new_url)
      links = doc.css(".fbDirectoryBox a")
      p doc.css("title")[0].text

links.each do |link|


        if !doc.at_css(".direct_listing")
              array << link["href"]
              return open_links(link["href"],array)
        else
              p link["href"]
              p array
              File.write("log.txt",array.to_s)

        end#if

end#each

end



open_links(https_url)
