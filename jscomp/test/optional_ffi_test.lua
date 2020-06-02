console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_option = require "../../lib/js/caml_option";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
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

function hey(x, y) {
    if (x === void 0) { x = 3; }
    return x + y;
  }
;

u = hey(undefined, 3);

z = hey(5, 3);

eq("File \"optional_ffi_test.ml\", line 23, characters 5-12", --[[ tuple ]]{
      --[[ tuple ]]{
        u,
        z
      },
      --[[ tuple ]]{
        6,
        8
      }
    });

counter = do
  contents: 0
end;

function side_effect(x) do
  x.contents = x.contents + 1 | 0;
  return x.contents;
end end

function bug_to_fix(f, x) do
  return hey(f(x), 3);
end end

function bug_to_fix2(f, x) do
  return hey(Caml_option.option_get(f(x)), 3);
end end

counter2 = do
  contents: 0
end;

function side_effect2(x) do
  x.contents = x.contents + 1 | 0;
  return x.contents;
end end

v = bug_to_fix(side_effect, counter);

pair_000 = --[[ tuple ]]{
  v,
  counter.contents
};

pair_001 = --[[ tuple ]]{
  4,
  1
};

pair = --[[ tuple ]]{
  pair_000,
  pair_001
};

v2 = bug_to_fix2(side_effect2, counter2);

pair2_000 = --[[ tuple ]]{
  v2,
  counter.contents
};

pair2_001 = --[[ tuple ]]{
  4,
  1
};

pair2 = --[[ tuple ]]{
  pair2_000,
  pair2_001
};

eq("File \"optional_ffi_test.ml\", line 43, characters 5-12", pair);

eq("File \"optional_ffi_test.ml\", line 44, characters 5-12", pair2);

function heystr(x, y) {
    if (x === void 0) { x = "3"; }
    return x + y;
  }
;

pair_001_1 = heystr("name", "4");

pair_1 = --[[ tuple ]]{
  "name4",
  pair_001_1
};

eq("File \"optional_ffi_test.ml\", line 58, characters 5-12", pair_1);

Mt.from_pair_suites("Optional_ffi_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.u = u;
exports.z = z;
exports.counter = counter;
exports.side_effect = side_effect;
exports.bug_to_fix = bug_to_fix;
exports.bug_to_fix2 = bug_to_fix2;
exports.counter2 = counter2;
exports.side_effect2 = side_effect2;
--[[  Not a pure module ]]
