'use strict';

var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Format = require("../../lib/js/format.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function sub(_tr, _k) do
  while(true) do
    var k = _k;
    var tr = _tr;
    if (tr) then do
      if (k == 1) then do
        return tr[0];
      end else do
        _k = k / 2 | 0;
        if (k % 2 == 0) then do
          _tr = tr[1];
          continue ;
        end else do
          _tr = tr[2];
          continue ;
        end end 
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function update(tr, k, w) do
  if (tr) then do
    var r = tr[2];
    var l = tr[1];
    if (k == 1) then do
      return --[ Br ]--[
              w,
              l,
              r
            ];
    end else do
      var v = tr[0];
      if (k % 2 == 0) then do
        return --[ Br ]--[
                v,
                update(l, k / 2 | 0, w),
                r
              ];
      end else do
        return --[ Br ]--[
                v,
                l,
                update(r, k / 2 | 0, w)
              ];
      end end 
    end end 
  end else if (k == 1) then do
    return --[ Br ]--[
            w,
            --[ Lf ]--0,
            --[ Lf ]--0
          ];
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end  end 
end

function $$delete(tr, n) do
  if (tr) then do
    if (n == 1) then do
      return --[ Lf ]--0;
    end else do
      var r = tr[2];
      var l = tr[1];
      var v = tr[0];
      if (n % 2 == 0) then do
        return --[ Br ]--[
                v,
                $$delete(l, n / 2 | 0),
                r
              ];
      end else do
        return --[ Br ]--[
                v,
                l,
                $$delete(r, n / 2 | 0)
              ];
      end end 
    end end 
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end

function loext(tr, w) do
  if (tr) then do
    return --[ Br ]--[
            w,
            loext(tr[2], tr[0]),
            tr[1]
          ];
  end else do
    return --[ Br ]--[
            w,
            --[ Lf ]--0,
            --[ Lf ]--0
          ];
  end end 
end

function lorem(tr) do
  if (tr) then do
    var l = tr[1];
    if (l) then do
      return --[ Br ]--[
              l[0],
              tr[2],
              lorem(l)
            ];
    end else if (tr[2]) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "flexible_array_test.ml",
              66,
              9
            ]
          ];
    end else do
      return --[ Lf ]--0;
    end end  end 
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end

var empty = --[ tuple ]--[
  --[ Lf ]--0,
  0
];

function length(param) do
  return param[1];
end

function get(param, i) do
  if (i >= 0 and i < param[1]) then do
    return sub(param[0], i + 1 | 0);
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.get"
        ];
  end end 
end

function set(param, i, v) do
  var k = param[1];
  if (i >= 0 and i < k) then do
    return --[ tuple ]--[
            update(param[0], i + 1 | 0, v),
            k
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.set"
        ];
  end end 
end

function push_front(param, v) do
  return --[ tuple ]--[
          loext(param[0], v),
          param[1] + 1 | 0
        ];
end

function pop_front(param) do
  var k = param[1];
  if (k > 0) then do
    return --[ tuple ]--[
            lorem(param[0]),
            k - 1 | 0
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.pop_front"
        ];
  end end 
end

function push_back(param, v) do
  var k = param[1];
  return --[ tuple ]--[
          update(param[0], k + 1 | 0, v),
          k + 1 | 0
        ];
end

function pop_back(param) do
  var k = param[1];
  if (k > 0) then do
    return --[ tuple ]--[
            $$delete(param[0], k),
            k - 1 | 0
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.pop_back"
        ];
  end end 
end

function pp(fmt, s) do
  var v = "[ ";
  for(var i = 0 ,i_finish = length(s) - 1 | 0; i <= i_finish; ++i)do
    v = v .. (", " .. String(get(s, i)));
  end
  v = v .. "]";
  return Curry._1(Format.fprintf(fmt, --[ Format ]--[
                  --[ String ]--Block.__(2, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%s"
                ]), v);
end

function filter_from(i, p, s) do
  var u = empty;
  for(var i$1 = i ,i_finish = length(s) - 1 | 0; i$1 <= i_finish; ++i$1)do
    var ele = get(s, i$1);
    if (Curry._1(p, ele)) then do
      u = push_back(u, ele);
    end
     end 
  end
  return u;
end

function append(a, b) do
  var empty$1 = empty;
  for(var i = 0 ,i_finish = length(a) - 1 | 0; i <= i_finish; ++i)do
    empty$1 = push_back(empty$1, get(a, i));
  end
  for(var i$1 = 0 ,i_finish$1 = length(b) - 1 | 0; i$1 <= i_finish$1; ++i$1)do
    empty$1 = push_back(empty$1, get(b, i$1));
  end
  return empty$1;
end

function sort(s) do
  var size = length(s);
  if (size <= 1) then do
    return s;
  end else do
    var head = get(s, 0);
    var larger = sort(filter_from(1, (function (x) do
                return Caml_obj.caml_greaterthan(x, head);
              end), s));
    var smaller = sort(filter_from(1, (function (x) do
                return Caml_obj.caml_lessequal(x, head);
              end), s));
    return append(smaller, push_front(larger, head));
  end end 
end

function of_array(arr) do
  var v = empty;
  for(var i = 0 ,i_finish = #arr - 1 | 0; i <= i_finish; ++i)do
    v = push_back(v, Caml_array.caml_array_get(arr, i));
  end
  return v;
end

var equal = Caml_obj.caml_equal;

var Int_array = do
  empty: empty,
  get: get,
  set: set,
  push_front: push_front,
  pop_front: pop_front,
  push_back: push_back,
  pop_back: pop_back,
  pp: pp,
  append: append,
  sort: sort,
  of_array: of_array,
  equal: equal
end;

function $eq$tilde(x, y) do
  return Caml_obj.caml_equal(x, of_array(y));
end

var u = of_array([
      1,
      2,
      2,
      5,
      3,
      6
    ]);

var x = sort(u);

if (!Caml_obj.caml_equal(x, of_array([
            1,
            2,
            2,
            3,
            5,
            6
          ]))) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "flexible_array_test.ml",
          166,
          4
        ]
      ];
end
 end 

var v = $$Array.init(500, (function (i) do
        return 500 - i | 0;
      end));

var y = $$Array.init(500, (function (i) do
        return i + 1 | 0;
      end));

var x$1 = sort(of_array(v));

Caml_obj.caml_equal(x$1, of_array(y));

exports.sub = sub;
exports.update = update;
exports.$$delete = $$delete;
exports.loext = loext;
exports.lorem = lorem;
exports.Int_array = Int_array;
exports.$eq$tilde = $eq$tilde;
--[ u Not a pure module ]--
