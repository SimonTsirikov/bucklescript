console = {log = print};

Mt = require "./mt";
Caml_obj = require "../../lib/js/caml_obj";
Belt_List = require "../../lib/js/belt_List";
Caml_option = require "../../lib/js/caml_option";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, v) do
  return Mt.bool_suites(test_id, suites, loc, v);
end end

function f0(x) do
  match = x[1];
  if (match ~= undefined and match) then do
    return 1;
  end else do
    return 2;
  end end 
end end

function f1(u) do
  if (u) then do
    return 0;
  end else do
    return 1;
  end end 
end end

function f2(x, y, zOpt, param) do
  z = zOpt ~= undefined and zOpt or 3;
  console.log(x);
  if (y ~= undefined) then do
    return y + z | 0;
  end else do
    return 0;
  end end 
end end

function f3(x) do
  if (x ~= undefined) then do
    return 1;
  end else do
    return 0;
  end end 
end end

function f4(x) do
  if (x ~= undefined) then do
    return x + 1 | 0;
  end else do
    return 0;
  end end 
end end

function f5(a) do
  return false;
end end

function f6(a) do
  return true;
end end

f10 = Caml_option.some(Caml_option.some(Caml_option.some(Caml_option.some(undefined))));

f11 = Caml_option.some(f10);

randomized = do
  contents: false
end;

function create(randomOpt, param) do
  random = randomOpt ~= undefined and randomOpt or randomized.contents;
  if (random) then do
    return 2;
  end else do
    return 1;
  end end 
end end

ff = create(false, --[[ () ]]0);

function f13(xOpt, yOpt, param) do
  x = xOpt ~= undefined and xOpt or 3;
  y = yOpt ~= undefined and yOpt or 4;
  return x + y | 0;
end end

a = f13(2, undefined, --[[ () ]]0);

function f12(x) do
  return x;
end end

length_8_id = Belt_List.makeBy(8, (function(x) do
        return x;
      end end));

length_10_id = Belt_List.makeBy(10, (function(x) do
        return x;
      end end));

function f13_1(param) do
  return Caml_obj.caml_equal(Belt_List.take(length_10_id, 8), --[[ :: ]]{
              1,
              --[[ :: ]]{
                2,
                --[[ :: ]]{
                  3,
                  --[[ [] ]]0
                }
              }
            });
end end

b("File \"option_repr_test.ml\", line 94, characters 4-11", Caml_obj.caml_lessthan(undefined, nil));

b("File \"option_repr_test.ml\", line 95, characters 4-11", not Caml_obj.caml_greaterthan(undefined, nil));

b("File \"option_repr_test.ml\", line 96, characters 4-11", Caml_obj.caml_greaterthan(nil, undefined));

b("File \"option_repr_test.ml\", line 97, characters 4-11", Caml_obj.caml_lessthan(undefined, Caml_option.some(undefined)));

b("File \"option_repr_test.ml\", line 98, characters 4-11", Caml_obj.caml_greaterthan(Caml_option.some(undefined), undefined));

console.log(6, undefined);

function ltx(a, b) do
  if (Caml_obj.caml_lessthan(a, b)) then do
    return Caml_obj.caml_greaterthan(b, a);
  end else do
    return false;
  end end 
end end

function gtx(a, b) do
  if (Caml_obj.caml_greaterthan(a, b)) then do
    return Caml_obj.caml_lessthan(b, a);
  end else do
    return false;
  end end 
end end

function eqx(a, b) do
  if (Caml_obj.caml_equal(a, b)) then do
    return Caml_obj.caml_equal(b, a);
  end else do
    return false;
  end end 
end end

function neqx(a, b) do
  if (Caml_obj.caml_notequal(a, b)) then do
    return Caml_obj.caml_notequal(b, a);
  end else do
    return false;
  end end 
end end

function all_true(xs) do
  return Belt_List.every(xs, (function(x) do
                return x;
              end end));
end end

xs_000 = gtx(Caml_option.some(nil), Caml_option.some(undefined));

xs = --[[ :: ]]{
  xs_000,
  --[[ [] ]]0
};

b("File \"option_repr_test.ml\", line 121, characters 5-12", Belt_List.every(xs, (function(x) do
            return x;
          end end)));

xs_000_1 = ltx(Caml_option.some(undefined), 3);

xs_001 = --[[ :: ]]{
  ltx(Caml_option.some(undefined), Caml_option.some(Caml_option.some(undefined))),
  --[[ :: ]]{
    ltx(Caml_option.some(undefined), "3"),
    --[[ :: ]]{
      ltx(Caml_option.some(undefined), true),
      --[[ :: ]]{
        ltx(Caml_option.some(undefined), false),
        --[[ :: ]]{
          ltx(false, true),
          --[[ :: ]]{
            ltx(false, true),
            --[[ :: ]]{
              ltx(undefined, Caml_option.some(undefined)),
              --[[ :: ]]{
                ltx(undefined, nil),
                --[[ :: ]]{
                  ltx(undefined, (function(x) do
                          return x;
                        end end)),
                  --[[ :: ]]{
                    ltx(nil, 3),
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};

xs_1 = --[[ :: ]]{
  xs_000_1,
  xs_001
};

b("File \"option_repr_test.ml\", line 127, characters 5-12", Belt_List.every(xs_1, (function(x) do
            return x;
          end end)));

xs_000_2 = eqx(undefined, undefined);

xs_001_1 = --[[ :: ]]{
  neqx(undefined, nil),
  --[[ :: ]]{
    eqx(Caml_option.some(undefined), Caml_option.some(undefined)),
    --[[ :: ]]{
      eqx(Caml_option.some(Caml_option.some(undefined)), Caml_option.some(Caml_option.some(undefined))),
      --[[ :: ]]{
        neqx(Caml_option.some(Caml_option.some(Caml_option.some(undefined))), Caml_option.some(Caml_option.some(undefined))),
        --[[ [] ]]0
      }
    }
  }
};

xs_2 = --[[ :: ]]{
  xs_000_2,
  xs_001_1
};

b("File \"option_repr_test.ml\", line 143, characters 5-12", Belt_List.every(xs_2, (function(x) do
            return x;
          end end)));

function v(x) do
  return x;
end end

function v0(x) do
  return x;
end end

N0 = do
  v: v,
  v0: v0
end;

Mt.from_pair_suites("Option_repr_test", suites.contents);

f7 = undefined;

f8 = Caml_option.some(undefined);

f9 = Caml_option.some(Caml_option.some(undefined));

N = --[[ alias ]]0;

none_arg = undefined;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.f0 = f0;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
exports.f9 = f9;
exports.f10 = f10;
exports.f11 = f11;
exports.randomized = randomized;
exports.create = create;
exports.ff = ff;
exports.a = a;
exports.f12 = f12;
exports.N = N;
exports.length_8_id = length_8_id;
exports.length_10_id = length_10_id;
exports.f13 = f13_1;
exports.none_arg = none_arg;
exports.ltx = ltx;
exports.gtx = gtx;
exports.eqx = eqx;
exports.neqx = neqx;
exports.all_true = all_true;
exports.N0 = N0;
--[[ ff Not a pure module ]]