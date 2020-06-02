console.log = print;


function str_equal(x, y) do
  return x == y;
end end

str_b = true;

function int_equal(x, y) do
  return x == y;
end end

v = false;

exports.str_equal = str_equal;
exports.str_b = str_b;
exports.int_equal = int_equal;
exports.v = v;
--[[ str_b Not a pure module ]]
