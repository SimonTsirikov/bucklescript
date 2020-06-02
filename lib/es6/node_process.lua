

import * as Js_dict from "./js_dict.lua";
import * as Process from "process";

function putEnvVar(key, __var) do
  Process.env[key] = __var;
  return --[[ () ]]0;
end end

function deleteEnvVar(s) do
  return Js_dict.unsafeDeleteKey(Process.env, s);
end end

export do
  putEnvVar ,
  deleteEnvVar ,
  
end
--[[ process Not a pure module ]]
