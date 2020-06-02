console = {log = print};

Curry = require "../../lib/js/curry";
Caml_option = require "../../lib/js/caml_option";

console.log(--[[ tuple ]]{
      "hello world",
      1
    });

console.log(1337);

console.log("hello world");

arg_string = --[[ `String ]]{
  -976970511,
  "hi runtime"
};

console.log(arg_string[1]);

arg_pair = --[[ `Pair ]]{
  892012602,
  --[[ tuple ]]{
    "hi",
    1
  }
};

console.log(arg_pair[1]);

console.log(--[[ () ]]0);

console.log(1, undefined);

console.log(2, "hi");

console.log(3, "hi");

console.log(4, undefined);

some_arg = --[[ `Bool ]]{
  737456202,
  true
};

console.log(5, some_arg ~= undefined and Caml_option.valFromOption(some_arg)[1] or undefined);

console.log(6, undefined);

console.log(7, Caml_option.option_get_unwrap((console.log("trace"), undefined)));

function dyn_log3(prim, prim_1, prim_2) do
  console.log(prim[1], prim_1 ~= undefined and Caml_option.valFromOption(prim_1)[1] or undefined);
  return --[[ () ]]0;
end end

dyn_log3(--[[ `Int ]]{
      3654863,
      8
    }, --[[ `Bool ]]{
      737456202,
      true
    }, --[[ () ]]0);

console.log("foo");

console.log(do
      foo: 1
    end);

function dyn_log4(prim) do
  console.log(prim[1]);
  return --[[ () ]]0;
end end

console.log(do
      foo: 2
    end);

function f(x) do
  console.log(x[1]);
  return --[[ () ]]0;
end end

function ff0(x, p) do
  console.log(x ~= undefined and Caml_option.valFromOption(x)[1] or undefined, p);
  return --[[ () ]]0;
end end

function ff1(x, p) do
  console.log(Caml_option.option_get_unwrap(Curry._1(x, --[[ () ]]0)), p);
  return --[[ () ]]0;
end end

none_arg = undefined;

exports = {}
exports.arg_string = arg_string;
exports.arg_pair = arg_pair;
exports.some_arg = some_arg;
exports.none_arg = none_arg;
exports.dyn_log3 = dyn_log3;
exports.dyn_log4 = dyn_log4;
exports.f = f;
exports.ff0 = ff0;
exports.ff1 = ff1;
--[[  Not a pure module ]]