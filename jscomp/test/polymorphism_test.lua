__console = {log = print};


function map(f, param) do
  if (param) then do
    r = f(param[1]);
    return --[[ :: ]]{
            r,
            map(f, param[2])
          };
  end else do
    return --[[ [] ]]0;
  end end 
end end

exports = {};
exports.map = map;
return exports;
--[[ No side effect ]]
