console = {log = print};


function register(rl) do
  return rl.on("line", (function(x) do
                  console.log(x);
                  return --[[ () ]]0;
                end end)).on("close", (function(param) do
                console.log("finished");
                return --[[ () ]]0;
              end end));
end end

exports = {}
exports.register = register;
--[[ No side effect ]]