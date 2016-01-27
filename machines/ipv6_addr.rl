# Ragel machine: IPv4 addresses
# ===
# Implements RFC 3986 [Section 3.2.2]
# IPv6address =                            6( h16 ":" ) ls32
#                   /                       "::" 5( h16 ":" ) ls32
#                   / [               h16 ] "::" 4( h16 ":" ) ls32
#                   / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32
#                   / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32
#                   / [ *3( h16 ":" ) h16 ] "::"    h16 ":"   ls32
#                   / [ *4( h16 ":" ) h16 ] "::"              ls32
#                   / [ *5( h16 ":" ) h16 ] "::"              h16
#                   / [ *6( h16 ":" ) h16 ] "::"
# 
#       ls32        = ( h16 ":" h16 ) / IPv4address
#                   ; least-significant 32 bits of address
# 
#       h16         = 1*4HEXDIG
#                   ; 16 bits of address represented in hexadecimal

%%{
  machine ipv6_addr;

  H16       = xdigit{1,4} ;
  LS32      = (H16 ":" H16) | IPv4_ADDR ;
  IPv6_ADDR =                        (H16 ":"){6} LS32 |
                                "::"              H16  |
                                "::" (H16 ":"){5} LS32 |
                            H16 "::" (H16 ":"){4} LS32 |
              (H16 ":"){,1} H16 "::" (H16 ":"){3} LS32 |
              (H16 ":"){,2} H16 "::" (H16 ":"){2} LS32 |
              (H16 ":"){,3} H16 "::"  H16 ":"     LS32 |
              (H16 ":"){,4} H16 "::"              LS32 |
              (H16 ":"){,5} H16 "::"              H16  |
              (H16 ":"){,6} H16 "::"                   ;
}%%
