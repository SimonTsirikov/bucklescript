'use strict';

var List = require("../../lib/js/list.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function height(param) do
  if (param) then do
    return param[--[ h ]--4];
  end else do
    return 0;
  end end 
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l and l[--[ h ]--4] or 0;
  var hr = r and r[--[ h ]--4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) then do
        return create(create(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create(lr[--[ r ]--3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) then do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create(create(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create(rl[--[ r ]--3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end end  end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end end 
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr and hl + 1 | 0 or hr + 1 | 0
          ];
  end end  end 
end

function add(x, data, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end end 
    end else if (c < 0) then do
      var ll = add(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal(ll, v, d, r);
      end end 
    end else do
      var rr = add(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end end 
end

List.fold_left((function (acc, param) do
        return add(param[0], param[1], acc);
      end), --[ Empty ]--0, --[ :: ]--[
      --[ tuple ]--[
        10,
        --[ "a" ]--97
      ],
      --[ :: ]--[
        --[ tuple ]--[
          3,
          --[ "b" ]--98
        ],
        --[ :: ]--[
          --[ tuple ]--[
            7,
            --[ "c" ]--99
          ],
          --[ :: ]--[
            --[ tuple ]--[
              20,
              --[ "d" ]--100
            ],
            --[ [] ]--0
          ]
        ]
      ]
    ]);

--[  Not a pure module ]--
