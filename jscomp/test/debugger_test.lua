__console = {log = print};


function f(x, y) do
  __console.log(--[[ tuple ]]{
        x,
        y
      });
  return x + y | 0;
end end

function g(param) do
  f(1, 2);
  debugger;
  f(1, 2);
  debugger;
  return 3;
end end

function exterme_g(param) do
  f(1, 2);
  debugger;
  v = --[[ () ]]0;
  __console.log(v);
  f(1, 2);
  debugger;
  return 3;
end end

exports = {};
exports.f = f;
exports.g = g;
exports.exterme_g = exterme_g;
return exports;
--[[ No side effect ]]
