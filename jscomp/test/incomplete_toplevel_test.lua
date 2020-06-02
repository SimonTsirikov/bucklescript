console.log = print;


function f(param) do
  console.log("no inline");
  return --[[ tuple ]]{
          1,
          2,
          3
        };
end end

match = f(--[[ () ]]0);

a = match[0];

b = match[1];

c = match[2];

exports.f = f;
exports.a = a;
exports.b = b;
exports.c = c;
--[[ match Not a pure module ]]
