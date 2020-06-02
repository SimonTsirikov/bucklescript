console = {log = print};


function test(x, y) do
  return --[[ tuple ]]{
          x < y,
          x <= y,
          x > y,
          x >= y,
          x == y,
          x ~= y
        };
end end

function f(x, y) do
  return --[[ tuple ]]{
          String.fromCharCode.apply(nil, x),
          0
        };
end end

exports = {}
exports.test = test;
exports.f = f;
--[[ No side effect ]]
