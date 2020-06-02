--[['use strict';]]

__Array = require "../../lib/js/array";
Curry = require "../../lib/js/curry";
Caml_array = require "../../lib/js/caml_array";
Caml_int32 = require "../../lib/js/caml_int32";

function for_(x) do
  for i = 0 , console.log("hi"), #x , 1 do
    console.log(Caml_array.caml_array_get(x, i));
  end
  return --[[ () ]]0;
end end

function for_2(x) do
  for i = 0 , #x , 1 do
    console.log(Caml_array.caml_array_get(x, i));
  end
  return --[[ () ]]0;
end end

function for_3(x) do
  v = do
    contents: 0
  end;
  arr = __Array.map((function (param, param_1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x , 1 do
    j = (i << 1);
    Caml_array.caml_array_set(arr, i, (function(j)do
        return function (param) do
          v.contents = v.contents + j | 0;
          return --[[ () ]]0;
        end end
        end(j)));
  end
  __Array.iter((function (x) do
          return Curry._1(x, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

function for_4(x) do
  v = do
    contents: 0
  end;
  arr = __Array.map((function (param, param_1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x , 1 do
    j = (i << 1);
    k = (j << 1);
    Caml_array.caml_array_set(arr, i, (function(k)do
        return function (param) do
          v.contents = v.contents + k | 0;
          return --[[ () ]]0;
        end end
        end(k)));
  end
  __Array.iter((function (x) do
          return Curry._1(x, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

function for_5(x, u) do
  v = do
    contents: 0
  end;
  arr = __Array.map((function (param, param_1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x , 1 do
    k = Caml_int32.imul((u << 1), u);
    Caml_array.caml_array_set(arr, i, (function(k)do
        return function (param) do
          v.contents = v.contents + k | 0;
          return --[[ () ]]0;
        end end
        end(k)));
  end
  __Array.iter((function (x) do
          return Curry._1(x, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

function for_6(x, u) do
  v = do
    contents: 0
  end;
  arr = __Array.map((function (param, param_1) do
          return --[[ () ]]0;
        end end), x);
  v4 = do
    contents: 0
  end;
  v5 = do
    contents: 0
  end;
  v4.contents = v4.contents + 1 | 0;
  for j = 0 , 1 , 1 do
    v5.contents = v5.contents + 1 | 0;
    v2 = do
      contents: 0
    end;
    (function(v2)do
    for i = 0 , #x , 1 do
      k = Caml_int32.imul((u << 1), u);
      h = (v5.contents << 1);
      v2.contents = v2.contents + 1 | 0;
      Caml_array.caml_array_set(arr, i, (function(k,h)do
          return function (param) do
            v.contents = (((((v.contents + k | 0) + v2.contents | 0) + u | 0) + v4.contents | 0) + v5.contents | 0) + h | 0;
            return --[[ () ]]0;
          end end
          end(k,h)));
    end
    end(v2));
  end
  __Array.iter((function (x) do
          return Curry._1(x, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

exports.for_ = for_;
exports.for_2 = for_2;
exports.for_3 = for_3;
exports.for_4 = for_4;
exports.for_5 = for_5;
exports.for_6 = for_6;
--[[ No side effect ]]
