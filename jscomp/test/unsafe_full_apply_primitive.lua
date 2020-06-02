console.log = print;


function f1(x) do
  return x(--[[ () ]]0);
end end

function f2(x, y) do
  return x(y, --[[ () ]]0);
end end

exports.f1 = f1;
exports.f2 = f2;
--[[ No side effect ]]
