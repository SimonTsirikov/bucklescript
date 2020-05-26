'use strict';

Js_dict = require("./js_dict.js");
Process = require("process");

function putEnvVar(key, $$var) do
  Process.env[key] = $$var;
  return --[ () ]--0;
end

function deleteEnvVar(s) do
  return Js_dict.unsafeDeleteKey(Process.env, s);
end

exports.putEnvVar = putEnvVar;
exports.deleteEnvVar = deleteEnvVar;
--[ process Not a pure module ]--
