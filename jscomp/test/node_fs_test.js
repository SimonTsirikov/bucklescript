'use strict';

var Fs = require("fs");

var match = typeof __filename == "undefined" ? undefined : __filename;

if (match ~= undefined) then do
  console.log(Fs.readFileSync(match, "utf8"));
end
 end 

--[ match Not a pure module ]--
