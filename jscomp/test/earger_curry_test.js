'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function map(f, a) do
  var f$1 = Curry.__1(f);
  var a$1 = a;
  var l = #a$1;
  if (l == 0) then do
    return [];
  end else do
    var r = Caml_array.caml_make_vect(l, f$1(a$1[0]));
    for(var i = 1 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = f$1(a$1[i]);
    end
    return r;
  end end 
end

function init(l, f) do
  var l$1 = l;
  var f$1 = Curry.__1(f);
  if (l$1 == 0) then do
    return [];
  end else do
    if (l$1 < 0) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Array.init"
          ];
    end
     end 
    var res = Caml_array.caml_make_vect(l$1, f$1(0));
    for(var i = 1 ,i_finish = l$1 - 1 | 0; i <= i_finish; ++i)do
      res[i] = f$1(i);
    end
    return res;
  end end 
end

function fold_left(f, x, a) do
  var f$1 = Curry.__2(f);
  var x$1 = x;
  var a$1 = a;
  var r = x$1;
  for(var i = 0 ,i_finish = #a$1 - 1 | 0; i <= i_finish; ++i)do
    r = f$1(r, a$1[i]);
  end
  return r;
end

function f2(param) do
  var arr = init(30000000, (function (i) do
          return i;
        end));
  var b = map((function (i) do
          return i + i - 1;
        end), arr);
  var v = fold_left((function (prim, prim$1) do
          return prim + prim$1;
        end), 0, b);
  console.log(Pervasives.string_of_float(v));
  return --[ () ]--0;
end

f2(--[ () ]--0);

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

var v = do
  contents: 0
end;

var all_v = do
  contents: --[ [] ]--0
end;

function add5(a0, a1, a2, a3, a4) do
  console.log(--[ tuple ]--[
        a0,
        a1,
        a2,
        a3,
        a4
      ]);
  all_v.contents = --[ :: ]--[
    v.contents,
    all_v.contents
  ];
  return (((a0 + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0;
end

function f(x) do
  v.contents = v.contents + 1 | 0;
  var partial_arg = 2;
  v.contents = v.contents + 1 | 0;
  var partial_arg$1 = 1;
  return (function (param, param$1) do
      return add5(x, partial_arg$1, partial_arg, param, param$1);
    end);
end

function g(x) do
  v.contents = v.contents + 1 | 0;
  var partial_arg = 2;
  v.contents = v.contents + 1 | 0;
  var partial_arg$1 = 1;
  var u = function (param, param$1) do
    return add5(x, partial_arg$1, partial_arg, param, param$1);
  end;
  all_v.contents = --[ :: ]--[
    v.contents,
    all_v.contents
  ];
  return u;
end

var a = f(0)(3, 4);

var b = f(0)(3, 5);

var c = Curry._2(g(0), 3, 4);

var d = Curry._2(g(0), 3, 5);

eq("File \"earger_curry_test.ml\", line 118, characters 7-14", a, 10);

eq("File \"earger_curry_test.ml\", line 119, characters 7-14", b, 11);

eq("File \"earger_curry_test.ml\", line 120, characters 7-14", c, 10);

eq("File \"earger_curry_test.ml\", line 121, characters 7-14", d, 11);

eq("File \"earger_curry_test.ml\", line 122, characters 7-14", all_v.contents, --[ :: ]--[
      8,
      --[ :: ]--[
        8,
        --[ :: ]--[
          6,
          --[ :: ]--[
            6,
            --[ :: ]--[
              4,
              --[ :: ]--[
                2,
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ]
    ]);

Mt.from_pair_suites("Earger_curry_test", suites.contents);

exports.map = map;
exports.init = init;
exports.fold_left = fold_left;
exports.f2 = f2;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.v = v;
exports.all_v = all_v;
exports.add5 = add5;
exports.f = f;
exports.g = g;
exports.a = a;
exports.b = b;
exports.c = c;
exports.d = d;
--[  Not a pure module ]--
