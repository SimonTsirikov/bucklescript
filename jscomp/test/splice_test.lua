--[['use strict';]]

Mt = require "./mt.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Caml_splice_call = require "../../lib/js/caml_splice_call.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

Caml_splice_call$1 = { };

Math.max(1);

function f00(a, b) do
  return a.send(b);
end end

a = [];

a.push(1, 2, 3, 4);

eq("File \"splice_test.ml\", line 29, characters 5-12", a, [
      1,
      2,
      3,
      4
    ]);

function dynamic(arr) do
  a = [];
  Caml_splice_call.spliceObjApply(a, "push", [
        1,
        arr
      ]);
  return eq("File \"splice_test.ml\", line 34, characters 5-12", a, Caml_array.caml_array_concat(--[[ :: ]][
                  [1],
                  --[[ :: ]][
                    arr,
                    --[[ [] ]]0
                  ]
                ]));
end end

dynamic([
      2,
      3,
      4
    ]);

dynamic([]);

dynamic([
      1,
      1,
      3
    ]);

a$1 = [];

a$1.push(1, 2, 3, 4);

eq("File \"splice_test.ml\", line 51, characters 7-14", a$1, [
      1,
      2,
      3,
      4
    ]);

function dynamic$1(arr) do
  a = [];
  Caml_splice_call.spliceObjApply(a, "push", [
        1,
        arr
      ]);
  return eq("File \"splice_test.ml\", line 56, characters 7-14", a, Caml_array.caml_array_concat(--[[ :: ]][
                  [1],
                  --[[ :: ]][
                    arr,
                    --[[ [] ]]0
                  ]
                ]));
end end

dynamic$1([
      2,
      3,
      4
    ]);

dynamic$1([]);

dynamic$1([
      1,
      1,
      3
    ]);

Pipe = do
  dynamic: dynamic$1
end;

function f1(c) do
  return Caml_splice_call.spliceApply(Math.max, [
              1,
              c
            ]);
end end

eq("File \"splice_test.ml\", line 67, characters 6-13", Math.max(1, 2, 3), 3);

eq("File \"splice_test.ml\", line 68, characters 6-13", Math.max(1), 1);

eq("File \"splice_test.ml\", line 69, characters 6-13", Math.max(1, 1, 2, 3, 4, 5, 2, 3), 5);

Mt.from_pair_suites("splice_test.ml", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Caml_splice_call = Caml_splice_call$1;
exports.f00 = f00;
exports.dynamic = dynamic;
exports.Pipe = Pipe;
exports.f1 = f1;
--[[  Not a pure module ]]
