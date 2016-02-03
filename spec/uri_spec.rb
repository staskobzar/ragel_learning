require 'uri'
require 'uri_parser'

RSpec.describe MachineURI do
  context "validate URI" do
    specify {
      expect(MachineURI.new("http://www.ietf.org/rfc/rfc2396.txt")
        .is_valid?).to be true}

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
        sip:12345@sip-provider.info:5060
        sips:johndoe@sip.secure.com
        tel:+1-816-555-1212
      }.each do |uri|
          expect( MachineURI.new(uri).is_valid? ).to be true
        end
    end
  end

  context "component parts parsing" do
    describe "#scheme" do
      it "should be 'foo'" do
        uri = MachineURI.new "foo://example.com:8042/over/there?name=ferret#nose"
        expect(uri.scheme).to eq("foo")
      end
      it "should be 'sip'" do
        uri = MachineURI.new "sip:username@example.com"
        expect(uri.scheme).to eq("sip")
      end
      it "raises error on invalid scheme" do
        expect {
          MachineURI.new "f~oo://google.com"
        }.to raise_error(URIParserError)
        expect {
          MachineURI.new "1http://google.com"
        }.to raise_error(URIParserError)
      end
    end
    describe "#host" do
      it "should be 'example.com'" do
        uri = MachineURI.new "foo://example.com:8042/over/there?name=ferret#nose"
        expect(uri.host).to eq("example.com")
      end
      #it "should be 'sip-provider.info'" do
        #uri = MachineURI.new "sip:12345@sip-provider.info:5060"
        #expect(uri.host).to eq("sip-provider.info")
      #end
      it "should be '[2001:db8::7]'" do
        uri = MachineURI.new "ldap://[2001:db8::7]/c=GB?objectClass?one"
        expect(uri.host).to eq("[2001:db8::7]")
      end
      it "should be '192.0.2.16'" do
        uri = MachineURI.new "telnet://192.0.2.16:80/"
        expect(uri.host).to eq("192.0.2.16")
      end
      it "should be nil" do
        uri = MachineURI.new "urn:example:animal:ferret:nose"
        expect(uri.host).to be_nil
      end
    end
    describe "#userinfo" do
      it "should be 'john'" do
        uri = MachineURI.new "foo://john@example.com:8042/over/there?name=ferret#nose"
        expect(uri.userinfo).to eq("john")
      end
      it "should be nil" do
        uri = MachineURI.new "ldap://[2001:db8::7]/c=GB?objectClass?one"
        expect(uri.userinfo).to be_nil
      end
      #it "should be '12345'" do
      #  uri = MachineURI.new "sip:12345@sip-provider.info:5060"
      #  expect(uri.userinfo).to eq("12345")
      #end
    end
    describe "#port" do
      it "should be 8042" do
        uri = MachineURI.new "foo://john@example.com:8042/over/there?name=ferret#nose"
        expect(uri.port).to eq(8042)
      end
      it "should be nil" do
        uri = MachineURI.new "http://www.ietf.org/rfc/rfc2396.txt"
        expect(uri.port).to be_nil
      end
    end
    describe "#query" do
      it "should be 'name=ferret'" do
        uri = MachineURI.new "foo://john@example.com:8042/over/there?name=ferret#nose"
        expect(uri.query).to eq("name=ferret")
      end
      it "should be nil" do
        uri = MachineURI.new "http://www.ietf.org/rfc/rfc2396.txt"
        expect(uri.query).to be_nil
      end
    end
    describe "#fragment" do
      it "should be 'nose'" do
        uri = MachineURI.new "foo://john@example.com:8042/over/there?name=ferret#nose"
        expect(uri.fragment).to eq("nose")
      end
      it "should be nil" do
        uri = MachineURI.new "http://www.ietf.org/rfc/rfc2396.txt?user=john"
        expect(uri.fragment).to be_nil
      end
      it "should be 'section%205.2'" do
        uri = MachineURI.new "http://www.ietf.org/rfc/rfc2396.txt#section%205.2"
        expect(uri.fragment).to eq("section%205.2")
      end
    end

    it "should be parse" do
      uri = MachineURI.new "foo://john@example.com:8042/over/there?name=ferret#nose"
      expect(uri.scheme).to eq("foo")
      expect(uri.userinfo).to eq("john")
      expect(uri.host).to eq("example.com")
      expect(uri.port).to eq(8042)
      expect(uri.query).to eq("name=ferret")
      expect(uri.fragment).to eq("nose")
    end
  end
end

