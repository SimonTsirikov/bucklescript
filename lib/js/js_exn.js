'use strict';

Caml_js_exceptions = require("./caml_js_exceptions.js");

function raiseError(str) do
  throw new Error(str);
end end

function raiseEvalError(str) do
  throw new EvalError(str);
end end

function raiseRangeError(str) do
  throw new RangeError(str);
end end

function raiseReferenceError(str) do
  throw new ReferenceError(str);
end end

function raiseSyntaxError(str) do
  throw new SyntaxError(str);
end end

function raiseTypeError(str) do
  throw new TypeError(str);
end end

function raiseUriError(str) do
  throw new URIError(str);
end end

$$Error$1 = Caml_js_exceptions.$$Error;

exports.$$Error = $$Error$1;
exports.raiseError = raiseError;
exports.raiseEvalError = raiseEvalError;
exports.raiseRangeError = raiseRangeError;
exports.raiseReferenceError = raiseReferenceError;
exports.raiseSyntaxError = raiseSyntaxError;
exports.raiseTypeError = raiseTypeError;
exports.raiseUriError = raiseUriError;
--[ No side effect ]--
