'use strict';


function u(rl) do
  return rl.on("line", (function (x) do
                  console.log(x);
                  return --[ () ]--0;
                end)).on("close", (function () do
                console.log("finished");
                return --[ () ]--0;
              end));
end

function xx(h) do
  return h.send("x").hi;
end

function yy(h) do
  return h.send("x");
end

exports.u = u;
exports.xx = xx;
exports.yy = yy;
--[ No side effect ]--
