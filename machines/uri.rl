# Ragel machine : URI
# RFC 3986 ANBN

%%{
  machine uri;
  include ip_addr;

  PCT_ENC = "%" xdigit xdigit
}%%
