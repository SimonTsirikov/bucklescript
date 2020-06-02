console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Hashtbl = require "../../lib/js/hashtbl";
Caml_primitive = require "../../lib/js/caml_primitive";

function f(H) do
  tbl = Curry._1(H.create, 17);
  Curry._3(H.add, tbl, 1, --[[ "1" ]]49);
  Curry._3(H.add, tbl, 2, --[[ "2" ]]50);
  return List.sort((function(param, param_1) do
                return Caml_primitive.caml_int_compare(param[0], param_1[0]);
              end end), Curry._3(H.fold, (function(k, v, acc) do
                    return --[[ :: ]]{
                            --[[ tuple ]]{
                              k,
                              v
                            },
                            acc
                          };
                  end end), tbl, --[[ [] ]]0));
end end

function g(H, count) do
  tbl = Curry._1(H.create, 17);
  for i = 0 , count , 1 do
    Curry._3(H.replace, tbl, (i << 1), String(i));
  end
  for i_1 = 0 , count , 1 do
    Curry._3(H.replace, tbl, (i_1 << 1), String(i_1));
  end
  v = Curry._3(H.fold, (function(k, v, acc) do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    k,
                    v
                  },
                  acc
                };
        end end), tbl, --[[ [] ]]0);
  return __Array.of_list(List.sort((function(param, param_1) do
                    return Caml_primitive.caml_int_compare(param[0], param_1[0]);
                  end end), v));
end end

hash = Hashtbl.hash;

function equal(x, y) do
  return x == y;
end end

Int_hash = Hashtbl.Make(do
      equal: equal,
      hash: hash
    end);

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
                f(Int_hash)
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
                  g(Int_hash, 1000)
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Int_hashtbl_test", suites);

exports = {}
exports.f = f;
exports.g = g;
exports.Int_hash = Int_hash;
exports.suites = suites;
--[[ Int_hash Not a pure module ]]