console = {log = print};


function a(a0, a1, a2, a3, a4) do
  return (((((1 + a0 | 0) + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0) + 2 | 0;
end end

function b(a0, a1, a2, a3, a4) do
  return (((((1 + a0 | 0) + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0) + (((((1 + a0 | 0) + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0) | 0;
end end

exports = {}
exports.a = a;
exports.b = b;
--[[ No side effect ]]
