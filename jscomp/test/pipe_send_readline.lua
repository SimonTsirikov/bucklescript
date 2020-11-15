__console = {log = print};


function u(rl) do
  return rl.on("line", (function(x) do
                  __console.log(x);
                  return --[[ () ]]0;
                end end)).on("close", (function() do
                __console.log("finished");
                return --[[ () ]]0;
              end end));
end end

function xx(h) do
  return h.send("x").hi;
end end

function yy(h) do
  return h.send("x");
end end

exports = {};
exports.u = u;
exports.xx = xx;
exports.yy = yy;
return exports;
--[[ No side effect ]]
