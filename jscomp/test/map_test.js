'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function height(param) do
  if (param) do
    return param[--[ h ]--4];
  end else do
    return 0;
  end
end

function create(l, x, d, r) do
  var hl = height(l);
  var hr = height(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l ? l[--[ h ]--4] : 0;
  var hr = r ? r[--[ h ]--4] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, ld, create(lr, x, d, r));
      end else if (lr) do
        return create(create(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create(lr[--[ r ]--3], x, d, r));
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
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) do
        return create(create(l, x, d, rl), rv, rd, rr);
      end else if (rl) do
        return create(create(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create(rl[--[ r ]--3], rv, rd, rr));
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
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add(x, data, m) do
  if (m) do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) do
      if (d == data) do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end
    end else if (c < 0) do
      var ll = add(x, data, l);
      if (l == ll) do
        return m;
      end else do
        return bal(ll, v, d, r);
      end
    end else do
      var rr = add(x, data, r);
      if (r == rr) do
        return m;
      end else do
        return bal(l, v, d, rr);
      end
    end
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end
end

function cons_enum(_m, _e) do
  while(true) do
    var e = _e;
    var m = _m;
    if (m) do
      _e = --[ More ]--[
        m[--[ v ]--1],
        m[--[ d ]--2],
        m[--[ r ]--3],
        e
      ];
      _m = m[--[ l ]--0];
      continue ;
    end else do
      return e;
    end
  end;
end

function compare(cmp, m1, m2) do
  var _e1 = cons_enum(m1, --[ End ]--0);
  var _e2 = cons_enum(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) do
      if (e2) do
        var c = Caml_primitive.caml_int_compare(e1[0], e2[0]);
        if (c ~= 0) do
          return c;
        end else do
          var c$1 = Curry._2(cmp, e1[1], e2[1]);
          if (c$1 ~= 0) do
            return c$1;
          end else do
            _e2 = cons_enum(e2[2], e2[3]);
            _e1 = cons_enum(e1[2], e1[3]);
            continue ;
          end
        end
      end else do
        return 1;
      end
    end else if (e2) do
      return -1;
    end else do
      return 0;
    end
  end;
end

function equal(cmp, m1, m2) do
  var _e1 = cons_enum(m1, --[ End ]--0);
  var _e2 = cons_enum(m2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) do
      if (e2 and e1[0] == e2[0] and Curry._2(cmp, e1[1], e2[1])) do
        _e2 = cons_enum(e2[2], e2[3]);
        _e1 = cons_enum(e1[2], e1[3]);
        continue ;
      end else do
        return false;
      end
    end else if (e2) do
      return false;
    end else do
      return true;
    end
  end;
end

function cardinal(param) do
  if (param) do
    return (cardinal(param[--[ l ]--0]) + 1 | 0) + cardinal(param[--[ r ]--3]) | 0;
  end else do
    return 0;
  end
end

function height$1(param) do
  if (param) do
    return param[--[ h ]--4];
  end else do
    return 0;
  end
end

