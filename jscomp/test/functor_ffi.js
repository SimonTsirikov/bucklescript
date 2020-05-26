'use strict';

Caml_option = require("../../lib/js/caml_option.js");

function Make(S) do
  opt_get = function (f, i) do
    return Caml_option.undefined_to_opt(f[i]);
  end end;
  return do
          opt_get: opt_get
        end;
end end

function opt_get(f, i) do
  return Caml_option.undefined_to_opt(f[i]);
end end

Int_arr = do
  opt_get: opt_get
end;

function f(v) do
  return --[ tuple ]--[
          v[0],
          Caml_option.undefined_to_opt(v[1])
        ];
end end

exports.Make = Make;
exports.Int_arr = Int_arr;
exports.f = f;
--[ No side effect ]--
