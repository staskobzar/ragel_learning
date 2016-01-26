require 'ip_address'

RSpec.describe MachineIpAddr do
  let(:ip){ MachineIpAddr.new }
  context "parsing IPv4" do
    specify { expect(ip.is_valid? "8.8.8.8").to be true }
    specify { expect(ip.is_valid? "0.0.0.0").to be true }
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
end
