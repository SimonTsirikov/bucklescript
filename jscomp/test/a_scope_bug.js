'use strict';

Caml_int32 = require("../../lib/js/caml_int32.js");

function odd(_z) do
  while(true) do
    z = _z;
    even = Caml_int32.imul(z, z);
    a = (even + 4 | 0) + even | 0;
    console.log(String(a));
    _z = 32;
    continue ;
  end;
end end

even = odd;

exports.odd = odd;
exports.even = even;
--[[ No side effect ]]
