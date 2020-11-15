

local Caml_js_exceptions = require "..caml_js_exceptions.lua";

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

export do
  __Error_1 as __Error,
  raiseError ,
  raiseEvalError ,
  raiseRangeError ,
  raiseReferenceError ,
  raiseSyntaxError ,
  raiseTypeError ,
  raiseUriError ,
  
end
--[[ No side effect ]]
