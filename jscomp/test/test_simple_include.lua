--[['use strict';]]

__Array = require "../../lib/js/array.lua";

v = do
  contents: 32
end;

v.contents = 0;

N = do
  a: 3,
  v: v
end;

v$1 = do
  contents: 32
end;

NN = do
  a: 3,
  v: v$1
end;

make_float = __Array.make_float;

init = __Array.init;

make_matrix = __Array.make_matrix;

create_matrix = __Array.create_matrix;

append = __Array.append;

concat = __Array.concat;

sub = __Array.sub;

copy = __Array.copy;

fill = __Array.fill;

blit = __Array.blit;

to_list = __Array.to_list;

of_list = __Array.of_list;

iter = __Array.iter;

iteri = __Array.iteri;

map = __Array.map;

mapi = __Array.mapi;

fold_left = __Array.fold_left;

fold_right = __Array.fold_right;

iter2 = __Array.iter2;

map2 = __Array.map2;

for_all = __Array.for_all;

exists = __Array.exists;

mem = __Array.mem;

memq = __Array.memq;

sort = __Array.sort;

stable_sort = __Array.stable_sort;

fast_sort = __Array.fast_sort;

Floatarray = __Array.Floatarray;

a = 3;

exports.make_float = make_float;
exports.init = init;
exports.make_matrix = make_matrix;
exports.create_matrix = create_matrix;
exports.append = append;
exports.concat = concat;
exports.sub = sub;
exports.copy = copy;
exports.fill = fill;
exports.blit = blit;
exports.to_list = to_list;
exports.of_list = of_list;
exports.iter = iter;
exports.iteri = iteri;
exports.map = map;
exports.mapi = mapi;
exports.fold_left = fold_left;
exports.fold_right = fold_right;
exports.iter2 = iter2;
exports.map2 = map2;
exports.for_all = for_all;
exports.exists = exists;
exports.mem = mem;
exports.memq = memq;
exports.sort = sort;
exports.stable_sort = stable_sort;
exports.fast_sort = fast_sort;
exports.Floatarray = Floatarray;
exports.N = N;
exports.NN = NN;
exports.a = a;
exports.v = v;
--[[  Not a pure module ]]
