console = {log = print};

Caml_option = require "../../lib/js/caml_option";

v = do
  "Content-Type": 3,
  l: 2,
  open: 2
end;

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
  tmp = do
    hi: 2
  end;
  if (partial_arg ~= undefined) then do
    tmp["lo-x"] = Caml_option.valFromOption(partial_arg);
  end
   end 
  return tmp;
end end

h1 = do
  "lo-x": "x",
  hi: 2
end;

h2 = do
  hi: 2
end;

function hh(x) do
  x["lo-x"] = "3";
  return Caml_option.undefined_to_opt(x["lo-x"]);
end end

function hh2(x) do
  match = x["lo-x"];
  if (match ~= undefined) then do
    return 1;
  end else do
    return 0;
  end end 
end end

u = do
  "xx-yy": 3
end;

match = u["xx-yy"];

v_1 = match ~= undefined and match or 0;

exports = {}
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
--[[  Not a pure module ]]
