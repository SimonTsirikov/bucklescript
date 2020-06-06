console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Hashtbl = require "../../lib/js/hashtbl";
MoreLabels = require "../../lib/js/moreLabels";
Caml_primitive = require "../../lib/js/caml_primitive";

function to_list(tbl) do
  return Hashtbl.fold((function(k, v, acc) do
                return --[[ :: ]]{
                        --[[ tuple ]]{
                          k,
                          v
                        },
                        acc
                      };
              end end), tbl, --[[ [] ]]0);
end end

function f(param) do
  tbl = Hashtbl.create(nil, 17);
  Hashtbl.add(tbl, 1, --[[ "1" ]]49);
  Hashtbl.add(tbl, 2, --[[ "2" ]]50);
  return List.sort((function(param, param_1) do
                return Caml_primitive.caml_int_compare(param[0], param_1[0]);
              end end), to_list(tbl));
end end

function g(count) do
  tbl = Hashtbl.create(nil, 17);
  for i = 0 , count , 1 do
    Hashtbl.replace(tbl, (i << 1), String(i));
  end
  for i_1 = 0 , count , 1 do
    Hashtbl.replace(tbl, (i_1 << 1), String(i_1));
  end
  v = to_list(tbl);
  return __Array.of_list(List.sort((function(param, param_1) do
                    return Caml_primitive.caml_int_compare(param[0], param_1[0]);
                  end end), v));
end end

suites_000 = --[[ tuple ]]{
  "simple",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                --[[ :: ]]{
                  --[[ tuple ]]{
                    1,
                    --[[ "1" ]]49
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      2,
                      --[[ "2" ]]50
                    },
                    --[[ [] ]]0
                  }
                },
                f(--[[ () ]]0)
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "more_iterations",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  __Array.init(1001, (function(i) do
                          return --[[ tuple ]]{
                                  (i << 1),
                                  String(i)
                                };
                        end end)),
                  g(1000)
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "More_labels_regressionfix_374",
      (function(param) do
          tbl = Curry._2(MoreLabels.Hashtbl.create, nil, 30);
          Hashtbl.add(tbl, 3, 3);
          return --[[ Eq ]]Block.__(0, {
                    tbl.size,
                    1
                  });
        end end)
    },
    --[[ [] ]]0
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Hashtbl_test", suites);

exports = {}
exports.to_list = to_list;
exports.f = f;
exports.g = g;
exports.suites = suites;
--[[  Not a pure module ]]
