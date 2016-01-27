# Ragel machine : IP address
# Include IPv4 and IPv6 addresses 

%%{
  machine ip_addr;
  include ipv4_addr "ipv4_addr.rl";
  include ipv6_addr "ipv6_addr.rl";

  IP_ADDR = IPv4_ADDR | IPv6_ADDR;
}%%
