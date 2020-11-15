__console = {log = print};

Obj = require "..obj";

function register(name, v) do
  return --[[ () ]]0;
end end

function register_exception(name, exn) do
  (exn.tag | 0) == Obj.object_tag and exn or exn[0];
  return --[[ () ]]0;
end end

exports = {};
exports.register = register;
exports.register_exception = register_exception;
return exports;
--[[ No side effect ]]
