--[['use strict';]]

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

v = --[[ A0 ]]Block.__(0, {
    --[[ lbl ]]3,
    --[[ more : [] ]]0
  });

v1 = --[[ A1 ]]Block.__(1, {--[[ more : :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ [] ]]0
      }
    }});

function f(x) do
  if (x.tag) then do
    return List.fold_left((function (prim, prim_1) do
                  return prim + prim_1 | 0;
                end end), 0, x[--[[ more ]]0]);
  end else do
    return List.fold_left((function (prim, prim_1) do
                  return prim + prim_1 | 0;
                end end), x[--[[ lbl ]]0], x[--[[ more ]]1]);
  end end 
end end

eq("File \"inline_record_test.ml\", line 25, characters 6-13", f(v), 3);

eq("File \"inline_record_test.ml\", line 26, characters 6-13", f(v1), 3);

console.log(f(v));

console.log(f(v1));

A0 = Caml_exceptions.create("Inline_record_test.A0");

v3 = {
  A0,
  --[[ lbl ]]3,
  --[[ more : [] ]]0
};

tmp;

if (A0 == A0) then do
  tmp = 3;
end else do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "inline_record_test.ml",
      51,
      52
    }
  })
end end 

eq("File \"inline_record_test.ml\", line 51, characters 6-13", tmp, 3);

function ff(x) do
  if (x.tag) then do
    x[--[[ z ]]0] = x[--[[ z ]]0] + 2 | 0;
    return --[[ () ]]0;
  end else do
    x[--[[ x ]]0] = x[--[[ x ]]0] + 1 | 0;
    return --[[ () ]]0;
  end end 
end end

v4 = --[[ A0 ]]Block.__(0, {
    --[[ x ]]0,
    --[[ y ]]0,
    --[[ z ]]0
  });

v5 = --[[ A1 ]]Block.__(1, {--[[ z ]]0});

for i = 0 , 10 , 1 do
  ff(v4);
  ff(v5);
end

tmp_1;

if (v4.tag) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "inline_record_test.ml",
      69,
      48
    }
  })
end else do
  tmp_1 = v4[--[[ x ]]0];
end end 

eq("File \"inline_record_test.ml\", line 69, characters 6-13", tmp_1, 11);

tmp_2;

if (v5.tag) then do
  tmp_2 = v5[--[[ z ]]0];
end else do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "inline_record_test.ml",
      71,
      48
    }
  })
end end 

eq("File \"inline_record_test.ml\", line 71, characters 6-13", tmp_2, 22);

A4 = Caml_exceptions.create("Inline_record_test.A4");

v6 = {
  A4,
  --[[ x ]]0,
  --[[ y ]]0,
  --[[ z ]]0
};

function ff0(x) do
  if (x[0] == A4) then do
    x[--[[ x ]]1] = x[--[[ x ]]1] + 1 | 0;
    x[--[[ z ]]3] = x[--[[ z ]]3] + 1 | 0;
    return --[[ () ]]0;
  end else do
    return --[[ () ]]0;
  end end 
end end

for i_1 = 0 , 10 , 1 do
  ff0(v6);
end

tmp_3;

if (v6[0] == A4) then do
  tmp_3 = v6[--[[ x ]]1];
end else do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "inline_record_test.ml",
      87,
      49
    }
  })
end end 

eq("File \"inline_record_test.ml\", line 87, characters 6-13", tmp_3, 11);

function ff1(x) do
  if (x) then do
    return --[[ A0 ]]{
            --[[ lbl ]]x[--[[ lbl ]]0] + 1 | 0,
            --[[ more ]]x[--[[ more ]]1]
          };
  end else do
    return --[[ A1 ]]0;
  end end 
end end

Mt.from_pair_suites("Inline_record_test", suites.contents);

v2 = --[[ A0 ]]{
  --[[ lbl ]]3,
  --[[ more : [] ]]0
};

vvv = --[[ A0 ]]{
  --[[ lbl ]]3,
  --[[ more : [] ]]0
};

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.v1 = v1;
exports.f = f;
exports.v2 = v2;
exports.A0 = A0;
exports.v3 = v3;
exports.vvv = vvv;
exports.ff = ff;
exports.v4 = v4;
exports.v5 = v5;
exports.A4 = A4;
exports.v6 = v6;
exports.ff0 = ff0;
exports.ff1 = ff1;
--[[  Not a pure module ]]
