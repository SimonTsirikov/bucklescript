console = {log = print};


function x(prim, prim_1) do
  return prim % prim_1;
end end

exports = {}
exports.x = x;
--[[ No side effect ]]
