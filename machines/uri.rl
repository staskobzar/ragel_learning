# Ragel machine : URI
# RFC 3986
#         foo://example.com:8042/over/there?name=ferret#nose
#         \_/   \______________/\_________/ \_________/ \__/
#          |           |            |            |        |
#       scheme     authority       path        query   fragment
#          |   _____________________|__
#         / \ /                        \
#         urn:example:animal:ferret:nose

%%{
  machine uri;
  include ip_addr "ip_addr.rl";

# Percent-Encoding. Example: "%20" (space)
  PCT_ENC         = "%" xdigit xdigit;

# These characters are called "reserved" because 
# they may (or may not) be defined as delimiters by
# the generic syntax.
  GEN_DELIMS      = [:/?#[\]@];
  SUB_DELIMS      = [!$&'()*+,;=];
  RESERVED        = GEN_DELIMS | SUB_DELIMS;

# Characters that are allowed in a URI but do not 
# have a reserved purpose.
  UNRESERVED      = alnum | [\-\._~];

# URI  Scheme
# scheme      = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
  SCHEME          = alpha (alnum | [+\-\.])*;

# Hierarchical element for a naming authority
# authority   = [ userinfo "@" ] host [ ":" port ]
  USERINFO        = (UNRESERVED | PCT_ENC | SUB_DELIMS | ":")*;
  IPv_FUTURE      = "v" xdigit{,1} "." (UNRESERVED | SUB_DELIMS | ":"){,1};
  IP_LITERAL      = "[" (IPv6_ADDR | IPv_FUTURE) "]";
  REG_NAME        = (UNRESERVED | PCT_ENC | SUB_DELIMS)*;
  HOST            = IP_LITERAL | IPv4_ADDR | REG_NAME;
  PORT            = digit*;
  AUTHORITY       = (USERINFO "@")? HOST (":" PORT)?;
  
# Path RFC 3986 Section 3.3
  PCHAR           = UNRESERVED | PCT_ENC | SUB_DELIMS | ":" | "@";
  SEG_NZ_NC       = (UNRESERVED | PCT_ENC | SUB_DELIMS | "@"){,1};
  SEG_NZ          = PCHAR{,1};
  SEGMENT         = PCHAR*;
  PATH_EMPTY      = '\0';
  PATH_ROOTLESS   = SEG_NZ ("/" SEGMENT)*;
  PATH_NOSCHEME   = SEG_NZ_NC ("/" SEGMENT)*;
  PATH_ABSOLUTE   = "/" (SEG_NZ ("/" SEGMENT)*)?;
  PATH_ABEMPTY    = ("/" SEGMENT)*;

  PATH            = PATH_ABEMPTY | # begins with "/" or is empty
                    PATH_ABSOLUTE | # begins with "/" but not "//"
                    PATH_NOSCHEME | # begins with a non-colon segment
                    PATH_ROOTLESS | # begins with a segment
                    PATH_EMPTY; # zero characters

# The query component contains non-hierarchical
# Section 3.4
  QUERY           = (PCHAR | "/" | "?")*;

# Fragment
# Section 3.5
  FRAGMENT        = (PCHAR | "/" | "?")*;

# Relative Reference
# Section 4.2
  REL_PART        = ("//" AUTHORITY PATH_ABEMPTY) |
                    PATH_ABSOLUTE |
                    PATH_NOSCHEME |
                    PATH_EMPTY ;

  REL_REF         = REL_PART ("?" QUERY)? ("#" FRAGMENT)?;

# Absolute URI
# Section 4.3
  HIER_PART       = ("//" AUTHORITY PATH_ABEMPTY) |
                    PATH_ABSOLUTE |
                    PATH_ROOTLESS |
                    PATH_EMPTY;

  URI_ABS         = SCHEME ":" HIER_PART ("?" QUERY)?;

# URI Reference
# Section 4.1; Section 3
  URI             = SCHEME ":" HIER_PART ("?" QUERY)? ("#" FRAGMENT)?;
  URI_REF         = URI | REL_REF;

}%%
