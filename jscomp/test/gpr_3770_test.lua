__console = {log = print};


function show(param) do
  a = param[1];
  if (a == 0 and param[2] == 0 and param[3] == 0) then do
    return "zeroes";
  end
   end 
  return __String(a) .. __String(param[2]);
end end

exports = {};
exports.show = show;
return exports;
--[[ No side effect ]]
