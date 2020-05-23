

import * as Js_dict from "./js_dict.js";
import * as Process from "process";

function putEnvVar(key, $$var) do
  Process.env[key] = $$var;
  return --[ () ]--0;
end

function deleteEnvVar(s) do
  return Js_dict.unsafeDeleteKey(Process.env, s);
end

export do
  putEnvVar ,
  deleteEnvVar ,
  
end
--[ process Not a pure module ]--
