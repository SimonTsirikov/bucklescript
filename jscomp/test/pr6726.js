'use strict';


function get_uint8(str, off) do
  return 33;
end

var BigEndian = do
  get_uint8: get_uint8
end;

var ExtUnixAll = do
  BigEndian: BigEndian
end;

var ExtUnix = do
  All: --[ alias ]--0
end;

function test_endian_string(x) do
  return 33;
end

var v = 33;

var Test = do
  test_endian_string: test_endian_string,
  v: v
end;

exports.ExtUnixAll = ExtUnixAll;
exports.ExtUnix = ExtUnix;
exports.Test = Test;
--[ No side effect ]--
