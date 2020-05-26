'use strict';


function get_uint8(str, off) do
  return 33;
end end

BigEndian = do
  get_uint8: get_uint8
end;

ExtUnixAll = do
  BigEndian: BigEndian
end;

ExtUnix = do
  All: --[ alias ]--0
end;

function test_endian_string(x) do
  return 33;
end end

v = 33;

Test = do
  test_endian_string: test_endian_string,
  v: v
end;

exports.ExtUnixAll = ExtUnixAll;
exports.ExtUnix = ExtUnix;
exports.Test = Test;
--[ No side effect ]--
