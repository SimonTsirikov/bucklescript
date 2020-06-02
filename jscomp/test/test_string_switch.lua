console = {log = print};

Sys = require "../../lib/js/sys";

os_version;

local ___conditional___=(Sys.os_type);
do
   if ___conditional___ == "Cygwin" then do
      os_version = 2; end else 
   if ___conditional___ == "Unix" then do
      os_version = 1; end else 
   end end end end
  os_version = 3;
    
end

exports = {}
exports.os_version = os_version;
--[[ os_version Not a pure module ]]
