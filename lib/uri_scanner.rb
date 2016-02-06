require "uri_scanner/ip_address"
require "uri_scanner/uri_parser"
require "uri_scanner/uri_scanner"
require "uri_scanner/version"

module URIScanner
  def is_ip_valid?(ip_addr)
    MachineIpAddr.new.is_valid? ip_addr
  end

  def parse_uri(data)
    MachineURI.new data
  end

  def scan(data)
    MachineURIScanner.scan data
  end

  def scan_and_parse(data)
    MachineURIScanner.scan data, true
  end

  module_function :is_ip_valid?, :parse_uri, :scan, :scan_and_parse
end
