'use strict';

$$Array = require("../../lib/js/array.js");

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

make_float = $$Array.make_float;

init = $$Array.init;

make_matrix = $$Array.make_matrix;

create_matrix = $$Array.create_matrix;

append = $$Array.append;

concat = $$Array.concat;

sub = $$Array.sub;

copy = $$Array.copy;

fill = $$Array.fill;

blit = $$Array.blit;

to_list = $$Array.to_list;

of_list = $$Array.of_list;

iter = $$Array.iter;

iteri = $$Array.iteri;

map = $$Array.map;

mapi = $$Array.mapi;

fold_left = $$Array.fold_left;

fold_right = $$Array.fold_right;

iter2 = $$Array.iter2;

map2 = $$Array.map2;

for_all = $$Array.for_all;

exists = $$Array.exists;

mem = $$Array.mem;

memq = $$Array.memq;

sort = $$Array.sort;

stable_sort = $$Array.stable_sort;

fast_sort = $$Array.fast_sort;

Floatarray = $$Array.Floatarray;

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
--[  Not a pure module ]--
