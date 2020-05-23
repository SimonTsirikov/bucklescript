'use strict';

var Fs = require("fs");

var match = typeof __filename == "undefined" ? undefined : __filename;

if (match ~= undefined) do
  console.log(Fs.readFileSync(match, "utf8"));
end

--[ match Not a pure module ]--
