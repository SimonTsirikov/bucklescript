'use strict';


function show(param) do
  var a = param[0];
  if (a == 0 and param[1] == 0 and param[2] == 0) do
    return "zeroes";
  end
  return String(a) .. String(param[1]);
end

exports.show = show;
--[ No side effect ]--
