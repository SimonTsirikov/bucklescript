'use strict';

Obj = require("./obj.js");

function register(name, v) do
  return --[[ () ]]0;
end end

function register_exception(name, exn) do
  (exn.tag | 0) == Obj.object_tag and exn or exn[0];
  return --[[ () ]]0;
end end

exports.register = register;
exports.register_exception = register_exception;
--[[ No side effect ]]
