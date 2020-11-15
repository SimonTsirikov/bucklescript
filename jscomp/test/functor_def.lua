__console = {log = print};

Curry = require "......lib.js.curry";

v = {
  contents = 0
};

function f(x, x_1) do
  v.contents = v.contents + 1 | 0;
  return x_1 + x_1 | 0;
end end

function __return(param) do
  return v.contents;
end end

function Make(U) do
  h = function(x, x_1) do
    __console.log(f(x_1, x_1));
    return Curry._2(U.say, x_1, x_1);
  end end;
  return {
          h = h
        };
end end

exports = {};
exports.v = v;
exports.f = f;
exports.__return = __return;
exports.Make = Make;
return exports;
--[[ No side effect ]]
