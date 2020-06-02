--[['use strict';]]

__Array = require "../../lib/js/array.lua";
Curry = require "../../lib/js/curry.lua";
__String = require "../../lib/js/string.lua";
MoreLabels = require "../../lib/js/moreLabels.lua";

function f(x) do
  return x;
end end

XX = do
  make_float: __Array.make_float,
  init: __Array.init,
  make_matrix: __Array.make_matrix,
  create_matrix: __Array.create_matrix,
  append: __Array.append,
  concat: __Array.concat,
  sub: __Array.sub,
  copy: __Array.copy,
  fill: __Array.fill,
  blit: __Array.blit,
  to_list: __Array.to_list,
  of_list: __Array.of_list,
  iter: __Array.iter,
  iteri: __Array.iteri,
  map: __Array.map,
  mapi: __Array.mapi,
  fold_left: __Array.fold_left,
  fold_right: __Array.fold_right,
  iter2: __Array.iter2,
  map2: __Array.map2,
  for_all: __Array.for_all,
  exists: __Array.exists,
  mem: __Array.mem,
  memq: __Array.memq,
  sort: __Array.sort,
  stable_sort: __Array.stable_sort,
  fast_sort: __Array.fast_sort,
  Floatarray: __Array.Floatarray,
  f: f
end;

u = {__String};

ghh = Curry._2(MoreLabels.Hashtbl.create, undefined, 30);

hh = 1;

exports.XX = XX;
exports.u = u;
exports.hh = hh;
exports.ghh = ghh;
--[[ ghh Not a pure module ]]
