--[['use strict';]]

Caml_int32 = require "../../lib/js/caml_int32.lua";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill.lua";

function sum(v) do
  result = 0;
  for i = 0 , Caml_external_polyfill.resolve("caml_ba_dim_1")(v) - 1 | 0 , 1 do
    result = result + Caml_external_polyfill.resolve("caml_ba_get_1")(v, i) | 0;
  end
  return --[[ () ]]0;
end end

function init(v) do
  for i = 0 , Caml_external_polyfill.resolve("caml_ba_dim_1")(v) - 1 | 0 , 1 do
    v[i] = do
      re: Caml_int32.imul(i, i),
      im: Caml_int32.imul(Caml_int32.imul(i, i), i)
    end;
  end
  return --[[ () ]]0;
end end

function init2(v) do
  for i = 0 , Caml_external_polyfill.resolve("caml_ba_dim_1")(v) - 1 | 0 , 1 do
    v[i] = i;
  end
  return --[[ () ]]0;
end end

function init3(v) do
  for i = 0 , Caml_external_polyfill.resolve("caml_ba_dim_1")(v) - 1 | 0 , 1 do
    Caml_external_polyfill.resolve("caml_ba_set_1")(v, i, i);
  end
  return --[[ () ]]0;
end end

BA1 = --[[ alias ]]0;

exports.BA1 = BA1;
exports.sum = sum;
exports.init = init;
exports.init2 = init2;
exports.init3 = init3;
--[[ No side effect ]]
