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

class MachineURI
  def initialize(data)
    @is_valid = false
    %% write data;
    %% write init;
    %% write exec;
    #%
    if cs >= m_uri_first_final
      @is_valid = true
    end
  end

  def is_valid?
    @is_valid
  end
end

o = MachineURI.new("mailto:user@domain.com")
puts o.is_valid?
