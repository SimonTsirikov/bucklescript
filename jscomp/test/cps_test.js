'use strict';

Mt = require("./mt.js");
$$Array = require("../../lib/js/array.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_array = require("../../lib/js/caml_array.js");

function test(param) do
  v = do
    contents: 0
  end;
  f = function (_n, _acc) do
    while(true) do
      acc = _acc;
      n = _n;
      if (n == 0) then do
        return Curry._1(acc, --[ () ]--0);
      end else do
        _acc = (function(n,acc)do
        return function (param) do
          v.contents = v.contents + n | 0;
          return Curry._1(acc, --[ () ]--0);
        end
        end(n,acc));
        _n = n - 1 | 0;
        continue ;
      end end 
    end;
  end;
  f(10, (function (param) do
          return --[ () ]--0;
        end));
  return v.contents;
end

function test_closure(param) do
  v = do
    contents: 0
  end;
  arr = Caml_array.caml_make_vect(6, (function (x) do
          return x;
        end));
  for i = 0 , 5 , 1 do
    Caml_array.caml_array_set(arr, i, (function(i)do
        return function (param) do
          return i;
        end
        end(i)));
  end
  $$Array.iter((function (i) do
          v.contents = v.contents + Curry._1(i, 0) | 0;
          return --[ () ]--0;
        end), arr);
  return v.contents;
end

function test_closure2(param) do
  v = do
    contents: 0
  end;
  arr = Caml_array.caml_make_vect(6, (function (x) do
          return x;
        end));
  for i = 0 , 5 , 1 do
    j = i + i | 0;
    Caml_array.caml_array_set(arr, i, (function(j)do
        return function (param) do
          return j;
        end
        end(j)));
  end
  $$Array.iter((function (i) do
          v.contents = v.contents + Curry._1(i, 0) | 0;
          return --[ () ]--0;
        end), arr);
  return v.contents;
end

Mt.from_pair_suites("Cps_test", --[ :: ]--[
      --[ tuple ]--[
        "cps_test_sum",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      55,
                      test(--[ () ]--0)
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "cps_test_closure",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        15,
                        test_closure(--[ () ]--0)
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "cps_test_closure2",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          30,
                          test_closure2(--[ () ]--0)
                        ]);
              end)
          ],
          --[ [] ]--0
        ]
      ]
    ]);

exports.test = test;
exports.test_closure = test_closure;
exports.test_closure2 = test_closure2;
--[  Not a pure module ]--
