#
# @LANG: ruby
# Parsing IP address (IPv4/IPv6) 
# 

%%{
  machine m_ipaddr;
  include ip_addr "../machines/ip_addr.rl";

  main := IP_ADDR;
}%%

# Ruby Class goes here
class MachineIpAddr

  def initialize
    %% write data;
  end

  def is_valid?(data)
    %% write init;
    %% write exec;
    cs >= m_ipaddr_first_final
  end
end

# EOF