function create$1(l, x, d, r) do
  var hl = height$1(l);
  var hr = height$1(r);
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--x,
          --[ d ]--d,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal$1(l, x, d, r) do
  var hl = l ? l[--[ h ]--4] : 0;
  var hr = r ? r[--[ h ]--4] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[--[ r ]--3];
      var ld = l[--[ d ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height$1(ll) >= height$1(lr)) do
        return create$1(ll, lv, ld, create$1(lr, x, d, r));
      end else if (lr) do
        return create$1(create$1(ll, lv, ld, lr[--[ l ]--0]), lr[--[ v ]--1], lr[--[ d ]--2], create$1(lr[--[ r ]--3], x, d, r));
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
      var rr = r[--[ r ]--3];
      var rd = r[--[ d ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height$1(rr) >= height$1(rl)) do
        return create$1(create$1(l, x, d, rl), rv, rd, rr);
      end else if (rl) do
        return create$1(create$1(l, x, d, rl[--[ l ]--0]), rl[--[ v ]--1], rl[--[ d ]--2], create$1(rl[--[ r ]--3], rv, rd, rr));
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
            --[ l ]--l,
            --[ v ]--x,
            --[ d ]--d,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add$1(x, data, m) do
  if (m) do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) do
      if (d == data) do
        return m;
      end else do
        return --[ Node ]--[
                --[ l ]--l,
                --[ v ]--x,
                --[ d ]--data,
                --[ r ]--r,
                --[ h ]--m[--[ h ]--4]
              ];
      end
    end else if (c < 0) do
      var ll = add$1(x, data, l);
      if (l == ll) do
        return m;
      end else do
        return bal$1(ll, v, d, r);
      end
    end else do
      var rr = add$1(x, data, r);
      if (r == rr) do
        return m;
      end else do
        return bal$1(l, v, d, rr);
      end
    end
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ d ]--data,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) do
        return param[--[ d ]--2];
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--3];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function of_list(kvs) do
  return List.fold_left((function (acc, param) do
                return add(param[0], param[1], acc);
              end), --[ Empty ]--0, kvs);
end

var int_map_suites_000 = --[ tuple ]--[
  "add",
  (function (param) do
      var v = of_list(--[ :: ]--[
            --[ tuple ]--[
              1,
              --[ "1" ]--49
            ],
            --[ :: ]--[
              --[ tuple ]--[
                2,
                --[ "3" ]--51
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  3,
                  --[ "4" ]--52
                ],
                --[ [] ]--0
              ]
            ]
          ]);
      return --[ Eq ]--Block.__(0, [
                cardinal(v),
                3
              ]);
    end)
];

var int_map_suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "equal",
    (function (param) do
        var v = of_list(--[ :: ]--[
              --[ tuple ]--[
                1,
                --[ "1" ]--49
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  2,
                  --[ "3" ]--51
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    3,
                    --[ "4" ]--52
                  ],
                  --[ [] ]--0
                ]
              ]
            ]);
        var u = of_list(--[ :: ]--[
              --[ tuple ]--[
                2,
                --[ "3" ]--51
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  3,
                  --[ "4" ]--52
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    1,
                    --[ "1" ]--49
                  ],
                  --[ [] ]--0
                ]
              ]
            ]);
        return --[ Eq ]--Block.__(0, [
                  compare(Caml_primitive.caml_int_compare, u, v),
                  0
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "equal2",
      (function (param) do
          var v = of_list(--[ :: ]--[
                --[ tuple ]--[
                  1,
                  --[ "1" ]--49
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    2,
                    --[ "3" ]--51
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      3,
                      --[ "4" ]--52
                    ],
                    --[ [] ]--0
                  ]
                ]
              ]);
          var u = of_list(--[ :: ]--[
                --[ tuple ]--[
                  2,
                  --[ "3" ]--51
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    3,
                    --[ "4" ]--52
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      1,
                      --[ "1" ]--49
                    ],
                    --[ [] ]--0
                  ]
                ]
              ]);
          return --[ Eq ]--Block.__(0, [
                    true,
                    equal((function (x, y) do
                            return x == y;
                          end), u, v)
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "iteration",
        (function (param) do
            var m = --[ Empty ]--0;
            for(var i = 0; i <= 10000; ++i)do
              m = add$1(String(i), String(i), m);
            end
            var v = -1;
            for(var i$1 = 0; i$1 <= 10000; ++i$1)do
              if (find(String(i$1), m) ~= String(i$1)) do
                v = i$1;
              end
              
            end
            return --[ Eq ]--Block.__(0, [
                      v,
                      -1
                    ]);
          end)
      ],
      --[ [] ]--0
    ]
  ]
];

var int_map_suites = --[ :: ]--[
  int_map_suites_000,
  int_map_suites_001
];

Mt.from_pair_suites("Map_test", int_map_suites);

--[  Not a pure module ]--
