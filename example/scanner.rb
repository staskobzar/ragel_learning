#!/usr/bin/env ruby

# Scan text and get all uris
# How to use
# >$ gem install uri_scanner
# >$ curl https://rubygems.org/ | ruby example/scanner.rb

require 'uri_scanner'

URIScanner.scan( $stdin.read ).each do |uri|
  puts uri
end
# To parse to uri objects:
# URIScanner.scan_and_parse( $stdin.read ).each ...
