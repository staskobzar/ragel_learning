# Ragel machine for parsing IPv4 addresses

%%{
  machine ipv4_addr;

  OCTET = digit{1,3};
  IPv4_ADDR = (OCTET "."){3} OCTET;
}%%
