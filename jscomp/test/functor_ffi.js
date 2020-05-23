'use strict';

var Caml_option = require("../../lib/js/caml_option.js");

function Make(S) do
  var opt_get = function (f, i) do
    return Caml_option.undefined_to_opt(f[i]);
  end;
  return do
          opt_get: opt_get
        end;
end

function opt_get(f, i) do
  return Caml_option.undefined_to_opt(f[i]);
end

var Int_arr = do
  opt_get: opt_get
end;

function f(v) do
  return --[ tuple ]--[
          v[0],
          Caml_option.undefined_to_opt(v[1])
        ];
end

exports.Make = Make;
exports.Int_arr = Int_arr;
exports.f = f;
--[ No side effect ]--
