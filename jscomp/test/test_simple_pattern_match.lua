console.log = print;

Sys = require "../../lib/js/sys";

match;

local ___conditional___=(Sys.os_type);
do
   if ___conditional___ = "Cygwin"
   or ___conditional___ = "Unix" then do
      match = --[[ tuple ]]{
        1,
        2
      };end else 
   do end end
  else do
    match = --[[ tuple ]]{
      3,
      4
    };
    end end
    
end

a = match[0];

b = match[1];

exports.a = a;
exports.b = b;
--[[ match Not a pure module ]]
