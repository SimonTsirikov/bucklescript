__console = {log = print};


function register(rl) do
  return rl.on("line", (function(x) do
                  __console.log(x);
                  return --[[ () ]]0;
                end end)).on("close", (function(param) do
                __console.log("finished");
                return --[[ () ]]0;
              end end));
end end

exports = {};
exports.register = register;
return exports;
--[[ No side effect ]]
