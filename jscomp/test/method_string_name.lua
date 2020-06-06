console = {log = print};


f = {
  "Content-Type" = 3
};

console.log(f["Content-Type"]);

function ff(x) do
  x.Hi;
  x["Content-Type"] = "hello";
  console.log(({
          "Content-Type" = "hello"
        })["Content-Type"]);
  return --[[ () ]]0;
end end

exports = {}
exports.f = f;
exports.ff = ff;
--[[  Not a pure module ]]
