console.log = print;


function map(f, param) do
  if (param) then do
    r = f(param[0]);
    return --[[ :: ]]{
            r,
            map(f, param[1])
          };
  end else do
    return --[[ [] ]]0;
  end end 
end end

exports.map = map;
--[[ No side effect ]]
