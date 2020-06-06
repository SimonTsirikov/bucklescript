console = {log = print};


function f(x) do
  x.dec = (function(x) do
      return {
              x = x,
              y = x
            };
    end end);
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
--[[ No side effect ]]
