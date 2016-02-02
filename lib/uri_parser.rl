#
# @LANG: ruby
# Parsing URI
# 

=begin
%%{
  machine m_uri;
  include uri "../machines/uri.rl";

  action fetch_scheme{
    @scheme = data[0..p-1]
  }

  action fetch_host{
    @host = data[start..p]
  }

  m_authority = (USERINFO "@")? HOST >{start=p} @fetch_host (":" PORT)?;
  m_rel_part   = ("//" m_authority PATH_ABEMPTY) |
                 PATH_ABSOLUTE |
                 PATH_NOSCHEME |
                 PATH_EMPTY ;
  m_hpart     = ("//" m_authority PATH_ABEMPTY) |
                PATH_ABSOLUTE |
                PATH_ROOTLESS |
                PATH_EMPTY;
  m_uri       = SCHEME %fetch_scheme
                ":" m_hpart ("?" QUERY)? ("#" FRAGMENT)?;
  m_rel_ref   = m_rel_part ("?" QUERY)? ("#" FRAGMENT)?;
  main := m_uri | m_rel_ref;
}%%
=end
class URIParserError < Exception; end

class MachineURI
  attr_accessor :scheme, :host
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

