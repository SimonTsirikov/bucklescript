__console = {log = print};

Fs = require "fs";

match = type(__filename) == "undefined" and nil or __filename;

if (match ~= nil) then do
  __console.log(Fs.readFileSync(match, "utf8"));
end
 end 

exports = {};
return exports;
--[[ match Not a pure module ]]
