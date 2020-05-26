'use strict';

Caml_option = require("../../lib/js/caml_option.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function test(dom) do
  elem = dom.getElementById("haha");
  if (elem ~= null) then do
    console.log(elem);
    return 2;
  end else do
    return 1;
  end end 
end end

function f_undefined(xs, i) do
  match = xs[i];
  if (match ~= undefined) then do
    return match;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "return_check.ml",
            31,
            14
          ]
        ];
  end end 
end end

function f_escaped_not(xs, i) do
  x = xs[i];
  console.log("hei");
  if (x ~= undefined) then do
    return x;
  end else do
    return 1;
  end end 
end end

function f_escaped_1(xs, i) do
  x = xs[i];
  return (function (param) do
      if (x ~= undefined) then do
        return x;
      end else do
        return 1;
      end end 
    end end);
end end

function f_escaped_2(xs, i) do
  console.log(Caml_option.undefined_to_opt(xs[i]));
  return --[ () ]--0;
end end

function f_null(xs, i) do
  match = xs[i];
  if (match ~= null) then do
    return match;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "return_check.ml",
            59,
            14
          ]
        ];
  end end 
end end

function f_null_undefined(xs, i) do
  match = xs[i];
  if (match == null) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "return_check.ml",
            68,
            14
          ]
        ];
  end else do
    return match;
  end end 
end end

exports.test = test;
exports.f_undefined = f_undefined;
exports.f_escaped_not = f_escaped_not;
exports.f_escaped_1 = f_escaped_1;
exports.f_escaped_2 = f_escaped_2;
exports.f_null = f_null;
exports.f_null_undefined = f_null_undefined;
--[ No side effect ]--
