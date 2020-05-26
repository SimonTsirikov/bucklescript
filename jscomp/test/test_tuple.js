'use strict';

Caml_int32 = require("../../lib/js/caml_int32.js");

r = 0;

for k = 1 , 10 , 1 do
  for i = 1 , 10 , 1 do
    match = i % 2 == 0 and --[ tuple ]--[
        1,
        (i << 1)
      ] or --[ tuple ]--[
        2,
        Caml_int32.imul(i, 3)
      ];
    r = Caml_int32.imul(r, match[0]) + match[1] | 0;
  end
end

--[  Not a pure module ]--
