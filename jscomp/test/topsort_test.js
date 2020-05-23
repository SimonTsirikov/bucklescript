'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");
var $$String = require("../../lib/js/string.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var graph = --[ :: ]--[
  --[ tuple ]--[
    "a",
    "b"
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "a",
      "c"
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "a",
        "d"
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "b",
          "e"
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "c",
            "f"
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "d",
              "e"
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "e",
                "f"
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "e",
                  "g"
                ],
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ]
    ]
  ]
];

function nexts(x, g) do
  return List.fold_left((function (acc, param) do
                if (param[0] == x) do
                  return --[ :: ]--[
                          param[1],
                          acc
                        ];
                end else do
                  return acc;
                end
              end), --[ [] ]--0, g);
end

function dfs1(_nodes, graph, _visited) do
  while(true) do
    var visited = _visited;
    var nodes = _nodes;
    if (nodes) do
      var xs = nodes[1];
      var x = nodes[0];
      if (List.mem(x, visited)) do
        _nodes = xs;
        continue ;
      end else do
        console.log(x);
        _visited = --[ :: ]--[
          x,
          visited
        ];
        _nodes = Pervasives.$at(nexts(x, graph), xs);
        continue ;
      end
    end else do
      return List.rev(visited);
    end
  end;
end

if (!Caml_obj.caml_equal(dfs1(--[ :: ]--[
            "a",
            --[ [] ]--0
          ], graph, --[ [] ]--0), --[ :: ]--[
        "a",
        --[ :: ]--[
          "d",
          --[ :: ]--[
            "e",
            --[ :: ]--[
              "g",
              --[ :: ]--[
                "f",
                --[ :: ]--[
                  "c",
                  --[ :: ]--[
                    "b",
                    --[ [] ]--0
                  ]
                ]
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          29,
          2
        ]
      ];
end

Pervasives.print_newline(--[ () ]--0);

if (!Caml_obj.caml_equal(dfs1(--[ :: ]--[
            "b",
            --[ [] ]--0
          ], --[ :: ]--[
            --[ tuple ]--[
              "f",
              "d"
            ],
            graph
          ], --[ [] ]--0), --[ :: ]--[
        "b",
        --[ :: ]--[
          "e",
          --[ :: ]--[
            "g",
            --[ :: ]--[
              "f",
              --[ :: ]--[
                "d",
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          32,
          2
        ]
      ];
end

function dfs2(nodes, graph, visited) do
  var aux = function (_nodes, graph, _visited) do
    while(true) do
      var visited = _visited;
      var nodes = _nodes;
      if (nodes) do
        var xs = nodes[1];
        var x = nodes[0];
        if (List.mem(x, visited)) do
          _nodes = xs;
          continue ;
        end else do
          _visited = aux(nexts(x, graph), graph, --[ :: ]--[
                x,
                visited
              ]);
          _nodes = xs;
          continue ;
        end
      end else do
        return visited;
      end
    end;
  end;
  return List.rev(aux(nodes, graph, visited));
end

if (!Caml_obj.caml_equal(dfs2(--[ :: ]--[
            "a",
            --[ [] ]--0
          ], graph, --[ [] ]--0), --[ :: ]--[
        "a",
        --[ :: ]--[
          "d",
          --[ :: ]--[
            "e",
            --[ :: ]--[
              "g",
              --[ :: ]--[
                "f",
                --[ :: ]--[
                  "c",
                  --[ :: ]--[
                    "b",
                    --[ [] ]--0
                  ]
                ]
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          47,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(dfs2(--[ :: ]--[
            "b",
            --[ [] ]--0
          ], --[ :: ]--[
            --[ tuple ]--[
              "f",
              "d"
            ],
            graph
          ], --[ [] ]--0), --[ :: ]--[
        "b",
        --[ :: ]--[
          "e",
          --[ :: ]--[
            "g",
            --[ :: ]--[
              "f",
              --[ :: ]--[
                "d",
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          48,
          2
        ]
      ];
end

function dfs3(nodes, graph) do
  var visited = do
    contents: --[ [] ]--0
  end;
  var aux = function (node, graph) do
    if (List.mem(node, visited.contents)) do
      return 0;
    end else do
      visited.contents = --[ :: ]--[
        node,
        visited.contents
      ];
      return List.iter((function (x) do
                    return aux(x, graph);
                  end), nexts(node, graph));
    end
  end;
  List.iter((function (node) do
          return aux(node, graph);
        end), nodes);
  return List.rev(visited.contents);
end

if (!Caml_obj.caml_equal(dfs3(--[ :: ]--[
            "a",
            --[ [] ]--0
          ], graph), --[ :: ]--[
        "a",
        --[ :: ]--[
          "d",
          --[ :: ]--[
            "e",
            --[ :: ]--[
              "g",
              --[ :: ]--[
                "f",
                --[ :: ]--[
                  "c",
                  --[ :: ]--[
                    "b",
                    --[ [] ]--0
                  ]
                ]
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          65,
          2
        ]
      ];
end

if (!Caml_obj.caml_equal(dfs3(--[ :: ]--[
            "b",
            --[ [] ]--0
          ], --[ :: ]--[
            --[ tuple ]--[
              "f",
              "d"
            ],
            graph
          ]), --[ :: ]--[
        "b",
        --[ :: ]--[
          "e",
          --[ :: ]--[
            "g",
            --[ :: ]--[
              "f",
              --[ :: ]--[
                "d",
                --[ [] ]--0
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          66,
          2
        ]
      ];
end

var grwork = --[ :: ]--[
  --[ tuple ]--[
    "wake",
    "shower"
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "shower",
      "dress"
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "dress",
        "go"
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "wake",
          "eat"
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "eat",
            "washup"
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "washup",
              "go"
            ],
            --[ [] ]--0
          ]
        ]
      ]
    ]
  ]
];

function unsafe_topsort(graph) do
  var visited = do
    contents: --[ [] ]--0
  end;
  var sort_node = function (node) do
    if (List.mem(node, visited.contents)) do
      return 0;
    end else do
      var nodes = nexts(node, graph);
      List.iter(sort_node, nodes);
      visited.contents = --[ :: ]--[
        node,
        visited.contents
      ];
      return --[ () ]--0;
    end
  end;
  List.iter((function (param) do
          return sort_node(param[0]);
        end), graph);
  return visited.contents;
end

if (!Caml_obj.caml_equal(unsafe_topsort(grwork), --[ :: ]--[
        "wake",
        --[ :: ]--[
          "shower",
          --[ :: ]--[
            "dress",
            --[ :: ]--[
              "eat",
              --[ :: ]--[
                "washup",
                --[ :: ]--[
                  "go",
                  --[ [] ]--0
                ]
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          110,
          2
        ]
      ];
end

function height(param) do
  if (param) do
    return param[--[ h ]--3];
  end else do
    return 0;
  end
end

function create(l, v, r) do
  var hl = l ? l[--[ h ]--3] : 0;
  var hr = r ? r[--[ h ]--3] : 0;
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--v,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, v, r) do
  var hl = l ? l[--[ h ]--3] : 0;
  var hr = r ? r[--[ h ]--3] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[--[ r ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) do
        return create(create(ll, lv, lr[--[ l ]--0]), lr[--[ v ]--1], create(lr[--[ r ]--2], v, r));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Set.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Set.bal"
          ];
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[--[ r ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height(rr) >= height(rl)) do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) do
        return create(create(l, v, rl[--[ l ]--0]), rl[--[ v ]--1], create(rl[--[ r ]--2], rv, rr));
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Set.bal"
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Set.bal"
          ];
    end
  end else do
    return --[ Node ]--[
            --[ l ]--l,
            --[ v ]--v,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function add(x, t) do
  if (t) do
    var r = t[--[ r ]--2];
    var v = t[--[ v ]--1];
    var l = t[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) do
      return t;
    end else if (c < 0) do
      var ll = add(x, l);
      if (l == ll) do
        return t;
      end else do
        return bal(ll, v, r);
      end
    end else do
      var rr = add(x, r);
      if (r == rr) do
        return t;
      end else do
        return bal(l, v, rr);
      end
    end
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end
end

function singleton(x) do
  return --[ Node ]--[
          --[ l : Empty ]--0,
          --[ v ]--x,
          --[ r : Empty ]--0,
          --[ h ]--1
        ];
end

function add_min_element(x, param) do
  if (param) do
    return bal(add_min_element(x, param[--[ l ]--0]), param[--[ v ]--1], param[--[ r ]--2]);
  end else do
    return singleton(x);
  end
end

function add_max_element(x, param) do
  if (param) do
    return bal(param[--[ l ]--0], param[--[ v ]--1], add_max_element(x, param[--[ r ]--2]));
  end else do
    return singleton(x);
  end
end

function join(l, v, r) do
  if (l) do
    if (r) do
      var rh = r[--[ h ]--3];
      var lh = l[--[ h ]--3];
      if (lh > (rh + 2 | 0)) do
        return bal(l[--[ l ]--0], l[--[ v ]--1], join(l[--[ r ]--2], v, r));
      end else if (rh > (lh + 2 | 0)) do
        return bal(join(l, v, r[--[ l ]--0]), r[--[ v ]--1], r[--[ r ]--2]);
      end else do
        return create(l, v, r);
      end
    end else do
      return add_max_element(v, l);
    end
  end else do
    return add_min_element(v, r);
  end
end

function min_elt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var l = param[--[ l ]--0];
      if (l) do
        _param = l;
        continue ;
      end else do
        return param[--[ v ]--1];
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function min_elt_opt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var l = param[--[ l ]--0];
      if (l) do
        _param = l;
        continue ;
      end else do
        return Caml_option.some(param[--[ v ]--1]);
      end
    end else do
      return ;
    end
  end;
end

function max_elt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var r = param[--[ r ]--2];
      if (r) do
        _param = r;
        continue ;
      end else do
        return param[--[ v ]--1];
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function max_elt_opt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var r = param[--[ r ]--2];
      if (r) do
        _param = r;
        continue ;
      end else do
        return Caml_option.some(param[--[ v ]--1]);
      end
    end else do
      return ;
    end
  end;
end

function remove_min_elt(param) do
  if (param) do
    var l = param[--[ l ]--0];
    if (l) do
      return bal(remove_min_elt(l), param[--[ v ]--1], param[--[ r ]--2]);
    end else do
      return param[--[ r ]--2];
    end
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Set.remove_min_elt"
        ];
  end
end

function concat(t1, t2) do
  if (t1) do
    if (t2) do
      return join(t1, min_elt(t2), remove_min_elt(t2));
    end else do
      return t1;
    end
  end else do
    return t2;
  end
end

function split(x, param) do
  if (param) do
    var r = param[--[ r ]--2];
    var v = param[--[ v ]--1];
    var l = param[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) do
      return --[ tuple ]--[
              l,
              true,
              r
            ];
    end else if (c < 0) do
      var match = split(x, l);
      return --[ tuple ]--[
              match[0],
              match[1],
              join(match[2], v, r)
            ];
    end else do
      var match$1 = split(x, r);
      return --[ tuple ]--[
              join(l, v, match$1[0]),
              match$1[1],
              match$1[2]
            ];
    end
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            false,
            --[ Empty ]--0
          ];
  end
end

function is_empty(param) do
  if (param) do
    return false;
  end else do
    return true;
  end
end

function mem(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var c = Caml_primitive.caml_string_compare(x, param[--[ v ]--1]);
      if (c == 0) do
        return true;
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--2];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function remove(x, t) do
  if (t) do
    var r = t[--[ r ]--2];
    var v = t[--[ v ]--1];
    var l = t[--[ l ]--0];
    var c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) do
      var t1 = l;
      var t2 = r;
      if (t1) do
        if (t2) do
          return bal(t1, min_elt(t2), remove_min_elt(t2));
        end else do
          return t1;
        end
      end else do
        return t2;
      end
    end else if (c < 0) do
      var ll = remove(x, l);
      if (l == ll) do
        return t;
      end else do
        return bal(ll, v, r);
      end
    end else do
      var rr = remove(x, r);
      if (r == rr) do
        return t;
      end else do
        return bal(l, v, rr);
      end
    end
  end else do
    return --[ Empty ]--0;
  end
end

function union(s1, s2) do
  if (s1) do
    if (s2) do
      var h2 = s2[--[ h ]--3];
      var v2 = s2[--[ v ]--1];
      var h1 = s1[--[ h ]--3];
      var v1 = s1[--[ v ]--1];
      if (h1 >= h2) do
        if (h2 == 1) do
          return add(v2, s1);
        end else do
          var match = split(v1, s2);
          return join(union(s1[--[ l ]--0], match[0]), v1, union(s1[--[ r ]--2], match[2]));
        end
      end else if (h1 == 1) do
        return add(v1, s2);
      end else do
        var match$1 = split(v2, s1);
        return join(union(match$1[0], s2[--[ l ]--0]), v2, union(match$1[2], s2[--[ r ]--2]));
      end
    end else do
      return s1;
    end
  end else do
    return s2;
  end
end

function inter(s1, s2) do
  if (s1 and s2) do
    var r1 = s1[--[ r ]--2];
    var v1 = s1[--[ v ]--1];
    var l1 = s1[--[ l ]--0];
    var match = split(v1, s2);
    var l2 = match[0];
    if (match[1]) do
      return join(inter(l1, l2), v1, inter(r1, match[2]));
    end else do
      return concat(inter(l1, l2), inter(r1, match[2]));
    end
  end else do
    return --[ Empty ]--0;
  end
end

function diff(s1, s2) do
  if (s1) do
    if (s2) do
      var r1 = s1[--[ r ]--2];
      var v1 = s1[--[ v ]--1];
      var l1 = s1[--[ l ]--0];
      var match = split(v1, s2);
      var l2 = match[0];
      if (match[1]) do
        return concat(diff(l1, l2), diff(r1, match[2]));
      end else do
        return join(diff(l1, l2), v1, diff(r1, match[2]));
      end
    end else do
      return s1;
    end
  end else do
    return --[ Empty ]--0;
  end
end

function cons_enum(_s, _e) do
  while(true) do
    var e = _e;
    var s = _s;
    if (s) do
      _e = --[ More ]--[
        s[--[ v ]--1],
        s[--[ r ]--2],
        e
      ];
      _s = s[--[ l ]--0];
      continue ;
    end else do
      return e;
    end
  end;
end

function compare(s1, s2) do
  var _e1 = cons_enum(s1, --[ End ]--0);
  var _e2 = cons_enum(s2, --[ End ]--0);
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) do
      if (e2) do
        var c = Caml_primitive.caml_string_compare(e1[0], e2[0]);
        if (c ~= 0) do
          return c;
        end else do
          _e2 = cons_enum(e2[1], e2[2]);
          _e1 = cons_enum(e1[1], e1[2]);
          continue ;
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

function equal(s1, s2) do
  return compare(s1, s2) == 0;
end

function subset(_s1, _s2) do
  while(true) do
    var s2 = _s2;
    var s1 = _s1;
    if (s1) do
      if (s2) do
        var r2 = s2[--[ r ]--2];
        var l2 = s2[--[ l ]--0];
        var r1 = s1[--[ r ]--2];
        var v1 = s1[--[ v ]--1];
        var l1 = s1[--[ l ]--0];
        var c = Caml_primitive.caml_string_compare(v1, s2[--[ v ]--1]);
        if (c == 0) do
          if (subset(l1, l2)) do
            _s2 = r2;
            _s1 = r1;
            continue ;
          end else do
            return false;
          end
        end else if (c < 0) do
          if (subset(--[ Node ]--[
                  --[ l ]--l1,
                  --[ v ]--v1,
                  --[ r : Empty ]--0,
                  --[ h ]--0
                ], l2)) do
            _s1 = r1;
            continue ;
          end else do
            return false;
          end
        end else if (subset(--[ Node ]--[
                --[ l : Empty ]--0,
                --[ v ]--v1,
                --[ r ]--r1,
                --[ h ]--0
              ], r2)) do
          _s1 = l1;
          continue ;
        end else do
          return false;
        end
      end else do
        return false;
      end
    end else do
      return true;
    end
  end;
end

function iter(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      iter(f, param[--[ l ]--0]);
      Curry._1(f, param[--[ v ]--1]);
      _param = param[--[ r ]--2];
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function fold(f, _s, _accu) do
  while(true) do
    var accu = _accu;
    var s = _s;
    if (s) do
      _accu = Curry._2(f, s[--[ v ]--1], fold(f, s[--[ l ]--0], accu));
      _s = s[--[ r ]--2];
      continue ;
    end else do
      return accu;
    end
  end;
end

function for_all(p, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (Curry._1(p, param[--[ v ]--1]) and for_all(p, param[--[ l ]--0])) do
        _param = param[--[ r ]--2];
        continue ;
      end else do
        return false;
      end
    end else do
      return true;
    end
  end;
end

function exists(p, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (Curry._1(p, param[--[ v ]--1]) or exists(p, param[--[ l ]--0])) do
        return true;
      end else do
        _param = param[--[ r ]--2];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function filter(p, t) do
  if (t) do
    var r = t[--[ r ]--2];
    var v = t[--[ v ]--1];
    var l = t[--[ l ]--0];
    var l$prime = filter(p, l);
    var pv = Curry._1(p, v);
    var r$prime = filter(p, r);
    if (pv) do
      if (l == l$prime and r == r$prime) do
        return t;
      end else do
        return join(l$prime, v, r$prime);
      end
    end else do
      return concat(l$prime, r$prime);
    end
  end else do
    return --[ Empty ]--0;
  end
end

function partition(p, param) do
  if (param) do
    var v = param[--[ v ]--1];
    var match = partition(p, param[--[ l ]--0]);
    var lf = match[1];
    var lt = match[0];
    var pv = Curry._1(p, v);
    var match$1 = partition(p, param[--[ r ]--2]);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pv) do
      return --[ tuple ]--[
              join(lt, v, rt),
              concat(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              concat(lt, rt),
              join(lf, v, rf)
            ];
    end
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            --[ Empty ]--0
          ];
  end
end

function cardinal(param) do
  if (param) do
    return (cardinal(param[--[ l ]--0]) + 1 | 0) + cardinal(param[--[ r ]--2]) | 0;
  end else do
    return 0;
  end
end

function elements_aux(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) do
      _param = param[--[ l ]--0];
      _accu = --[ :: ]--[
        param[--[ v ]--1],
        elements_aux(accu, param[--[ r ]--2])
      ];
      continue ;
    end else do
      return accu;
    end
  end;
end

function elements(s) do
  return elements_aux(--[ [] ]--0, s);
end

function find(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      var c = Caml_primitive.caml_string_compare(x, v);
      if (c == 0) do
        return v;
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--2];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function find_first(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) do
        var _v0 = v;
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var v0 = _v0;
          if (param$1) do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) do
              _param$1 = param$1[--[ l ]--0];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--2];
              continue ;
            end
          end else do
            return v0;
          end
        end;
      end else do
        _param = param[--[ r ]--2];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function find_first_opt(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) do
        var _v0 = v;
        var f$1 = f;
        var _param$1 = param[--[ l ]--0];
        while(true) do
          var param$1 = _param$1;
          var v0 = _v0;
          if (param$1) do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) do
              _param$1 = param$1[--[ l ]--0];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ r ]--2];
              continue ;
            end
          end else do
            return Caml_option.some(v0);
          end
        end;
      end else do
        _param = param[--[ r ]--2];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function find_last(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) do
        var _v0 = v;
        var f$1 = f;
        var _param$1 = param[--[ r ]--2];
        while(true) do
          var param$1 = _param$1;
          var v0 = _v0;
          if (param$1) do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) do
              _param$1 = param$1[--[ r ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end
          end else do
            return v0;
          end
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function find_last_opt(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      if (Curry._1(f, v)) do
        var _v0 = v;
        var f$1 = f;
        var _param$1 = param[--[ r ]--2];
        while(true) do
          var param$1 = _param$1;
          var v0 = _v0;
          if (param$1) do
            var v$1 = param$1[--[ v ]--1];
            if (Curry._1(f$1, v$1)) do
              _param$1 = param$1[--[ r ]--2];
              _v0 = v$1;
              continue ;
            end else do
              _param$1 = param$1[--[ l ]--0];
              continue ;
            end
          end else do
            return Caml_option.some(v0);
          end
        end;
      end else do
        _param = param[--[ l ]--0];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function find_opt(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var v = param[--[ v ]--1];
      var c = Caml_primitive.caml_string_compare(x, v);
      if (c == 0) do
        return Caml_option.some(v);
      end else do
        _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--2];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function map(f, t) do
  if (t) do
    var r = t[--[ r ]--2];
    var v = t[--[ v ]--1];
    var l = t[--[ l ]--0];
    var l$prime = map(f, l);
    var v$prime = Curry._1(f, v);
    var r$prime = map(f, r);
    if (l == l$prime and v == v$prime and r == r$prime) do
      return t;
    end else do
      var l$1 = l$prime;
      var v$1 = v$prime;
      var r$1 = r$prime;
      if ((l$1 == --[ Empty ]--0 or Caml_primitive.caml_string_compare(max_elt(l$1), v$1) < 0) and (r$1 == --[ Empty ]--0 or Caml_primitive.caml_string_compare(v$1, min_elt(r$1)) < 0)) do
        return join(l$1, v$1, r$1);
      end else do
        return union(l$1, add(v$1, r$1));
      end
    end
  end else do
    return --[ Empty ]--0;
  end
end

function of_list(l) do
  if (l) do
    var match = l[1];
    var x0 = l[0];
    if (match) do
      var match$1 = match[1];
      var x1 = match[0];
      if (match$1) do
        var match$2 = match$1[1];
        var x2 = match$1[0];
        if (match$2) do
          var match$3 = match$2[1];
          var x3 = match$2[0];
          if (match$3) do
            if (match$3[1]) do
              var l$1 = List.sort_uniq($$String.compare, l);
              var sub = function (n, l) do
                switch (n) do
                  case 0 :
                      return --[ tuple ]--[
                              --[ Empty ]--0,
                              l
                            ];
                  case 1 :
                      if (l) do
                        return --[ tuple ]--[
                                --[ Node ]--[
                                  --[ l : Empty ]--0,
                                  --[ v ]--l[0],
                                  --[ r : Empty ]--0,
                                  --[ h ]--1
                                ],
                                l[1]
                              ];
                      end
                      break;
                  case 2 :
                      if (l) do
                        var match = l[1];
                        if (match) do
                          return --[ tuple ]--[
                                  --[ Node ]--[
                                    --[ l : Node ]--[
                                      --[ l : Empty ]--0,
                                      --[ v ]--l[0],
                                      --[ r : Empty ]--0,
                                      --[ h ]--1
                                    ],
                                    --[ v ]--match[0],
                                    --[ r : Empty ]--0,
                                    --[ h ]--2
                                  ],
                                  match[1]
                                ];
                        end
                        
                      end
                      break;
                  case 3 :
                      if (l) do
                        var match$1 = l[1];
                        if (match$1) do
                          var match$2 = match$1[1];
                          if (match$2) do
                            return --[ tuple ]--[
                                    --[ Node ]--[
                                      --[ l : Node ]--[
                                        --[ l : Empty ]--0,
                                        --[ v ]--l[0],
                                        --[ r : Empty ]--0,
                                        --[ h ]--1
                                      ],
                                      --[ v ]--match$1[0],
                                      --[ r : Node ]--[
                                        --[ l : Empty ]--0,
                                        --[ v ]--match$2[0],
                                        --[ r : Empty ]--0,
                                        --[ h ]--1
                                      ],
                                      --[ h ]--2
                                    ],
                                    match$2[1]
                                  ];
                          end
                          
                        end
                        
                      end
                      break;
                  default:
                    
                end
                var nl = n / 2 | 0;
                var match$3 = sub(nl, l);
                var l$1 = match$3[1];
                if (l$1) do
                  var match$4 = sub((n - nl | 0) - 1 | 0, l$1[1]);
                  return --[ tuple ]--[
                          create(match$3[0], l$1[0], match$4[0]),
                          match$4[1]
                        ];
                end else do
                  throw [
                        Caml_builtin_exceptions.assert_failure,
                        --[ tuple ]--[
                          "set.ml",
                          510,
                          18
                        ]
                      ];
                end
              end;
              return sub(List.length(l$1), l$1)[0];
            end else do
              return add(match$3[0], add(x3, add(x2, add(x1, singleton(x0)))));
            end
          end else do
            return add(x3, add(x2, add(x1, singleton(x0))));
          end
        end else do
          return add(x2, add(x1, singleton(x0)));
        end
      end else do
        return add(x1, singleton(x0));
      end
    end else do
      return singleton(x0);
    end
  end else do
    return --[ Empty ]--0;
  end
end

var String_set = do
  empty: --[ Empty ]--0,
  is_empty: is_empty,
  mem: mem,
  add: add,
  singleton: singleton,
  remove: remove,
  union: union,
  inter: inter,
  diff: diff,
  compare: compare,
  equal: equal,
  subset: subset,
  iter: iter,
  map: map,
  fold: fold,
  for_all: for_all,
  exists: exists,
  filter: filter,
  partition: partition,
  cardinal: cardinal,
  elements: elements,
  min_elt: min_elt,
  min_elt_opt: min_elt_opt,
  max_elt: max_elt,
  max_elt_opt: max_elt_opt,
  choose: min_elt,
  choose_opt: min_elt_opt,
  split: split,
  find: find,
  find_opt: find_opt,
  find_first: find_first,
  find_first_opt: find_first_opt,
  find_last: find_last,
  find_last_opt: find_last_opt,
  of_list: of_list
end;

var Cycle = Caml_exceptions.create("Topsort_test.Cycle");

function pathsort(graph) do
  var visited = do
    contents: --[ [] ]--0
  end;
  var empty_path = --[ tuple ]--[
    --[ Empty ]--0,
    --[ [] ]--0
  ];
  var $plus$great = function (node, param) do
    var stack = param[1];
    var set = param[0];
    if (mem(node, set)) do
      throw [
            Cycle,
            --[ :: ]--[
              node,
              stack
            ]
          ];
    end
    return --[ tuple ]--[
            add(node, set),
            --[ :: ]--[
              node,
              stack
            ]
          ];
  end;
  var sort_nodes = function (path, nodes) do
    return List.iter((function (node) do
                  return sort_node(path, node);
                end), nodes);
  end;
  var sort_node = function (path, node) do
    if (List.mem(node, visited.contents)) do
      return 0;
    end else do
      sort_nodes($plus$great(node, path), nexts(node, graph));
      visited.contents = --[ :: ]--[
        node,
        visited.contents
      ];
      return --[ () ]--0;
    end
  end;
  List.iter((function (param) do
          return sort_node(empty_path, param[0]);
        end), graph);
  return visited.contents;
end

if (!Caml_obj.caml_equal(pathsort(grwork), --[ :: ]--[
        "wake",
        --[ :: ]--[
          "shower",
          --[ :: ]--[
            "dress",
            --[ :: ]--[
              "eat",
              --[ :: ]--[
                "washup",
                --[ :: ]--[
                  "go",
                  --[ [] ]--0
                ]
              ]
            ]
          ]
        ]
      ])) do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          150,
          4
        ]
      ];
end

try do
  pathsort(--[ :: ]--[
        --[ tuple ]--[
          "go",
          "eat"
        ],
        grwork
      ]);
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "topsort_test.ml",
          156,
          8
        ]
      ];
end
catch (raw_exn)do
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  var exit = 0;
  if (exn[0] == Cycle) do
    var match = exn[1];
    if (match and match[0] == "go") do
      var match$1 = match[1];
      if (match$1 and match$1[0] == "washup") do
        var match$2 = match$1[1];
        if (match$2 and match$2[0] == "eat") do
          var match$3 = match$2[1];
          if (!(match$3 and match$3[0] == "go" and !match$3[1])) do
            exit = 1;
          end
          
        end else do
          exit = 1;
        end
      end else do
        exit = 1;
      end
    end else do
      exit = 1;
    end
  end else do
    exit = 1;
  end
  if (exit == 1) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "topsort_test.ml",
            159,
            11
          ]
        ];
  end
  
end

exports.graph = graph;
exports.nexts = nexts;
exports.dfs1 = dfs1;
exports.dfs2 = dfs2;
exports.dfs3 = dfs3;
exports.grwork = grwork;
exports.unsafe_topsort = unsafe_topsort;
exports.String_set = String_set;
exports.Cycle = Cycle;
exports.pathsort = pathsort;
--[  Not a pure module ]--
