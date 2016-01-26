
# line 1 "lib/ip_address.rl"
#
# @LANG: ruby
# Parsing IP address (IPv4/IPv6) 
# 


# line 11 "lib/ip_address.rl"


# Ruby Class goes here
class MachineIpAddr

  def initialize(ip)
    @ip = ip
    
# line 19 "lib/ip_address.rb"
class << self
	attr_accessor :_m_ipaddr_key_offsets
	private :_m_ipaddr_key_offsets, :_m_ipaddr_key_offsets=
end
self._m_ipaddr_key_offsets = [
	0, 0, 2, 5, 7, 10, 12, 15, 
	17, 20, 21, 24, 25, 28, 29, 31, 
	33
]

class << self
	attr_accessor :_m_ipaddr_trans_keys
	private :_m_ipaddr_trans_keys, :_m_ipaddr_trans_keys=
end
self._m_ipaddr_trans_keys = [
	48, 57, 46, 48, 57, 48, 57, 46, 
	48, 57, 48, 57, 46, 48, 57, 48, 
	57, 46, 48, 57, 46, 46, 48, 57, 
	46, 46, 48, 57, 46, 48, 57, 48, 
	57, 0
]

class << self
	attr_accessor :_m_ipaddr_single_lengths
	private :_m_ipaddr_single_lengths, :_m_ipaddr_single_lengths=
end
self._m_ipaddr_single_lengths = [
	0, 0, 1, 0, 1, 0, 1, 0, 
	1, 1, 1, 1, 1, 1, 0, 0, 
	0
]

class << self
	attr_accessor :_m_ipaddr_range_lengths
	private :_m_ipaddr_range_lengths, :_m_ipaddr_range_lengths=
end
self._m_ipaddr_range_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 0, 1, 0, 1, 0, 1, 1, 
	0
]

class << self
	attr_accessor :_m_ipaddr_index_offsets
	private :_m_ipaddr_index_offsets, :_m_ipaddr_index_offsets=
end
self._m_ipaddr_index_offsets = [
	0, 0, 2, 5, 7, 10, 12, 15, 
	17, 20, 22, 25, 27, 30, 32, 34, 
	36
]

class << self
	attr_accessor :_m_ipaddr_trans_targs
	private :_m_ipaddr_trans_targs, :_m_ipaddr_trans_targs=
end
self._m_ipaddr_trans_targs = [
	2, 0, 3, 12, 0, 4, 0, 5, 
	10, 0, 6, 0, 7, 8, 0, 14, 
	0, 7, 9, 0, 7, 0, 5, 11, 
	0, 5, 0, 3, 13, 0, 3, 0, 
	15, 0, 16, 0, 0, 0
]

class << self
	attr_accessor :m_ipaddr_start
end
self.m_ipaddr_start = 1;
class << self
	attr_accessor :m_ipaddr_first_final
end
self.m_ipaddr_first_final = 14;
class << self
	attr_accessor :m_ipaddr_error
end
self.m_ipaddr_error = 0;

class << self
	attr_accessor :m_ipaddr_en_main
end
self.m_ipaddr_en_main = 1;


# line 19 "lib/ip_address.rl"
  end

  def is_valid?
    data = @ip
    
# line 109 "lib/ip_address.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = m_ipaddr_start
end

# line 24 "lib/ip_address.rl"
    
# line 118 "lib/ip_address.rb"
begin
	_klen, _trans, _keys = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _m_ipaddr_key_offsets[cs]
	_trans = _m_ipaddr_index_offsets[cs]
	_klen = _m_ipaddr_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _m_ipaddr_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _m_ipaddr_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _m_ipaddr_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _m_ipaddr_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _m_ipaddr_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	cs = _m_ipaddr_trans_targs[_trans]
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 25 "lib/ip_address.rl"
    cs >= m_ipaddr_first_final
  end
end

# EOF
