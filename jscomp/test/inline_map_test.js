'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function height(param) do
  if (param) do
    return param[4];
  end else do
    return 0;
  end
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          l,
          x,
          d,
          r,
          hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l ? l[4] : 0;
  var hr = r ? r[4] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[3];
      var ld = l[2];
      var lv = l[1];
      var ll = l[0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) do
        return create(create(ll, lv, ld, lr[0]), lr[1], lr[2], create(lr[3], x, d, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[3];
      var rd = r[2];
      var rv = r[1];
      var rl = r[0];
      if (height(rr) >= height(rl)) do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) do
        return create(create(l, x, d, rl[0]), rl[1], rl[2], create(rl[3], rv, rd, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Map.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Map.bal"
          ];
    end
  end else do
    return --[ Node ]--[
            l,
            x,
            d,
            r,
            hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add(x, data, param) do
  if (param) do
    var r = param[3];
    var d = param[2];
    var v = param[1];
    var l = param[0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) do
      return --[ Node ]--[
              l,
              x,
              data,
              r,
              param[4]
            ];
    end else if (c < 0) do
      return bal(add(x, data, l), v, d, r);
    end else do
      return bal(l, v, d, add(x, data, r));
    end
  end else do
    return --[ Node ]--[
            --[ Empty ]--0,
            x,
            data,
            --[ Empty ]--0,
            1
          ];
  end
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = Caml_primitive.caml_int_compare(x, param[1]);
      if (c == 0) do
        return param[2];
      end else do
        _param = c < 0 ? param[0] : param[3];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

var m = List.fold_left((function (acc, param) do
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

Mt.from_pair_suites("Inline_map_test", --[ :: ]--[
      --[ tuple ]--[
        "find",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      find(10, m),
                      --[ "a" ]--97
                    ]);
          end)
      ],
      --[ [] ]--0
    ]);

--[ m Not a pure module ]--
