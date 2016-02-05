require 'uri'
require 'uri_scanner'

RSpec.describe MachineURIScanner do
  describe "#scan" do
    it "returns single address" do
      data = "text before http://example.com:8042/index.php?name=ferret#nose text after"
      expect(MachineURIScanner.scan(data)).to eql(%w{http://example.com:8042/index.php?name=ferret#nose})
    end
  end
end

