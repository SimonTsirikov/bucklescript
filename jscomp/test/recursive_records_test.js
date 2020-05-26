'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

rec_cell = { };

rec_cell.content = 3;

rec_cell.next = rec_cell;

function f0(x) do
  rec_cell = { };
  Caml_obj.caml_update_dummy(rec_cell, do
        content: Caml_int32.imul(x, x) - 6 | 0,
        next: rec_cell
      end);
  return rec_cell;
end end

function a0(x) do
  return (x.content + x.next.content | 0) + x.next.next.content | 0;
end end

eq("File \"recursive_records_test.ml\", line 29, characters 5-12", a0(rec_cell), 9);

eq("File \"recursive_records_test.ml\", line 30, characters 5-12", a0(f0(3)), 9);

rec_cell2 = [];

rec_cell2[0] = 3;

rec_cell2[1] = rec_cell2;

function f2(x) do
  rec_cell2 = [];
  Caml_obj.caml_update_dummy(rec_cell2, --[[ Cons ]][
        --[[ content ]]Caml_int32.imul(x, x) - 6 | 0,
        --[[ next ]]rec_cell2
      ]);
  return rec_cell2;
end end

function hd(x) do
  if (x) then do
    return x[--[[ content ]]0];
  end else do
    return 0;
  end end 
end end

function tl_exn(x) do
  if (x) then do
    return x[--[[ next ]]1];
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "recursive_records_test.ml",
            52,
            11
          ]
        ];
  end end 
end end

eq("File \"recursive_records_test.ml\", line 56, characters 6-13", (hd(rec_cell2) + hd(tl_exn(rec_cell2)) | 0) + hd(tl_exn(tl_exn(rec_cell2))) | 0, 9);

rec_cell2$1 = f2(3);

eq("File \"recursive_records_test.ml\", line 60, characters 5-12", (hd(rec_cell2$1) + hd(tl_exn(rec_cell2$1)) | 0) + hd(tl_exn(tl_exn(rec_cell2$1))) | 0, 9);

rec_cell3 = [];

rec_cell3[0] = 3;

rec_cell3[1] = rec_cell3;

function f3(x) do
  rec_cell3 = [];
  Caml_obj.caml_update_dummy(rec_cell3, --[[ :: ]][
        Caml_int32.imul(x, x) - 6 | 0,
        rec_cell3
      ]);
  return rec_cell3;
end end

eq("File \"recursive_records_test.ml\", line 74, characters 5-12", (List.hd(rec_cell3) + List.hd(List.tl(rec_cell3)) | 0) + List.hd(List.tl(List.tl(rec_cell3))) | 0, 9);

rec_cell3$1 = f3(3);

eq("File \"recursive_records_test.ml\", line 77, characters 5-12", (List.hd(rec_cell3$1) + List.hd(List.tl(rec_cell3$1)) | 0) + List.hd(List.tl(List.tl(rec_cell3$1))) | 0, 9);

Mt.from_pair_suites("recursive_records_test.ml", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.rec_cell = rec_cell;
exports.f0 = f0;
exports.a0 = a0;
exports.rec_cell2 = rec_cell2;
exports.f2 = f2;
exports.hd = hd;
exports.tl_exn = tl_exn;
exports.rec_cell3 = rec_cell3;
exports.f3 = f3;
--[[  Not a pure module ]]
