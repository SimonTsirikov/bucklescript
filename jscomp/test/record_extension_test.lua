--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_format = require "../../lib/js/caml_format.lua";
Caml_exceptions = require "../../lib/js/caml_exceptions.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

Inline_record = Caml_exceptions.create("Record_extension_test.Inline_record");

function f(x) do
  if (x[0] == Inline_record) then do
    return x[--[[ x ]]1] + Caml_format.caml_int_of_string(x[--[[ y ]]2]) | 0;
  end
   end 
end end

v0 = {
  Inline_record,
  --[[ x ]]3,
  --[[ y ]]"4"
};

eq("File \"record_extension_test.ml\", line 18, characters 6-13", f(v0), 7);

function f2(x) do
  if (typeof x == "number" or x.tag) then do
    return 0;
  end else do
    return x[--[[ x ]]0];
  end end 
end end

function f2_with(x) do
  if (typeof x == "number" or x.tag) then do
    return x;
  end else do
    return --[[ C ]]Block.__(0, {
              --[[ x ]]0,
              --[[ y ]]x[--[[ y ]]1]
            });
  end end 
end end

Mt.from_pair_suites("File \"record_extension_test.ml\", line 43, characters 22-29", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.Inline_record = Inline_record;
exports.f = f;
exports.v0 = v0;
exports.f2 = f2;
exports.f2_with = f2_with;
--[[  Not a pure module ]]
