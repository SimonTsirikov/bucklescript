

import * as Caml_format from "./caml_format.js";
import * as Caml_primitive from "./caml_primitive.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function succ(n) do
  return n + 1;
end

function pred(n) do
  return n - 1;
end

function abs(n) do
  if (n >= 0) then do
    return n;
  end else do
    return -n;
  end end 
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
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      throw exn;
    end end 
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

export do
  zero ,
  one ,
  minus_one ,
  succ ,
  pred ,
  abs ,
  size ,
  max_int ,
  min_int ,
  lognot ,
  of_string_opt ,
  to_string ,
  compare ,
  equal ,
  
end
--[ No side effect ]--
