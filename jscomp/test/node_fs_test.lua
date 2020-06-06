console = {log = print};

Fs = require "";

match = typeof __filename == "undefined" and nil or __filename;

if (match ~= nil) then do
  console.log(Fs.readFileSync(match, "utf8"));
end
 end 

exports = {}
--[[ match Not a pure module ]]
