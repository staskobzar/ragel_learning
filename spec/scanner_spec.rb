require 'uri_scanner/uri_parser'
require 'uri_scanner/uri_scanner'

RSpec.describe MachineURIScanner do
  describe "#scan" do
    it "returns single address" do
      data = "text before http://example.com:8042/index.php?name=ferret#nose text after"
      expect(MachineURIScanner.scan(data)).to eql(%w{http://example.com:8042/index.php?name=ferret#nose})
    end
    it "returns three URIs" do
      data  = "Lorem ipsum dolor sit amet, consectetur "
      data += "adipiscing elit, \"ftp://ftp.is.co.za/rfc/rfc1808.txt\" sed "
      data += "do eiusmod tempor incididunt  <http://www.ietf.org/rfc/rfc2396.txt> "
      data += "ut labore et ldap://[2001:db8::7]/c=GB?objectClass?one dolore magna aliqua."
      expect(MachineURIScanner.scan(data).length).to be 3
      expect(MachineURIScanner.scan(data)).to eql(%w{
        ftp://ftp.is.co.za/rfc/rfc1808.txt
        http://www.ietf.org/rfc/rfc2396.txt
        ldap://[2001:db8::7]/c=GB?objectClass?one
      })
    end
    it "scans text from file" do
      f = File.open("spec/url.txt")
      expect(MachineURIScanner.scan(f.read).length).to be 15
    end

    context "to array of MachineURI instances" do
      let(:data) {%Q{text before http://example.com:8042/index.php?name=ferret#nose text after
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam 
                  nec erat "foo://info.example.com?fred" Proin sollicitudin <sip:12345@sip-provider.info:5060> }}
      let(:scanner) { MachineURIScanner.scan(data, true) }
      specify{expect(scanner.first.scheme).to eq("http")}
      specify{expect(scanner.first.port).to eq(8042)}
      specify{expect(scanner.last.host).to eq("sip-provider.info")}
      specify{expect(scanner[1].query).to eq("fred")}
    end

  end
end

