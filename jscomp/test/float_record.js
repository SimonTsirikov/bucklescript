'use strict';


function make(f) do
  return f;
end end

function from(t) do
  return t;
end end

exports.make = make;
exports.from = from;
--[[ No side effect ]]
