__console = {log = print};

Caml_js_exceptions = require "..caml_js_exceptions";

function raiseError(str) do
  error(new __Error(str))
end end

function raiseEvalError(str) do
  error(new __EvalError(str))
end end

function raiseRangeError(str) do
  error(new __RangeError(str))
end end

function raiseReferenceError(str) do
  error(new __ReferenceError(str))
end end

function raiseSyntaxError(str) do
  error(new __SyntaxError(str))
end end

function raiseTypeError(str) do
  error(new __TypeError(str))
end end

function raiseUriError(str) do
  error(new __URIError(str))
end end

__Error_1 = Caml_js_exceptions.__Error;

exports = {};
exports.__Error = __Error_1;
exports.raiseError = raiseError;
exports.raiseEvalError = raiseEvalError;
exports.raiseRangeError = raiseRangeError;
exports.raiseReferenceError = raiseReferenceError;
exports.raiseSyntaxError = raiseSyntaxError;
exports.raiseTypeError = raiseTypeError;
exports.raiseUriError = raiseUriError;
return exports;
--[[ No side effect ]]
