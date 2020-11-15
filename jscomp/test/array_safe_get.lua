__console = {log = print};

Caml_array = require "......lib.js.caml_array";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

x = {
  1,
  2
};

y;

xpcall(function() do
  y = Caml_array.caml_array_get(x, 3);
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[1] == Caml_builtin_exceptions.invalid_argument) then do
    __console.log(exn[2]);
    y = 0;
  end else do
    error(exn)
  end end 
end end)

exports = {};
exports.x = x;
exports.y = y;
return exports;
--[[ y Not a pure module ]]
