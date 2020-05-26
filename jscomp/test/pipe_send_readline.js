'use strict';


function u(rl) do
  return rl.on("line", (function (x) do
                  console.log(x);
                  return --[[ () ]]0;
                end end)).on("close", (function () do
                console.log("finished");
                return --[[ () ]]0;
              end end));
end end

function xx(h) do
  return h.send("x").hi;
end end

function yy(h) do
  return h.send("x");
end end

exports.u = u;
exports.xx = xx;
exports.yy = yy;
--[[ No side effect ]]
