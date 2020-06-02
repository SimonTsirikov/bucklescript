console = {log = print};

Sys = require "../../lib/js/sys";

match;

local ___conditional___=(Sys.os_type);
do
   if ___conditional___ == "Cygwin"
   or ___conditional___ == "Unix" then do
      match = --[[ tuple ]]{
        1,
        2
      }; end else 
   end end
  match = --[[ tuple ]]{
      3,
      4
    };
    
end

a = match[0];

b = match[1];

exports = {}
exports.a = a;
exports.b = b;
--[[ match Not a pure module ]]
