__console = {log = print};

Caml_option = require "......lib.js.caml_option";

v = {
  "Content-Type" = 3,
  l = 2,
  open = 2
};

v["Content-Type"];

b = v.l;

c = v.open;

function ff(param) do
  v["Content-Type"] = 3;
  v.l = 2;
  return --[[ () ]]0;
end end

partial_arg = "x";

function h0(param) do
  tmp = {
    hi = 2
  };
  if (partial_arg ~= nil) then do
    tmp["lo-x"] = Caml_option.valFromOption(partial_arg);
  end
   end 
  return tmp;
end end

h1 = {
  "lo-x" = "x",
  hi = 2
};

h2 = {
  hi = 2
};

function hh(x) do
  x["lo-x"] = "3";
  return Caml_option.undefined_to_opt(x["lo-x"]);
end end

function hh2(x) do
  match = x["lo-x"];
  if (match ~= nil) then do
    return 1;
  end else do
    return 0;
  end end 
end end

u = {
  "xx-yy" = 3
};

match = u["xx-yy"];

v_1 = match ~= nil and match or 0;

exports = {};
exports.b = b;
exports.c = c;
exports.ff = ff;
exports.h0 = h0;
exports.h1 = h1;
exports.h2 = h2;
exports.hh = hh;
exports.hh2 = hh2;
exports.u = u;
exports.v = v_1;
return exports;
--[[  Not a pure module ]]
