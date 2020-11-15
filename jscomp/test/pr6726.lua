__console = {log = print};


function get_uint8(str, off) do
  return 33;
end end

BigEndian = {
  get_uint8 = get_uint8
};

ExtUnixAll = {
  BigEndian = BigEndian
};

ExtUnix = {
  All = --[[ alias ]]0
};

function test_endian_string(x) do
  return 33;
end end

v = 33;

Test = {
  test_endian_string = test_endian_string,
  v = v
};

exports = {};
exports.ExtUnixAll = ExtUnixAll;
exports.ExtUnix = ExtUnix;
exports.Test = Test;
return exports;
--[[ No side effect ]]
