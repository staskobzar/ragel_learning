#
# @LANG: ruby
#

%%{
  machine lexer;
  include ip_addr "machines/ip_addr.rl";

  main := IP_ADDR;
}%%

%% write data;

def run_machine(data)
  %% write init;
  %% write exec;
  if cs >= lexer_first_final
    puts "OK:   #{data}"
  else
    puts "FAIL: #{data}"
  end
end

ips = %W[
  10.0.0.1
  0.0.0.0
  1.0.a.0
  192.168.0.10
  aaww
  222.333.444.555
]
ips.each{|ip| run_machine(ip)}
