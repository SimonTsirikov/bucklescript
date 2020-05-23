'use strict';


function register(rl) do
  return rl.on("line", (function (x) do
                  console.log(x);
                  return --[ () ]--0;
                end)).on("close", (function (param) do
                console.log("finished");
                return --[ () ]--0;
              end));
end

exports.register = register;
--[ No side effect ]--
