'use strict';


function show(param) do
  a = param[0];
  if (a == 0 and param[1] == 0 and param[2] == 0) then do
    return "zeroes";
  end
   end 
  return String(a) .. String(param[1]);
end end

exports.show = show;
--[ No side effect ]--
