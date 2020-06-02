--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Js_exn = require "../../lib/js/js_exn";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = do
  contents: --[[ [] ]]0
end;

counter = do
  contents: 0
end;

function add_test(loc, test) do
  counter.contents = counter.contents + 1 | 0;
  id = loc .. (" id " .. String(counter.contents));
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      id,
      test
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function eq(loc, x, y) do
  return add_test(loc, (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          x,
                          y
                        });
              end end));
end end

function false_(loc) do
  return add_test(loc, (function (param) do
                return --[[ Ok ]]Block.__(4, {false});
              end end));
end end

function true_(loc) do
  return add_test(loc, (function (param) do
                return --[[ Ok ]]Block.__(4, {true});
              end end));
end end

exit = 0;

e;

xpcall(function() do
  e = JSON.parse(" {\"x\"}");
  exit = 1;
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn[0] == Js_exn.__Error) then do
    add_test("File \"js_exception_catch_test.ml\", line 21, characters 10-17", (function (param) do
            return --[[ Ok ]]Block.__(4, {true});
          end end));
  end else do
    error(exn)
  end end 
end end)

if (exit == 1) then do
  add_test("File \"js_exception_catch_test.ml\", line 22, characters 16-23", (function (param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end
 end 

A = Caml_exceptions.create("Js_exception_catch_test.A");

B = Caml_exceptions.create("Js_exception_catch_test.B");

C = Caml_exceptions.create("Js_exception_catch_test.C");

function test(f) do
  xpcall(function() do
    Curry._1(f, --[[ () ]]0);
    return --[[ No_error ]]-465676758;
  end end,function(raw_e) do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e == Caml_builtin_exceptions.not_found) then do
      return --[[ Not_found ]]-358247754;
    end else if (e[0] == Caml_builtin_exceptions.invalid_argument) then do
      if (e[1] == "x") then do
        return --[[ Invalid_argument ]]-50278363;
      end else do
        return --[[ Invalid_any ]]545126980;
      end end 
    end else if (e[0] == A) then do
      if (e[1] ~= 2) then do
        return --[[ A_any ]]740357294;
      end else do
        return --[[ A2 ]]14545;
      end end 
    end else if (e == B) then do
      return --[[ B ]]66;
    end else if (e[0] == C) then do
      if (e[1] ~= 1 or e[2] ~= 2) then do
        return --[[ C_any ]]-756146768;
      end else do
        return --[[ C ]]67;
      end end 
    end else if (e[0] == Js_exn.__Error) then do
      return --[[ Js_error ]]634022066;
    end else do
      return --[[ Any ]]3257036;
    end end  end  end  end  end  end 
  end end)
end end

eq("File \"js_exception_catch_test.ml\", line 43, characters 5-12", test((function (param) do
            return --[[ () ]]0;
          end end)), --[[ No_error ]]-465676758);

eq("File \"js_exception_catch_test.ml\", line 44, characters 5-12", test((function (param) do
            error(Caml_builtin_exceptions.not_found)
          end end)), --[[ Not_found ]]-358247754);

eq("File \"js_exception_catch_test.ml\", line 45, characters 5-12", test((function (param) do
            error({
              Caml_builtin_exceptions.invalid_argument,
              "x"
            })
          end end)), --[[ Invalid_argument ]]-50278363);

eq("File \"js_exception_catch_test.ml\", line 46, characters 5-12", test((function (param) do
            error({
              Caml_builtin_exceptions.invalid_argument,
              ""
            })
          end end)), --[[ Invalid_any ]]545126980);

eq("File \"js_exception_catch_test.ml\", line 47, characters 5-12", test((function (param) do
            error({
              A,
              2
            })
          end end)), --[[ A2 ]]14545);

eq("File \"js_exception_catch_test.ml\", line 48, characters 5-12", test((function (param) do
            error({
              A,
              3
            })
          end end)), --[[ A_any ]]740357294);

eq("File \"js_exception_catch_test.ml\", line 49, characters 5-12", test((function (param) do
            error(B)
          end end)), --[[ B ]]66);

eq("File \"js_exception_catch_test.ml\", line 50, characters 5-12", test((function (param) do
            error({
              C,
              1,
              2
            })
          end end)), --[[ C ]]67);

eq("File \"js_exception_catch_test.ml\", line 51, characters 5-12", test((function (param) do
            error({
              C,
              0,
              2
            })
          end end)), --[[ C_any ]]-756146768);

eq("File \"js_exception_catch_test.ml\", line 52, characters 5-12", test((function (param) do
            error(new Error("x"))
          end end)), --[[ Js_error ]]634022066);

eq("File \"js_exception_catch_test.ml\", line 53, characters 5-12", test((function (param) do
            error({
              Caml_builtin_exceptions.failure,
              "x"
            })
          end end)), --[[ Any ]]3257036);

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
--[[  Not a pure module ]]
