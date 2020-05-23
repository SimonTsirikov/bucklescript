'use strict';


function test_v(x) do
  return x.hey(1, 2);
end

function test_vv(h) do
  var hey = h.hey;
  return hey(1, 2);
end

exports.test_v = test_v;
exports.test_vv = test_vv;
--[ No side effect ]--
