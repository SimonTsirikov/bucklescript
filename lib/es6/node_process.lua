

local Js_dict = require "..js_dict.lua";
local Process = require "process";

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
