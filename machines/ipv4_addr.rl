# Ragel machine for parsing IPv4 addresses

%%{
  machine ipv4_addr;

  OCTET = digit |
          digit digit |
          "0" digit digit |
          "1" digit digit |
          "2" [0-4] digit |
          "2" "5" [0-5]
          ;
  IPv4_ADDR = (OCTET "."){3} OCTET;
}%%
