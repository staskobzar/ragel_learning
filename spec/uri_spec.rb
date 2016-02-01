require 'uri'
require 'uri_parser'

RSpec.describe MachineURI do
  context "validate URI" do
    specify {
      expect(MachineURI.new("http://www.ietf.org/rfc/rfc2396.txt")
        .is_valid?).to be true}
    specify {
      expect(MachineURI.new("test false.txt")
        .is_valid?).to be false }

    it "testing multiple samples with authority part" do
      %W{
        http://localhost/
        ftp://ftp.is.co.za/rfc/rfc1808.txt
        http://www.ietf.org/rfc/rfc2396.txt
        ldap://[2001:db8::7]/c=GB?objectClass?one
        telnet://192.0.2.16:80/
        example://a/b/c/%7Bfoo%7D
        eXAMPLE://a/./b/../b/%63/%7bfoo%7d
        foo://example.com:8042/over/there?name=ferret#nose
        foo://info.example.com?fred
      }.each do |uri|
          expect( MachineURI.new(uri).is_valid? ).to be true
        end
    end
    it "testing multiple samples without authority part" do
      %W{
        urn:oasis:names:specification:docbook:dtd:xml:4.1.2
        urn:example:animal:ferret:nose
        mailto:John.Doe@example.com
        news:comp.infosystems.www.servers.unix
        tel:+1-816-555-1212
      }.each do |uri|
          expect( MachineURI.new(uri).is_valid? ).to be true
        end
    end
  end
end

