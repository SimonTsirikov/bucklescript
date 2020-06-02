--[['use strict';]]

List = require "../../lib/js/list.lua";
__Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Caml_int32 = require "../../lib/js/caml_int32.lua";

function for_3(x) do
  v = do
    contents: 0
  end;
  arr = __Array.map((function (param, param$1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x - 1 | 0 , 1 do
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
  arr = __Array.map((function (param, param$1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x - 1 | 0 , 1 do
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
  arr = __Array.map((function (param, param$1) do
          return --[[ () ]]0;
        end end), x);
  for i = 0 , #x - 1 | 0 , 1 do
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
  arr = __Array.map((function (param, param$1) do
          return --[[ () ]]0;
        end end), x);
  v4 = do
    contents: 0
  end;
  v5 = do
    contents: 0
  end;
  inspect_3 = -1;
  v4.contents = v4.contents + 1 | 0;
  for j = 0 , 1 , 1 do
    v5.contents = v5.contents + 1 | 0;
    v2 = do
      contents: 0
    end;
    (function(v2)do
    for i = 0 , #x - 1 | 0 , 1 do
      k = Caml_int32.imul((u << 1), u);
      h = (v5.contents << 1);
      v2.contents = v2.contents + 1 | 0;
      Caml_array.caml_array_set(arr, i, (function(k,h)do
          return function (param) do
            v.contents = (((((v.contents + k | 0) + v2.contents | 0) + v4.contents | 0) + v5.contents | 0) + h | 0) + u | 0;
            return --[[ () ]]0;
          end end
          end(k,h)));
    end
    end(v2));
    inspect_3 = v2.contents;
  end
  __Array.iter((function (x) do
          return Curry._1(x, --[[ () ]]0);
        end end), arr);
  return {
          v.contents,
          v4.contents,
          v5.contents,
          inspect_3
        };
end end

function for_7(param) do
  v = do
    contents: 0
  end;
  arr = Caml_array.caml_make_vect(21, (function (param) do
          return --[[ () ]]0;
        end end));
  for i = 0 , 6 , 1 do
    (function(i)do
    for j = 0 , 2 , 1 do
      Caml_array.caml_array_set(arr, Caml_int32.imul(i, 3) + j | 0, (function(j)do
          return function (param) do
            v.contents = (v.contents + i | 0) + j | 0;
            return --[[ () ]]0;
          end end
          end(j)));
    end
    end(i));
  end
  __Array.iter((function (f) do
          return Curry._1(f, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

function for_8(param) do
  v = do
    contents: 0
  end;
  arr = Caml_array.caml_make_vect(21, (function (param) do
          return --[[ () ]]0;
        end end));
  for i = 0 , 6 , 1 do
    k = (i << 1);
    (function(i,k)do
    for j = 0 , 2 , 1 do
      h = i + j | 0;
      Caml_array.caml_array_set(arr, Caml_int32.imul(i, 3) + j | 0, (function(j,h)do
          return function (param) do
            v.contents = (((v.contents + i | 0) + j | 0) + h | 0) + k | 0;
            return --[[ () ]]0;
          end end
          end(j,h)));
    end
    end(i,k));
  end
  __Array.iter((function (f) do
          return Curry._1(f, --[[ () ]]0);
        end end), arr);
  return v.contents;
end end

function for_9(param) do
  v = do
    contents: --[[ [] ]]0
  end;
  collect = function (x) do
    v.contents = --[[ :: ]]{
      x,
      v.contents
    };
    return --[[ () ]]0;
  end end;
  vv = do
    contents: 0
  end;
  vv2 = do
    contents: 0
  end;
  arr = Caml_array.caml_make_vect(4, (function (param) do
          return --[[ () ]]0;
        end end));
  arr2 = Caml_array.caml_make_vect(2, (function (param) do
          return --[[ () ]]0;
        end end));
  for i = 0 , 1 , 1 do
    v$1 = do
      contents: 0
    end;
    v$1.contents = v$1.contents + i | 0;
    (function(v$1)do
    for j = 0 , 1 , 1 do
      v$1.contents = v$1.contents + 1 | 0;
      collect(v$1.contents);
      Caml_array.caml_array_set(arr, (i << 1) + j | 0, (function (param) do
              vv.contents = vv.contents + v$1.contents | 0;
              return --[[ () ]]0;
            end end));
    end
    end(v$1));
    Caml_array.caml_array_set(arr2, i, (function(v$1)do
        return function (param) do
          vv2.contents = vv2.contents + v$1.contents | 0;
          return --[[ () ]]0;
        end end
        end(v$1)));
  end
  __Array.iter((function (f) do
          return Curry._1(f, --[[ () ]]0);
        end end), arr);
  __Array.iter((function (f) do
          return Curry._1(f, --[[ () ]]0);
        end end), arr2);
  return {--[[ tuple ]]{
            vv.contents,
            __Array.of_list(List.rev(v.contents)),
            vv2.contents
          }};
end end

suites_000 = --[[ tuple ]]{
  "for_loop_test_3",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                90,
                for_3(Caml_array.caml_make_vect(10, 2))
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "for_loop_test_4",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  180,
                  for_4(Caml_array.caml_make_vect(10, 2))
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "for_loop_test_5",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    2420,
                    for_5(Caml_array.caml_make_vect(10, 2), 11)
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "for_loop_test_6",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      {
                        30,
                        1,
                        2,
                        3
                      },
                      for_6(Caml_array.caml_make_vect(3, 0), 0)
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "for_loop_test_7",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        84,
                        for_7(--[[ () ]]0)
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "for_loop_test_8",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          294,
                          for_8(--[[ () ]]0)
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "for_loop_test_9",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            {--[[ tuple ]]{
                                10,
                                {
                                  1,
                                  2,
                                  2,
                                  3
                                },
                                5
                              }},
                            for_9(--[[ () ]]0)
                          });
                end end)
            },
            --[[ [] ]]0
          }
        }
      }
    }
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

exports.for_3 = for_3;
exports.for_4 = for_4;
exports.for_5 = for_5;
exports.for_6 = for_6;
exports.for_7 = for_7;
exports.for_8 = for_8;
exports.for_9 = for_9;
exports.suites = suites;
--[[ No side effect ]]
