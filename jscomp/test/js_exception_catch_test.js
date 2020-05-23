'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Js_exn = require("../../lib/js/js_exn.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var counter = do
  contents: 0
end;

function add_test(loc, test) do
  counter.contents = counter.contents + 1 | 0;
  var id = loc .. (" id " .. String(counter.contents));
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      id,
      test
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function eq(loc, x, y) do
  return add_test(loc, (function (param) do
                return --[ Eq ]--Block.__(0, [
                          x,
                          y
                        ]);
              end));
end

function false_(loc) do
  return add_test(loc, (function (param) do
                return --[ Ok ]--Block.__(4, [false]);
              end));
end

function true_(loc) do
  return add_test(loc, (function (param) do
                return --[ Ok ]--Block.__(4, [true]);
              end));
end

var exit = 0;

var e;

try do
  e = JSON.parse(" {\"x\"}");
  exit = 1;
end
catch (raw_exn)do
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Js_exn.$$Error) do
    add_test("File \"js_exception_catch_test.ml\", line 21, characters 10-17", (function (param) do
            return --[ Ok ]--Block.__(4, [true]);
          end));
  end else do
    throw exn;
  end
end

if (exit == 1) do
  add_test("File \"js_exception_catch_test.ml\", line 22, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end

var A = Caml_exceptions.create("Js_exception_catch_test.A");

var B = Caml_exceptions.create("Js_exception_catch_test.B");

var C = Caml_exceptions.create("Js_exception_catch_test.C");

function test(f) do
  try do
    Curry._1(f, --[ () ]--0);
    return --[ No_error ]---465676758;
  end
  catch (raw_e)do
    var e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e == Caml_builtin_exceptions.not_found) do
      return --[ Not_found ]---358247754;
    end else if (e[0] == Caml_builtin_exceptions.invalid_argument) do
      if (e[1] == "x") do
        return --[ Invalid_argument ]---50278363;
      end else do
        return --[ Invalid_any ]--545126980;
      end
    end else if (e[0] == A) do
      if (e[1] ~= 2) do
        return --[ A_any ]--740357294;
      end else do
        return --[ A2 ]--14545;
      end
    end else if (e == B) do
      return --[ B ]--66;
    end else if (e[0] == C) do
      if (e[1] ~= 1 or e[2] ~= 2) do
        return --[ C_any ]---756146768;
      end else do
        return --[ C ]--67;
      end
    end else if (e[0] == Js_exn.$$Error) do
      return --[ Js_error ]--634022066;
    end else do
      return --[ Any ]--3257036;
    end
  end
end

eq("File \"js_exception_catch_test.ml\", line 43, characters 5-12", test((function (param) do
            return --[ () ]--0;
          end)), --[ No_error ]---465676758);

eq("File \"js_exception_catch_test.ml\", line 44, characters 5-12", test((function (param) do
            throw Caml_builtin_exceptions.not_found;
          end)), --[ Not_found ]---358247754);

eq("File \"js_exception_catch_test.ml\", line 45, characters 5-12", test((function (param) do
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  "x"
                ];
          end)), --[ Invalid_argument ]---50278363);

eq("File \"js_exception_catch_test.ml\", line 46, characters 5-12", test((function (param) do
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  ""
                ];
          end)), --[ Invalid_any ]--545126980);

eq("File \"js_exception_catch_test.ml\", line 47, characters 5-12", test((function (param) do
            throw [
                  A,
                  2
                ];
          end)), --[ A2 ]--14545);

eq("File \"js_exception_catch_test.ml\", line 48, characters 5-12", test((function (param) do
            throw [
                  A,
                  3
                ];
          end)), --[ A_any ]--740357294);

eq("File \"js_exception_catch_test.ml\", line 49, characters 5-12", test((function (param) do
            throw B;
          end)), --[ B ]--66);

eq("File \"js_exception_catch_test.ml\", line 50, characters 5-12", test((function (param) do
            throw [
                  C,
                  1,
                  2
                ];
          end)), --[ C ]--67);

eq("File \"js_exception_catch_test.ml\", line 51, characters 5-12", test((function (param) do
            throw [
                  C,
                  0,
                  2
                ];
          end)), --[ C_any ]---756146768);

eq("File \"js_exception_catch_test.ml\", line 52, characters 5-12", test((function (param) do
            throw new Error("x");
          end)), --[ Js_error ]--634022066);

eq("File \"js_exception_catch_test.ml\", line 53, characters 5-12", test((function (param) do
            throw [
                  Caml_builtin_exceptions.failure,
                  "x"
                ];
          end)), --[ Any ]--3257036);

Mt.from_pair_suites("Js_exception_catch_test", suites.contents);

exports.suites = suites;
exports.add_test = add_test;
exports.eq = eq;
exports.false_ = false_;
exports.true_ = true_;
exports.A = A;
exports.B = B;
exports.C = C;
exports.test = test;
--[  Not a pure module ]--
