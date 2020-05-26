'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");
Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

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
        end end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end end

A = Caml_exceptions.create("Exception_rebound_err_test.A");

B = Caml_exceptions.create("Exception_rebound_err_test.B");

C = Caml_exceptions.create("Exception_rebound_err_test.C");

function test_js_error4(param) do
  try do
    JSON.parse(" {\"x\"}");
    return 1;
  end
  catch (raw_e)do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e == Caml_builtin_exceptions.not_found) then do
      return 2;
    end else if (e[0] == Caml_builtin_exceptions.invalid_argument and e[1] == "x") then do
      return 3;
    end
     end  end 
    if (e[0] == A) then do
      if (e[1] ~= 2) then do
        return 7;
      end else do
        return 4;
      end end 
    end else if (e == B) then do
      return 5;
    end else if (e[0] == C and !(e[1] ~= 1 or e[2] ~= 2)) then do
      return 6;
    end else do
      return 7;
    end end  end  end 
  end
end end

function f(g) do
  try do
    return Curry._1(g, --[ () ]--0);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return 1;
    end else do
      throw exn;
    end end 
  end
end end

eq("File \"exception_rebound_err_test.ml\", line 24, characters 6-13", test_js_error4(--[ () ]--0), 7);

Mt.from_pair_suites("Exception_rebound_err_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.A = A;
exports.B = B;
exports.C = C;
exports.test_js_error4 = test_js_error4;
exports.f = f;
--[  Not a pure module ]--
