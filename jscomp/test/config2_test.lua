__console = {log = print};


function test_v(x) do
  return x.hey(1, 2);
end end

function test_vv(h) do
  hey = h.hey;
  return hey(1, 2);
end end

exports = {};
exports.test_v = test_v;
exports.test_vv = test_vv;
return exports;
--[[ No side effect ]]
