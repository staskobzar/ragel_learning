#!/usr/bin/env ruby

# Scan text and get all uris
# How to use
# >$ gem install uri_scanner
# >$ ruby example/parse.rb URL
#
# Try:
# ruby example/parse.rb "foo://user:pass@example.com:8042/over/there?name=ferret#nose"
# ruby example/parse.rb "sips:alice:secretW0rd@gateway.com:5061;transport=udp;user=phone;method=REGISTER?subject=sales%20meeting&priority=urgent&to=sales%40city.com"
#

require 'uri_scanner'

begin
  raise "Usage: #{__FILE__} URI" unless ARGV.first
  uri = URIScanner.parse_uri ARGV.first
  puts "URI #{ARGV.first} segments:"
  puts "scheme:     #{uri.scheme}"
  puts "host:       #{uri.host}"
  puts "port:       #{uri.port}"
  puts "userinfo:   #{uri.userinfo}"
  puts "username:   #{uri.username}"
  puts "password:   #{uri.password}"
  puts "path:       #{uri.path}"
  puts "query:      #{uri.query}"
  puts "fragment:   #{uri.fragment}"
  puts "param:      #{uri.param}"
  puts "header:     #{uri.header}"
rescue Exception => e
  puts e.message
end
