__console = {log = print};

U = require "U";
VV = require "VV";
List = require "......lib.js.list";
Curry = require "......lib.js.curry";

function f(x) do
  return (function(param) do
      return x + param | 0;
    end end);
end end

function f1(x, y) do
  return x + y | 0;
end end

function f3(g, x) do
  return Curry._1(g, x);
end end

function f2(param) do
  return 3 + param | 0;
end end

g = 7;

function ff(param) do
  return U.test_primit(3, param);
end end

fff = VV.test_primit2(3);

function length_aux(_len, _param) do
  while(true) do
    param = _param;
    len = _len;
    if (param) then do
      _param = param[2];
      _len = len + 1 | 0;
      ::continue:: ;
    end else do
      return len;
    end end 
  end;
end end

length = List.length;

compare_lengths = List.compare_lengths;

compare_length_with = List.compare_length_with;

cons = List.cons;

hd = List.hd;

tl = List.tl;

nth = List.nth;

nth_opt = List.nth_opt;

rev = List.rev;

init = List.init;

append = List.append;

rev_append = List.rev_append;

concat = List.concat;

flatten = List.flatten;

iter = List.iter;

iteri = List.iteri;

map = List.map;

mapi = List.mapi;

rev_map = List.rev_map;

fold_left = List.fold_left;

fold_right = List.fold_right;

iter2 = List.iter2;

map2 = List.map2;

rev_map2 = List.rev_map2;

fold_left2 = List.fold_left2;

fold_right2 = List.fold_right2;

for_all = List.for_all;

exists = List.exists;

for_all2 = List.for_all2;

exists2 = List.exists2;

mem = List.mem;

memq = List.memq;

find = List.find;

find_opt = List.find_opt;

filter = List.filter;

find_all = List.find_all;

partition = List.partition;

assoc = List.assoc;

assoc_opt = List.assoc_opt;

assq = List.assq;

assq_opt = List.assq_opt;

mem_assoc = List.mem_assoc;

mem_assq = List.mem_assq;

remove_assoc = List.remove_assoc;

remove_assq = List.remove_assq;

split = List.split;

combine = List.combine;

sort = List.sort;

stable_sort = List.stable_sort;

fast_sort = List.fast_sort;

sort_uniq = List.sort_uniq;

merge = List.merge;

exports = {};
exports.f = f;
exports.f1 = f1;
exports.f3 = f3;
exports.f2 = f2;
exports.g = g;
exports.ff = ff;
exports.fff = fff;
exports.length_aux = length_aux;
exports.length = length;
exports.compare_lengths = compare_lengths;
exports.compare_length_with = compare_length_with;
exports.cons = cons;
exports.hd = hd;
exports.tl = tl;
exports.nth = nth;
exports.nth_opt = nth_opt;
exports.rev = rev;
exports.init = init;
exports.append = append;
exports.rev_append = rev_append;
exports.concat = concat;
exports.flatten = flatten;
exports.iter = iter;
exports.iteri = iteri;
exports.map = map;
exports.mapi = mapi;
exports.rev_map = rev_map;
exports.fold_left = fold_left;
exports.fold_right = fold_right;
exports.iter2 = iter2;
exports.map2 = map2;
exports.rev_map2 = rev_map2;
exports.fold_left2 = fold_left2;
exports.fold_right2 = fold_right2;
exports.for_all = for_all;
exports.exists = exists;
exports.for_all2 = for_all2;
exports.exists2 = exists2;
exports.mem = mem;
exports.memq = memq;
exports.find = find;
exports.find_opt = find_opt;
exports.filter = filter;
exports.find_all = find_all;
exports.partition = partition;
exports.assoc = assoc;
exports.assoc_opt = assoc_opt;
exports.assq = assq;
exports.assq_opt = assq_opt;
exports.mem_assoc = mem_assoc;
exports.mem_assq = mem_assq;
exports.remove_assoc = remove_assoc;
exports.remove_assq = remove_assq;
exports.split = split;
exports.combine = combine;
exports.sort = sort;
exports.stable_sort = stable_sort;
exports.fast_sort = fast_sort;
exports.sort_uniq = sort_uniq;
exports.merge = merge;
return exports;
--[[ fff Not a pure module ]]
