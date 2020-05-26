'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Caml_obj = require("../../lib/js/caml_obj.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  console.log(--[ tuple ]--[
        x,
        y
      ]);
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end end

function f(x) do
  y = Caml_obj.caml_obj_dup(x);
  return do
          a0: 1,
          a1: y.a1,
          a2: y.a2,
          a3: y.a3,
          a4: y.a4,
          a5: y.a5
        end;
end end

eq("File \"update_record_test.ml\", line 30, characters 5-12", 1, f(do
          a0: 0,
          a1: 0,
          a2: 0,
          a3: 0,
          a4: 0,
          a5: 0
        end).a0);

val0 = do
  "invalid_js_id'": 3,
  x: 2
end;

function fff(x) do
  return do
          "invalid_js_id'": x["invalid_js_id'"] + 2 | 0,
          x: x.x
        end;
end end

val1 = fff(val0);

eq("File \"update_record_test.ml\", line 42, characters 5-12", 3, 3);

eq("File \"update_record_test.ml\", line 43, characters 5-12", val1["invalid_js_id'"], 5);

Mt.from_pair_suites("Update_record_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.val0 = val0;
exports.fff = fff;
exports.val1 = val1;
--[  Not a pure module ]--
