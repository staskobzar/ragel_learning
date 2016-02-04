#
# @LANG: ruby
# Parsing URI
# 

=begin
%%{
  machine m_uri;
  include actions "../machines/ruby_actions.rl";
  include ip_addr "../machines/ip_addr.rl";
  include uri     "../machines/uri.rl";
  include sip_uri "../machines/sip_uri.rl";

  main := URI_REF | SIP_URI;
}%%
=end
class URIParserError < Exception; end

class MachineURI
  attr_accessor :scheme, :host, :userinfo, :port, :query, :fragment, :path
  def initialize(data)
    @is_valid = false
    eof = data.length
    mark = 0
    %% write data;
    %% write init;
    %% write exec;
    #%
    if cs >= m_uri_first_final
      @is_valid = true
    else
      raise URIParserError
    end
  end

  def is_valid?
    @is_valid
  end

end

