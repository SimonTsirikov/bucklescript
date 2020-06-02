console = {log = print};


f = do
  "Content-Type": 3
end;

console.log(f["Content-Type"]);

function ff(x) do
  x.Hi;
  x["Content-Type"] = "hello";
  console.log((do
          "Content-Type": "hello"
        end)["Content-Type"]);
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
exports.ff = ff;
--[[  Not a pure module ]]
