

import * as Caml_int64 from "./caml_int64.js";
import * as Caml_format from "./caml_format.js";
import * as Caml_js_exceptions from "./caml_js_exceptions.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function succ(n) do
  return Caml_int64.add(n, --[ int64 ]--[
              --[ hi ]--0,
              --[ lo ]--1
            ]);
end

function pred(n) do
  return Caml_int64.sub(n, --[ int64 ]--[
              --[ hi ]--0,
              --[ lo ]--1
            ]);
end

function abs(n) do
  if (Caml_int64.ge(n, --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--0
        ])) then do
    return n;
  end else do
    return Caml_int64.neg(n);
  end end 
end

function lognot(n) do
  return Caml_int64.xor(n, --[ int64 ]--[
              --[ hi ]---1,
              --[ lo ]--4294967295
            ]);
end

function to_string(n) do
  return Caml_format.caml_int64_format("%d", n);
end

function of_string_opt(s) do
  try do
    return Caml_format.caml_int64_of_string(s);
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

var compare = Caml_int64.compare;

function equal(x, y) do
  return Caml_int64.compare(x, y) == 0;
end

var zero = --[ int64 ]--[
  --[ hi ]--0,
  --[ lo ]--0
];

var one = --[ int64 ]--[
  --[ hi ]--0,
  --[ lo ]--1
];

var minus_one = --[ int64 ]--[
  --[ hi ]---1,
  --[ lo ]--4294967295
];

var max_int = --[ int64 ]--[
  --[ hi ]--2147483647,
  --[ lo ]--4294967295
];

var min_int = --[ int64 ]--[
  --[ hi ]---2147483648,
  --[ lo ]--0
];

export do
  zero ,
  one ,
  minus_one ,
  succ ,
  pred ,
  abs ,
  max_int ,
  min_int ,
  lognot ,
  of_string_opt ,
  to_string ,
  compare ,
  equal ,
  
end
--[ No side effect ]--
