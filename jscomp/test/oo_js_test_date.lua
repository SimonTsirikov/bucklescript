--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";

d = new Date(2016, 2);

function d2(param) do
  return (function (param_1, param_2) do
      prim = param;
      prim_1 = 2;
      prim_2 = param_1;
      return new Date(prim, prim_1, prim_2);
    end end);
end end

d3 = d2(2016)(1, --[[ () ]]0);

suites_000 = --[[ tuple ]]{
  "getMonth",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                2,
                d.getMonth()
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "getYear",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  --[[ tuple ]]{
                    2016,
                    2,
                    1
                  },
                  --[[ tuple ]]{
                    d3.getFullYear(),
                    d3.getMonth(),
                    d3.getDate()
                  }
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Oo_js_test_date", suites);

exports.d = d;
exports.d2 = d2;
exports.d3 = d3;
exports.suites = suites;
--[[ d Not a pure module ]]
