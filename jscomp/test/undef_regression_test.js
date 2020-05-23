'use strict';


function f(obj) do
  if (typeof obj == "function") do
    return --[ () ]--0;
  end else do
    var size = obj.length;
    if (size ~= undefined) do
      console.log(size);
      return --[ () ]--0;
    end else do
      return --[ () ]--0;
    end
  end
end

exports.f = f;
--[ No side effect ]--
