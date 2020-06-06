console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_obj = require "../../lib/js/caml_obj";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  console.log(--[[ tuple ]]{
        x,
        y
      });
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

function f(x) do
  y = Caml_obj.caml_obj_dup(x);
  return {
          a0 = 1,
          a1 = y.a1,
          a2 = y.a2,
          a3 = y.a3,
          a4 = y.a4,
          a5 = y.a5
        };
end end

eq("File \"update_record_test.ml\", line 30, characters 5-12", 1, f({
          a0 = 0,
          a1 = 0,
          a2 = 0,
          a3 = 0,
          a4 = 0,
          a5 = 0
        }).a0);

val0 = {
  "invalid_js_id'" = 3,
  x = 2
};

function fff(x) do
  return {
          "invalid_js_id'" = x["invalid_js_id'"] + 2 | 0,
          x = x.x
        };
end end

val1 = fff(val0);

eq("File \"update_record_test.ml\", line 42, characters 5-12", 3, 3);

eq("File \"update_record_test.ml\", line 43, characters 5-12", val1["invalid_js_id'"], 5);

Mt.from_pair_suites("Update_record_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.val0 = val0;
exports.fff = fff;
exports.val1 = val1;
--[[  Not a pure module ]]
