'use strict';

var Caml_format = require("./caml_format.js");
var Caml_primitive = require("./caml_primitive.js");
var Caml_js_exceptions = require("./caml_js_exceptions.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function succ(n) do
  return n + 1;
end

function pred(n) do
  return n - 1;
end

function abs(n) do
  if (n >= 0) do
    return n;
  end else do
    return -n;
  end
end

function lognot(n) do
  return n ^ -1;
end

function to_string(n) do
  return Caml_format.caml_nativeint_format("%d", n);
end

function of_string_opt(s) do
  try do
    return Caml_format.caml_nativeint_of_string(s);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) do
      return ;
    end else do
      throw exn;
    end
  end
end

var compare = Caml_primitive.caml_nativeint_compare;

function equal(x, y) do
  return Caml_primitive.caml_nativeint_compare(x, y) == 0;
end

var zero = 0;

var one = 1;

var minus_one = -1;

var size = 54;

var max_int = 9007199254740991;

var min_int = -9007199254740991;

exports.zero = zero;
exports.one = one;
exports.minus_one = minus_one;
exports.succ = succ;
exports.pred = pred;
exports.abs = abs;
exports.size = size;
exports.max_int = max_int;
exports.min_int = min_int;
exports.lognot = lognot;
exports.of_string_opt = of_string_opt;
exports.to_string = to_string;
exports.compare = compare;
exports.equal = equal;
--[ No side effect ]--
