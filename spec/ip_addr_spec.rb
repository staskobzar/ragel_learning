require 'uri_scanner/ip_address'

RSpec.describe MachineIpAddr do
  let(:ip){ MachineIpAddr.new }
  context "parsing IPv4" do
    specify { expect(ip.is_valid? "8.8.8.8").to be true }
    specify { expect(ip.is_valid? "0.0.0.0").to be true }
    specify { expect(ip.is_valid? "0.0.0.1").to be true }
    specify { expect(ip.is_valid? "10.0.0.1").to be true }
    specify { expect(ip.is_valid? "192.168.100.10").to be true }
    specify { expect(ip.is_valid? "172.31.1.34").to be true }
    specify { expect(ip.is_valid? "10.00.00.01").to be true }
    specify { expect(ip.is_valid? "010.000.000.001").to be true }

    specify { expect(ip.is_valid? "").to be false }
    specify { expect(ip.is_valid? "12.12.a.b").to be false }
    specify { expect(ip.is_valid? "1.2.3.4.5").to be false }
    specify { expect(ip.is_valid? "1.2.3.4.").to be false }
    specify { expect(ip.is_valid? "111.222.333.444").to be false }
    specify { expect(ip.is_valid? "256.222.33.44").to be false }
    specify { expect(ip.is_valid? "25.299.33.44").to be false }
    specify { expect(ip.is_valid? "25.99.333.44").to be false }
    specify { expect(ip.is_valid? "25.99.3.440").to be false }
  end

  # examples from RFC5952
  context "parsing IPv6" do
    specify { expect(ip.is_valid? "2001:db8:0:0:1:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:0db8:0:0:1:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:db8::1:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:db8::0:1:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:0db8::1:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:0:1::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0000:0:1::1").to be true }
    specify { expect(ip.is_valid? "2001:DB8:0:0:1::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:0001").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:001").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:01").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:1").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:0:0::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:0::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0::1").to be true }
    specify { expect(ip.is_valid? "2001:db8::1").to be true }
    specify { expect(ip.is_valid? "2001:db8::aaaa:0:0:1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:0:aaaa::1").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:AAAA").to be true }
    specify { expect(ip.is_valid? "2001:db8:aaaa:bbbb:cccc:dddd:eeee:AaAa").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:0:0:0:2:1").to be true }
    specify { expect(ip.is_valid? "2001:db8::2:1").to be true }
    specify { expect(ip.is_valid? "2001:db8:0:1:1:1:1:1").to be true }
    specify { expect(ip.is_valid? "::1").to be true }
    specify { expect(ip.is_valid? "0000:0000:0000:0000:0000:0000:0000:0001").to be true }

    specify { expect(ip.is_valid? "").to be false }
    specify { expect(ip.is_valid? "2001:db8::1:1:1:::1").to be false }
    specify { expect(ip.is_valid? "2016:::1:1").to be false }
    specify { expect(ip.is_valid? "ab::1:2::a").to be false }
    specify { expect(ip.is_valid? "qwe:1:2:3:4:5:6:7").to be false }
    specify { expect(ip.is_valid? "aa:bb:cc:dd:ff:11:22:33:44").to be false }
    specify { expect(ip.is_valid? "aa:bb:11:").to be false }
    specify { expect(ip.is_valid? ":1234:aaaa:22:bb:ff").to be false }
  end
end
