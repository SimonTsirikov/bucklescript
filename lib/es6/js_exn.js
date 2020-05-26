

import * as Caml_js_exceptions from "./caml_js_exceptions.js";

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

export do
  $$Error$1 as $$Error,
  raiseError ,
  raiseEvalError ,
  raiseRangeError ,
  raiseReferenceError ,
  raiseSyntaxError ,
  raiseTypeError ,
  raiseUriError ,
  
end
--[ No side effect ]--
