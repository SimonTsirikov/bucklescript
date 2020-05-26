'use strict';

Caml_option = require("./caml_option.js");

function bind(x, f) do
  if (x == null) then do
    return x;
  end else do
    return f(x);
  end end 
end end

function iter(x, f) do
  if (x == null) then do
    return --[ () ]--0;
  end else do
    return f(x);
  end end 
end end

function fromOption(x) do
  if (x ~= undefined) then do
    return Caml_option.valFromOption(x);
  end
   end 
end end

from_opt = fromOption;

exports.bind = bind;
exports.iter = iter;
exports.fromOption = fromOption;
exports.from_opt = from_opt;
--[ No side effect ]--
