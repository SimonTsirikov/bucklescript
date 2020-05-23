'use strict';


function make(f) do
  return f;
end

function from(t) do
  return t;
end

exports.make = make;
exports.from = from;
--[ No side effect ]--
