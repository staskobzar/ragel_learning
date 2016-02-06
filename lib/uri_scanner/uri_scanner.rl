#
# @LANG: ruby
# Scan text and extracts URI(s)
# 

=begin
%%{
  machine uri_scanner;
  include actions "../machines/ruby_actions.rl";
  include ip_addr "../machines/ip_addr.rl";
  include uri     "../machines/uri.rl";
  include sip_uri "../machines/sip_uri.rl";

  main := |*
    URI => {@collection << data[ts..te-1]};
    any;
  *|;
}%%
=end

class MachineURIScanner
  attr_accessor :collection

  def initialize(data)
    @collection = []
    eof = data.length
    %% write data;
    %% write init;
    %% write exec;
    #%
  end

  class << self
    def scan(data, to_objects=false)
      if to_objects
        self.new(data).collection.map do |url|
          MachineURI.new(url)
        end
      else
        self.new(data).collection
      end
    end
  end
end

