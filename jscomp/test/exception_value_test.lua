console = {log = print};

Curry = require "../../lib/js/curry";
Js_exn = require "../../lib/js/js_exn";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(param) do
  error(Caml_builtin_exceptions.not_found)
end end

function assert_f(x) do
  if (x <= 3) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "exception_value_test.ml",
        9,
        12
      }
    })
  end
   end 
  return 3;
end end

function hh(param) do
  error(Caml_builtin_exceptions.not_found)
end end

A = Caml_exceptions.create("Exception_value_test.A");

B = Caml_exceptions.create("Exception_value_test.B");

C = Caml_exceptions.create("Exception_value_test.C");

u = {
  A,
  3
};

function test_not_found(f, param) do
  xpcall(function() do
    return Curry._1(f, --[[ () ]]0);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return 2;
    end else do
      error(exn)
    end end 
  end end)
end end

function test_js_error2(param) do
  xpcall(function() do
    return JSON.parse(" {\"x\" : }");
  end end,function(raw_e) do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e[0] == Js_exn.__Error) then do
      console.log(e[1].stack);
      error(e)
    end else do
      error(e)
    end end 
  end end)
end end

function test_js_error3(param) do
  xpcall(function() do
    JSON.parse(" {\"x\"}");
    return 1;
  end end,function(e) do
    return 0;
  end end)
end end

exports = {}
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
--[[ No side effect ]]