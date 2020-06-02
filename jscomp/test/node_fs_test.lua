console = {log = print};

Fs = require "";

match = typeof __filename == "undefined" and undefined or __filename;

if (match ~= undefined) then do
  console.log(Fs.readFileSync(match, "utf8"));
end
 end 

exports = {}
--[[ match Not a pure module ]]
