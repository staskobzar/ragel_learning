# LANG@ ruby

%%{
  machine scanner;

  integer = digit +;
  main := |*
    any;
    integer => {puts data[ts..te-1]} ;
    any;
  *|;
}%%

%% write data;
def run(data)
  eof = data.length
  %% write init;
  %% write exec;
end

run("11abc22-33qwerty 44 001")
=begin
OUTPUT:
11
22
33
44
001
=end
