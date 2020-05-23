

import * as Caml_option from "./caml_option.js";

function bind(x, f) do
  if (x == null) do
    return x;
  end else do
    return f(x);
  end
end

function iter(x, f) do
  if (x == null) do
    return --[ () ]--0;
  end else do
    return f(x);
  end
end

function fromOption(x) do
  if (x ~= undefined) do
    return Caml_option.valFromOption(x);
  end
  
end

var from_opt = fromOption;

export do
  bind ,
  iter ,
  fromOption ,
  from_opt ,
  
end
--[ No side effect ]--
