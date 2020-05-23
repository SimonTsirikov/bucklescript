'use strict';


var v = 0;

v = v + 1 | 0;

console.log(String(v));

function unuse_v(param) do
  return 35;
end

var h = unuse_v;

exports.h = h;
--[  Not a pure module ]--
