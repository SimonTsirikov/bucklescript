__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Caml_int32 = require "......lib.js.caml_int32";
Caml_module = require "......lib.js.caml_module";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function add(suite) do
  suites.contents = --[[ :: ]]{
    suite,
    suites.contents
  };
  return --[[ () ]]0;
end end

Int3 = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module_test.ml",
      13,
      6
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "u"
          }}}));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "u"
          }}}), Int3, Int3);

M = Caml_module.init_mod(--[[ tuple ]]{
      "recursive_module_test.ml",
      20,
      20
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "fact"
          }}}));

function fact(n) do
  if (n <= 1) then do
    return 1;
  end else do
    return Caml_int32.imul(n, Curry._1(M.fact, n - 1 | 0));
  end end 
end end

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Function ]]0,
            "fact"
          }}}), M, {
      fact = fact
    });

fact_1 = M.fact;

Fact = {
  M = M,
  fact = fact_1
};

eq("File \"recursive_module_test.ml\", line 30, characters 5-12", 120, Curry._1(fact_1, 5));

add(--[[ tuple ]]{
      "File \"recursive_module_test.ml\", line 34, characters 7-14",
      (function(param) do
          return --[[ ThrowAny ]]Block.__(7, {(function(param) do
                        Curry._1(Int3.u, 3);
                        return --[[ () ]]0;
                      end end)});
        end end)
    });

Mt.from_pair_suites("Recursive_module_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.add = add;
exports.Int3 = Int3;
exports.Fact = Fact;
return exports;
--[[ Int3 Not a pure module ]]
