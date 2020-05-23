'use strict';

var Curry = require("../../lib/js/curry.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function ff(g, x) do
  try do
    Curry._1(g, x);
  end
  catch (exn)do
    if (exn ~= Caml_builtin_exceptions.not_found) do
      throw exn;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (exn$1)do
    if (exn$1 ~= Caml_builtin_exceptions.out_of_memory) do
      throw exn$1;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (raw_exn)do
    var exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn$2[0] ~= Caml_builtin_exceptions.sys_error) do
      throw exn$2;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (raw_exn$1)do
    var exn$3 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
    if (exn$3[0] ~= Caml_builtin_exceptions.invalid_argument) do
      throw exn$3;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (exn$4)do
    if (exn$4 ~= Caml_builtin_exceptions.end_of_file) do
      throw exn$4;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (raw_exn$2)do
    var exn$5 = Caml_js_exceptions.internalToOCamlException(raw_exn$2);
    if (exn$5[0] ~= Caml_builtin_exceptions.match_failure) do
      throw exn$5;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (exn$6)do
    if (exn$6 ~= Caml_builtin_exceptions.stack_overflow) do
      throw exn$6;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (exn$7)do
    if (exn$7 ~= Caml_builtin_exceptions.sys_blocked_io) do
      throw exn$7;
    end
    
  end
  try do
    Curry._1(g, x);
  end
  catch (raw_exn$3)do
    var exn$8 = Caml_js_exceptions.internalToOCamlException(raw_exn$3);
    if (exn$8[0] ~= Caml_builtin_exceptions.assert_failure) do
      throw exn$8;
    end
    
  end
  try do
    return Curry._1(g, x);
  end
  catch (raw_exn$4)do
    var exn$9 = Caml_js_exceptions.internalToOCamlException(raw_exn$4);
    if (exn$9[0] == Caml_builtin_exceptions.undefined_recursive_module) do
      return --[ () ]--0;
    end else do
      throw exn$9;
    end
  end
end

function u(param) do
  throw Caml_builtin_exceptions.not_found;
end

function f(x) do
  if (typeof x == "number") do
    return 2;
  end else if (x.tag) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_trywith.ml",
            51,
            9
          ]
        ];
  end else do
    return 1;
  end
end

var u1 = "bad character decimal encoding \\";

var v = "bad character decimal encoding \\%c%c%c";

exports.ff = ff;
exports.u = u;
exports.u1 = u1;
exports.v = v;
exports.f = f;
--[ No side effect ]--
