'use strict';

Mt = require("./mt.js");
$$Array = require("../../lib/js/array.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
String_set = require("./string_set.js");
Caml_option = require("../../lib/js/caml_option.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
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
        end end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end end

a = { };

b = do
  foo: "42"
end;

function map(f, x) do
  if (x ~= undefined) then do
    return Caml_option.some(Curry._1(f, Caml_option.valFromOption(x)));
  end
   end 
end end

function make(foo) do
  partial_arg = map((function (prim) do
          return String(prim);
        end end), foo);
  return (function (param) do
      tmp = { };
      if (partial_arg ~= undefined) then do
        tmp.foo = Caml_option.valFromOption(partial_arg);
      end
       end 
      return tmp;
    end end);
end end

a_ = make(undefined)(--[ () ]--0);

b_ = make(42)(--[ () ]--0);

eq("File \"gpr_1409_test.ml\", line 30, characters 6-13", b_.foo, "42");

console.log(Object.keys(a_));

console.log(a, b, a_, b_);

eq("File \"gpr_1409_test.ml\", line 36, characters 6-13", #Object.keys(a_), 0);

test2 = do
  hi: 2
end;

function test3(_open, xx__hi) do
  console.log("no inlin");
  tmp = do
    hi: 2
  end;
  if (_open ~= undefined) then do
    tmp.open = Caml_option.valFromOption(_open);
  end
   end 
  if (xx__hi ~= undefined) then do
    tmp.xx = Caml_option.valFromOption(xx__hi);
  end
   end 
  return tmp;
end end

function test4(_open, xx__hi) do
  console.log("no inlin");
  tmp = do
    open: _open,
    hi: 2
  end;
  if (xx__hi ~= undefined) then do
    tmp.xx = Caml_option.valFromOption(xx__hi);
  end
   end 
  return tmp;
end end

function test5(f, x) do
  console.log("no inline");
  tmp = do
    hi: 2
  end;
  tmp$1 = Curry._1(f, x);
  if (tmp$1 ~= undefined) then do
    tmp.open = Caml_option.valFromOption(tmp$1);
  end
   end 
  tmp$2 = Curry._1(f, x);
  if (tmp$2 ~= undefined) then do
    tmp.xx = Caml_option.valFromOption(tmp$2);
  end
   end 
  return tmp;
end end

function test6(f, x) do
  console.log("no inline");
  x$1 = do
    contents: 3
  end;
  tmp = do
    hi: 2
  end;
  tmp$1 = (x$1.contents = x$1.contents + 1 | 0, x$1.contents);
  if (tmp$1 ~= undefined) then do
    tmp.open = Caml_option.valFromOption(tmp$1);
  end
   end 
  tmp$2 = f(x$1);
  if (tmp$2 ~= undefined) then do
    tmp.xx = Caml_option.valFromOption(tmp$2);
  end
   end 
  return tmp;
end end

function keys(xs, ys) do
  return String_set.equal(String_set.of_list(xs), String_set.of_list($$Array.to_list(ys)));
end end

eq("File \"gpr_1409_test.ml\", line 69, characters 6-13", keys(--[ :: ]--[
          "hi",
          --[ [] ]--0
        ], Object.keys(test3(undefined, undefined))), true);

eq("File \"gpr_1409_test.ml\", line 71, characters 6-13", keys(--[ :: ]--[
          "hi",
          --[ :: ]--[
            "open",
            --[ [] ]--0
          ]
        ], Object.keys(test3(2, undefined))), true);

eq("File \"gpr_1409_test.ml\", line 73, characters 6-13", keys(--[ :: ]--[
          "hi",
          --[ :: ]--[
            "open",
            --[ :: ]--[
              "xx",
              --[ [] ]--0
            ]
          ]
        ], Object.keys(test3(2, 2))), true);

Mt.from_pair_suites("Gpr_1409_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.a = a;
exports.b = b;
exports.map = map;
exports.make = make;
exports.a_ = a_;
exports.b_ = b_;
exports.test2 = test2;
exports.test3 = test3;
exports.test4 = test4;
exports.test5 = test5;
exports.test6 = test6;
exports.keys = keys;
--[ a_ Not a pure module ]--
