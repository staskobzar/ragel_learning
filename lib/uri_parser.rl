#
# @LANG: ruby
# Parsing URI
# 

=begin
%%{
  machine m_uri;
  include uri "../machines/uri.rl";

# Additionally treat SIP URI scheme which seems to be somehow not compatible
# with RFC986.
# http://www.ietf.org/mail-archive/web/sip/current/msg26338.html
# http://www.ietf.org/mail-archive/web/sip/current/msg26385.html
# Here comes RFC3261 ABN form.
  main := URI_REF; # | SIP_URI
}%%
=end
class URIParserError < Exception; end

class MachineURI
  attr_accessor :scheme, :host, :userinfo, :port, :query, :fragment
  def initialize(data)
    @is_valid = false
    eof = data.length
    start = 0
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

