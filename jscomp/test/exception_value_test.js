'use strict';

var Curry = require("../../lib/js/curry.js");
var Js_exn = require("../../lib/js/js_exn.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(param) do
  throw Caml_builtin_exceptions.not_found;
end

function assert_f(x) do
  if (x <= 3) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "exception_value_test.ml",
            9,
            12
          ]
        ];
  end
  return 3;
end

function hh(param) do
  throw Caml_builtin_exceptions.not_found;
end

var A = Caml_exceptions.create("Exception_value_test.A");

var B = Caml_exceptions.create("Exception_value_test.B");

var C = Caml_exceptions.create("Exception_value_test.C");

var u = [
  A,
  3
];

function test_not_found(f, param) do
  try do
    return Curry._1(f, --[ () ]--0);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return 2;
    end else do
      throw exn;
    end
  end
end

function test_js_error2(param) do
  try do
    return JSON.parse(" {\"x\" : }");
  end
  catch (raw_e)do
    var e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e[0] == Js_exn.$$Error) do
      console.log(e[1].stack);
      throw e;
    end else do
      throw e;
    end
  end
end

function test_js_error3(param) do
  try do
    JSON.parse(" {\"x\"}");
    return 1;
  end
  catch (e)do
    return 0;
  end
end

exports.f = f;
exports.assert_f = assert_f;
exports.hh = hh;
exports.A = A;
exports.B = B;
exports.C = C;
exports.u = u;
exports.test_not_found = test_not_found;
exports.test_js_error2 = test_js_error2;
exports.test_js_error3 = test_js_error3;
--[ No side effect ]--
