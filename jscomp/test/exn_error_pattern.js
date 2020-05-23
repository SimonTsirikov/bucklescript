'use strict';

var Mt = require("./mt.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(match) do
  if (Caml_exceptions.caml_is_extension(match)) do
    if (match == Caml_builtin_exceptions.not_found) do
      return 0;
    end else if (match[0] == Caml_builtin_exceptions.invalid_argument or match == Caml_builtin_exceptions.stack_overflow) do
      return 1;
    end else if (match[0] == Caml_builtin_exceptions.sys_error) do
      return 2;
    end else do
      return ;
    end
  end
  
end

var A = Caml_exceptions.create("Exn_error_pattern.A");

var B = Caml_exceptions.create("Exn_error_pattern.B");

function g(match) do
  if (Caml_exceptions.caml_is_extension(match)) do
    if (match == Caml_builtin_exceptions.not_found or match[0] == Caml_builtin_exceptions.invalid_argument) do
      return 0;
    end else if (match[0] == Caml_builtin_exceptions.sys_error) do
      return 2;
    end else if (match[0] == A or match[0] == B) do
      return match[1];
    end else do
      return ;
    end
  end
  
end

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

eq("File \"exn_error_pattern.ml\", line 34, characters 5-12", f(Caml_builtin_exceptions.not_found), 0);

eq("File \"exn_error_pattern.ml\", line 35, characters 5-12", f([
          Caml_builtin_exceptions.invalid_argument,
          ""
        ]), 1);

eq("File \"exn_error_pattern.ml\", line 36, characters 5-12", f(Caml_builtin_exceptions.stack_overflow), 1);

eq("File \"exn_error_pattern.ml\", line 37, characters 5-12", f([
          Caml_builtin_exceptions.sys_error,
          ""
        ]), 2);

var tmp;

try do
  throw new Error("x");
end
catch (raw_e)do
  tmp = Caml_js_exceptions.internalToOCamlException(raw_e);
end

eq("File \"exn_error_pattern.ml\", line 38, characters 5-12", f(tmp), undefined);

Mt.from_pair_suites("Exn_error_pattern", suites.contents);

exports.f = f;
exports.A = A;
exports.B = B;
exports.g = g;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
