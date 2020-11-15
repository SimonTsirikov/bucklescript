__console = {log = print};


f = {
  "Content-Type" = 3
};

__console.log(f["Content-Type"]);

function ff(x) do
  x.Hi;
  x["Content-Type"] = "hello";
  __console.log(({
          "Content-Type" = "hello"
        })["Content-Type"]);
  return --[[ () ]]0;
end end

exports = {};
exports.f = f;
exports.ff = ff;
return exports;
--[[  Not a pure module ]]
