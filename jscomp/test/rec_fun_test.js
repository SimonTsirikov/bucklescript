'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

called = do
  contents: 0
end;

function g(param) do
  v = { };
  next = function (i, b) do
    called.contents = called.contents + 1 | 0;
    if (b) then do
      Curry._2(v.contents, i, false);
    end
     end 
    return i + 1 | 0;
  end;
  Caml_obj.caml_update_dummy(v, do
        contents: next
      end);
  console.log(String(next(0, true)));
  return --[ () ]--0;
end

g(--[ () ]--0);

x = [];

y = [];

Caml_obj.caml_update_dummy(x, --[ :: ]--[
      1,
      y
    ]);

Caml_obj.caml_update_dummy(y, --[ :: ]--[
      2,
      x
    ]);

eq("File \"rec_fun_test.ml\", line 27, characters 6-13", called.contents, 2);

Mt.from_pair_suites("Rec_fun_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.called = called;
exports.g = g;
exports.x = x;
exports.y = y;
--[  Not a pure module ]--
