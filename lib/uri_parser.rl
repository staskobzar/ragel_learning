#
# @LANG: ruby
# Parsing URI
# 

=begin
%%{
  machine m_uri;
  include uri "../machines/uri.rl";

  main := URI_REF;
}%%
=end
class URIParserError < Exception; end
class URIParserInvalidScheme < URIParserError; end

class MachineURI
  attr_accessor :scheme
  def initialize(data)
    @is_valid = false
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

