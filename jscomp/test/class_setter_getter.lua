__console = {log = print};


function fff(x) do
  x.height = 2;
  return --[[ () ]]0;
end end

function ff(x, z) do
  return --[[ :: ]]{
          x.height,
          --[[ :: ]]{
            z.height,
            --[[ [] ]]0
          }
        };
end end

exports = {};
exports.fff = fff;
exports.ff = ff;
return exports;
--[[ No side effect ]]
