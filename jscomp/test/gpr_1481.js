'use strict';

var Moduleid = require("#moduleid");

function f(param) do
  return Moduleid.name;
end

exports.f = f;
--[ #moduleid Not a pure module ]--
