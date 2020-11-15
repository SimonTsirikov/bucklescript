__console = {log = print};

Caml_string = require "......lib.js.caml_string";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

hh;

xpcall(function() do
  hh = Caml_string.get("ghsogh", -3);
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[1] == Caml_builtin_exceptions.invalid_argument) then do
    __console.log(exn[2]);
    hh = --[[ "a" ]]97;
  end else do
    error(exn)
  end end 
end end)

f = --[[ "o" ]]111;

exports = {};
exports.f = f;
exports.hh = hh;
return exports;
--[[ hh Not a pure module ]]
