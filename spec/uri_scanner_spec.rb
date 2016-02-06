require 'uri_scanner'

RSpec.describe URIScanner do
  describe "#is_ip_valid?" do
    it{expect(URIScanner.is_ip_valid?("172.31.1.222")).to be true}
    it{expect(URIScanner.is_ip_valid?("172.311.1.222")).to be false}
    it{expect(URIScanner.is_ip_valid?("::1")).to be true}
    it{expect(URIScanner.is_ip_valid?("2016:::1:1")).to be false}
    it{expect(URIScanner.is_ip_valid?("")).to be false}
  end

  describe "#parse_uri" do
    context "parsing 'ldap://[2001:db8::7]/c=GB?objectClass?one'" do
      let(:uri){ URIScanner.parse_uri "ldap://[2001:db8::7]/c=GB?objectClass?one"}
      it {expect(uri.scheme).to eq("ldap")}
      it {expect(uri.host).to eq("[2001:db8::7]")}
      it {expect(uri.port).to be_nil}
      it {expect(uri.path).to eq("/c=GB")}
      it {expect(uri.query).to eq("objectClass?one")}
    end
  end

  describe "#scan" do
    context "text and returns array of strings" do
      let(:data) {File.read "spec/url.txt" }
      let(:uris) {URIScanner.scan data}
      it{expect(uris.length).to be 15}
      it{uris.each{|u| expect(u).to be_a String}}
    end

    context "text and returns array of uri objects" do
      let(:data) {%Q{text before http://example.com:8042/index.php?name=ferret#nose text after
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam 
                  nec erat "foo://info.example.com?fred=homme#world" Proin sollicitudin <sip:12345@sip-provider.info:5060> }}
      let(:uri) {URIScanner.scan_and_parse(data)[1]}
      it{expect(uri.scheme).to eq("foo")}
      it{expect(uri.host).to eq("info.example.com")}
      it{expect(uri.port).to be_nil}
      it{expect(uri.query).to eq("fred=homme")}
      it{expect(uri.fragment).to eq("world")}
    end
  end
end
