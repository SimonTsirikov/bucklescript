--[['use strict';]]

__Array = require "../../lib/js/array.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Format = require "../../lib/js/format.lua";
Caml_obj = require "../../lib/js/caml_obj.lua";
Caml_array = require "../../lib/js/caml_array.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function sub(_tr, _k) do
  while(true) do
    k = _k;
    tr = _tr;
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
end end

function update(tr, k, w) do
  if (tr) then do
    r = tr[2];
    l = tr[1];
    if (k == 1) then do
      return --[[ Br ]][
              w,
              l,
              r
            ];
    end else do
      v = tr[0];
      if (k % 2 == 0) then do
        return --[[ Br ]][
                v,
                update(l, k / 2 | 0, w),
                r
              ];
      end else do
        return --[[ Br ]][
                v,
                l,
                update(r, k / 2 | 0, w)
              ];
      end end 
    end end 
  end else if (k == 1) then do
    return --[[ Br ]][
            w,
            --[[ Lf ]]0,
            --[[ Lf ]]0
          ];
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end  end 
end end

function __delete(tr, n) do
  if (tr) then do
    if (n == 1) then do
      return --[[ Lf ]]0;
    end else do
      r = tr[2];
      l = tr[1];
      v = tr[0];
      if (n % 2 == 0) then do
        return --[[ Br ]][
                v,
                __delete(l, n / 2 | 0),
                r
              ];
      end else do
        return --[[ Br ]][
                v,
                l,
                __delete(r, n / 2 | 0)
              ];
      end end 
    end end 
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end end

function loext(tr, w) do
  if (tr) then do
    return --[[ Br ]][
            w,
            loext(tr[2], tr[0]),
            tr[1]
          ];
  end else do
    return --[[ Br ]][
            w,
            --[[ Lf ]]0,
            --[[ Lf ]]0
          ];
  end end 
end end

function lorem(tr) do
  if (tr) then do
    l = tr[1];
    if (l) then do
      return --[[ Br ]][
              l[0],
              tr[2],
              lorem(l)
            ];
    end else if (tr[2]) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "flexible_array_test.ml",
              66,
              9
            ]
          ];
    end else do
      return --[[ Lf ]]0;
    end end  end 
  end else do
    throw Caml_builtin_exceptions.not_found;
  end end 
end end

empty = --[[ tuple ]][
  --[[ Lf ]]0,
  0
];

function length(param) do
  return param[1];
end end

function get(param, i) do
  if (i >= 0 and i < param[1]) then do
    return sub(param[0], i + 1 | 0);
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.get"
        ];
  end end 
end end

function set(param, i, v) do
  k = param[1];
  if (i >= 0 and i < k) then do
    return --[[ tuple ]][
            update(param[0], i + 1 | 0, v),
            k
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.set"
        ];
  end end 
end end

function push_front(param, v) do
  return --[[ tuple ]][
          loext(param[0], v),
          param[1] + 1 | 0
        ];
end end

function pop_front(param) do
  k = param[1];
  if (k > 0) then do
    return --[[ tuple ]][
            lorem(param[0]),
            k - 1 | 0
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.pop_front"
        ];
  end end 
end end

function push_back(param, v) do
  k = param[1];
  return --[[ tuple ]][
          update(param[0], k + 1 | 0, v),
          k + 1 | 0
        ];
end end

function pop_back(param) do
  k = param[1];
  if (k > 0) then do
    return --[[ tuple ]][
            __delete(param[0], k),
            k - 1 | 0
          ];
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Array.pop_back"
        ];
  end end 
end end

function pp(fmt, s) do
  v = "[ ";
  for i = 0 , length(s) - 1 | 0 , 1 do
    v = v .. (", " .. String(get(s, i)));
  end
  v = v .. "]";
  return Curry._1(Format.fprintf(fmt, --[[ Format ]][
                  --[[ String ]]Block.__(2, [
                      --[[ No_padding ]]0,
                      --[[ End_of_format ]]0
                    ]),
                  "%s"
                ]), v);
end end

function filter_from(i, p, s) do
  u = empty;
  for i$1 = i , length(s) - 1 | 0 , 1 do
    ele = get(s, i$1);
    if (Curry._1(p, ele)) then do
      u = push_back(u, ele);
    end
     end 
  end
  return u;
end end

function append(a, b) do
  empty$1 = empty;
  for i = 0 , length(a) - 1 | 0 , 1 do
    empty$1 = push_back(empty$1, get(a, i));
  end
  for i$1 = 0 , length(b) - 1 | 0 , 1 do
    empty$1 = push_back(empty$1, get(b, i$1));
  end
  return empty$1;
end end

function sort(s) do
  size = length(s);
  if (size <= 1) then do
    return s;
  end else do
    head = get(s, 0);
    larger = sort(filter_from(1, (function (x) do
                return Caml_obj.caml_greaterthan(x, head);
              end end), s));
    smaller = sort(filter_from(1, (function (x) do
                return Caml_obj.caml_lessequal(x, head);
              end end), s));
    return append(smaller, push_front(larger, head));
  end end 
end end

function of_array(arr) do
  v = empty;
  for i = 0 , #arr - 1 | 0 , 1 do
    v = push_back(v, Caml_array.caml_array_get(arr, i));
  end
  return v;
end end

equal = Caml_obj.caml_equal;

Int_array = do
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
end end

u = of_array([
      1,
      2,
      2,
      5,
      3,
      6
    ]);

x = sort(u);

if (not Caml_obj.caml_equal(x, of_array([
            1,
            2,
            2,
            3,
            5,
            6
          ]))) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "flexible_array_test.ml",
          166,
          4
        ]
      ];
end
 end 

v = __Array.init(500, (function (i) do
        return 500 - i | 0;
      end end));

y = __Array.init(500, (function (i) do
        return i + 1 | 0;
      end end));

x$1 = sort(of_array(v));

Caml_obj.caml_equal(x$1, of_array(y));

exports.sub = sub;
exports.update = update;
exports.__delete = __delete;
exports.loext = loext;
exports.lorem = lorem;
exports.Int_array = Int_array;
exports.$eq$tilde = $eq$tilde;
--[[ u Not a pure module ]]
