# Ragel machine: IPv4 addresses
# ===
# Implements RFC 3986 [Section 3.2.2]
#      IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet
#
#      dec-octet   = DIGIT                 ; 0-9
#                  / %x31-39 DIGIT         ; 10-99
#                  / "1" 2DIGIT            ; 100-199
#                  / "2" %x30-34 DIGIT     ; 200-249
#                  / "25" %x30-35          ; 250-255
#
# Additionally also treating leading "0".
# For example 001.010.100.1 == 1.10.100.1
%%{
  machine ipv4_addr;

  OCTET4 =  ("0" | "00")? digit |
            "0"? [1-9] digit    |
            "1" digit{2}        |
            "2" [0-4] digit     |
            "25" [0-5]          ;

  IPv4_ADDR = (OCTET4 "."){3} OCTET4;
}%%
