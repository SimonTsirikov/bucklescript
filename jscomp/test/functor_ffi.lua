__console = {log = print};

Caml_option = require "......lib.js.caml_option";

function Make(S) do
  opt_get = function(f, i) do
    return Caml_option.undefined_to_opt(f[i]);
  end end;
  return {
          opt_get = opt_get
        };
end end

function opt_get(f, i) do
  return Caml_option.undefined_to_opt(f[i]);
end end

Int_arr = {
  opt_get = opt_get
};

function f(v) do
  return --[[ tuple ]]{
          v[0],
          Caml_option.undefined_to_opt(v[1])
        };
end end

exports = {};
exports.Make = Make;
exports.Int_arr = Int_arr;
exports.f = f;
return exports;
--[[ No side effect ]]
