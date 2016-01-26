# Ragel machine : IP address
# Include IPv4 and IPv6 addresses 

%%{
  machine ip_addr;
  include ipv4_addr "ipv4_addr.rl";

  IP_ADDR = IPv4_ADDR;
}%%
