__console = {log = print};

Curry = require "......lib.js.curry";
Caml_exceptions = require "......lib.js.caml_exceptions";

x = {
  contents = 1
};

y = {
  contents = 2
};

function f(param) do
  a = {
    contents = param[1]
  };
  b = {
    contents = param[2]
  };
  __console.log(a, b);
  return --[[ () ]]0;
end end

function g(param) do
  return 3;
end end

function a0(f) do
  u = Curry._1(f, --[[ () ]]0);
  if (u ~= nil) then do
    __console.log(u);
    __console.log(u);
    return 1;
  end else do
    return 0;
  end end 
end end

function a1(f) do
  E = Caml_exceptions.create("E");
  xpcall(function() do
    return Curry._1(f, --[[ () ]]0);
  end end,function(exn) do
    if (exn == E) then do
      return 1;
    end else do
      error(exn)
    end end 
  end end)
end end

a = 1;

b = 2;

exports = {};
exports.a = a;
exports.b = b;
exports.x = x;
exports.y = y;
exports.f = f;
exports.g = g;
exports.a0 = a0;
exports.a1 = a1;
return exports;
--[[ No side effect ]]
