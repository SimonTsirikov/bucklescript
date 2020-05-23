'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");

function u(param) do
  var n;
  try do
    n = 3;
  end
  catch (exn)do
    return 42;
  end
  return Caml_int32.div(3, 0);
end

Mt.from_pair_suites("Jsoo_400_test", --[ :: ]--[
      --[ tuple ]--[
        "File \"jsoo_400_test.ml\", line 8, characters 3-10",
        (function (param) do
            return --[ ThrowAny ]--Block.__(7, [(function (param) do
                          u(--[ () ]--0);
                          return --[ () ]--0;
                        end)]);
          end)
      ],
      --[ [] ]--0
    ]);

exports.u = u;
--[  Not a pure module ]--
