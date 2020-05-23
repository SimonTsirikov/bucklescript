'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function cons_enum(_s, _e) do
  while(true) do
    var e = _e;
    var s = _s;
    if (s) do
      _e = --[ More ]--[
        s[1],
        s[2],
        e
      ];
      _s = s[0];
      continue ;
    end else do
      return e;
    end
  end;
end

function height(param) do
  if (param) do
    return param[3];
  end else do
    return 0;
  end
end

function min_elt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var l = param[0];
      if (l) do
        _param = l;
        continue ;
      end else do
        return param[1];
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function max_elt(_param) do
  while(true) do
    var param = _param;
    if (param) do
      var r = param[2];
      if (r) do
        _param = r;
        continue ;
      end else do
        return param[1];
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function is_empty(param) do
  if (param) do
    return false;
  end else do
    return true;
  end
end

function cardinal_aux(_acc, _param) do
  while(true) do
    var param = _param;
    var acc = _acc;
    if (param) do
      _param = param[0];
      _acc = cardinal_aux(acc + 1 | 0, param[2]);
      continue ;
    end else do
      return acc;
    end
  end;
end

function cardinal(s) do
  return cardinal_aux(0, s);
end

function elements_aux(_accu, _param) do
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) do
      _param = param[0];
      _accu = --[ :: ]--[
        param[1],
        elements_aux(accu, param[2])
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

function iter(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      iter(f, param[0]);
      Curry._1(f, param[1]);
      _param = param[2];
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
      _accu = Curry._2(f, s[1], fold(f, s[0], accu));
      _s = s[2];
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
      if (Curry._1(p, param[1]) and for_all(p, param[0])) do
        _param = param[2];
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
      if (Curry._1(p, param[1]) or exists(p, param[0])) do
        return true;
      end else do
        _param = param[2];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function max_int3(a, b, c) do
  if (a >= b) do
    if (a >= c) do
      return a;
    end else do
      return c;
    end
  end else if (b >= c) do
    return b;
  end else do
    return c;
  end
end

function max_int_2(a, b) do
  if (a >= b) do
    return a;
  end else do
    return b;
  end
end

var Height_invariant_broken = Caml_exceptions.create("Set_gen.Height_invariant_broken");

var Height_diff_borken = Caml_exceptions.create("Set_gen.Height_diff_borken");

function check_height_and_diff(param) do
  if (param) do
    var h = param[3];
    var hl = check_height_and_diff(param[0]);
    var hr = check_height_and_diff(param[2]);
    if (h ~= (max_int_2(hl, hr) + 1 | 0)) do
      throw Height_invariant_broken;
    end
    var diff = Pervasives.abs(hl - hr | 0);
    if (diff > 2) do
      throw Height_diff_borken;
    end
    return h;
  end else do
    return 0;
  end
end

function check(tree) do
  check_height_and_diff(tree);
  return --[ () ]--0;
end

function create(l, v, r) do
  var hl = l ? l[3] : 0;
  var hr = r ? r[3] : 0;
  return --[ Node ]--[
          l,
          v,
          r,
          hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function internal_bal(l, v, r) do
  var hl = l ? l[3] : 0;
  var hr = r ? r[3] : 0;
  if (hl > (hr + 2 | 0)) do
    if (l) do
      var lr = l[2];
      var lv = l[1];
      var ll = l[0];
      if (height(ll) >= height(lr)) do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) do
        return create(create(ll, lv, lr[0]), lr[1], create(lr[2], v, r));
      end else do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "set_gen.ml",
                235,
                19
              ]
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "set_gen.ml",
              225,
              15
            ]
          ];
    end
  end else if (hr > (hl + 2 | 0)) do
    if (r) do
      var rr = r[2];
      var rv = r[1];
      var rl = r[0];
      if (height(rr) >= height(rl)) do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) do
        return create(create(l, v, rl[0]), rl[1], create(rl[2], rv, rr));
      end else do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "set_gen.ml",
                251,
                19
              ]
            ];
      end
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "set_gen.ml",
              245,
              15
            ]
          ];
    end
  end else do
    return --[ Node ]--[
            l,
            v,
            r,
            hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end
end

function remove_min_elt(param) do
  if (param) do
    var l = param[0];
    if (l) do
      return internal_bal(remove_min_elt(l), param[1], param[2]);
    end else do
      return param[2];
    end
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Set.remove_min_elt"
        ];
  end
end

function singleton(x) do
  return --[ Node ]--[
          --[ Empty ]--0,
          x,
          --[ Empty ]--0,
          1
        ];
end

function internal_merge(l, r) do
  if (l) do
    if (r) do
      return internal_bal(l, min_elt(r), remove_min_elt(r));
    end else do
      return l;
    end
  end else do
    return r;
  end
end

function add_min_element(v, param) do
  if (param) do
    return internal_bal(add_min_element(v, param[0]), param[1], param[2]);
  end else do
    return singleton(v);
  end
end

function add_max_element(v, param) do
  if (param) do
    return internal_bal(param[0], param[1], add_max_element(v, param[2]));
  end else do
    return singleton(v);
  end
end

function internal_join(l, v, r) do
  if (l) do
    if (r) do
      var rh = r[3];
      var lh = l[3];
      if (lh > (rh + 2 | 0)) do
        return internal_bal(l[0], l[1], internal_join(l[2], v, r));
      end else if (rh > (lh + 2 | 0)) do
        return internal_bal(internal_join(l, v, r[0]), r[1], r[2]);
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

function internal_concat(t1, t2) do
  if (t1) do
    if (t2) do
      return internal_join(t1, min_elt(t2), remove_min_elt(t2));
    end else do
      return t1;
    end
  end else do
    return t2;
  end
end

function filter(p, param) do
  if (param) do
    var v = param[1];
    var l$prime = filter(p, param[0]);
    var pv = Curry._1(p, v);
    var r$prime = filter(p, param[2]);
    if (pv) do
      return internal_join(l$prime, v, r$prime);
    end else do
      return internal_concat(l$prime, r$prime);
    end
  end else do
    return --[ Empty ]--0;
  end
end

function partition(p, param) do
  if (param) do
    var v = param[1];
    var match = partition(p, param[0]);
    var lf = match[1];
    var lt = match[0];
    var pv = Curry._1(p, v);
    var match$1 = partition(p, param[2]);
    var rf = match$1[1];
    var rt = match$1[0];
    if (pv) do
      return --[ tuple ]--[
              internal_join(lt, v, rt),
              internal_concat(lf, rf)
            ];
    end else do
      return --[ tuple ]--[
              internal_concat(lt, rt),
              internal_join(lf, v, rf)
            ];
    end
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            --[ Empty ]--0
          ];
  end
end

function of_sorted_list(l) do
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
                      --[ Empty ]--0,
                      l[0],
                      --[ Empty ]--0,
                      1
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
                        --[ Node ]--[
                          --[ Empty ]--0,
                          l[0],
                          --[ Empty ]--0,
                          1
                        ],
                        match[0],
                        --[ Empty ]--0,
                        2
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
                          --[ Node ]--[
                            --[ Empty ]--0,
                            l[0],
                            --[ Empty ]--0,
                            1
                          ],
                          match$1[0],
                          --[ Node ]--[
                            --[ Empty ]--0,
                            match$2[0],
                            --[ Empty ]--0,
                            1
                          ],
                          2
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
              "set_gen.ml",
              361,
              14
            ]
          ];
    end
  end;
  return sub(List.length(l), l)[0];
end

function of_sorted_array(l) do
  var sub = function (start, n, l) do
    if (n == 0) do
      return --[ Empty ]--0;
    end else if (n == 1) do
      var x0 = l[start];
      return --[ Node ]--[
              --[ Empty ]--0,
              x0,
              --[ Empty ]--0,
              1
            ];
    end else if (n == 2) do
      var x0$1 = l[start];
      var x1 = l[start + 1 | 0];
      return --[ Node ]--[
              --[ Node ]--[
                --[ Empty ]--0,
                x0$1,
                --[ Empty ]--0,
                1
              ],
              x1,
              --[ Empty ]--0,
              2
            ];
    end else if (n == 3) do
      var x0$2 = l[start];
      var x1$1 = l[start + 1 | 0];
      var x2 = l[start + 2 | 0];
      return --[ Node ]--[
              --[ Node ]--[
                --[ Empty ]--0,
                x0$2,
                --[ Empty ]--0,
                1
              ],
              x1$1,
              --[ Node ]--[
                --[ Empty ]--0,
                x2,
                --[ Empty ]--0,
                1
              ],
              2
            ];
    end else do
      var nl = n / 2 | 0;
      var left = sub(start, nl, l);
      var mid = start + nl | 0;
      var v = l[mid];
      var right = sub(mid + 1 | 0, (n - nl | 0) - 1 | 0, l);
      return create(left, v, right);
    end
  end;
  return sub(0, #l, l);
end

function is_ordered(cmp, tree) do
  var is_ordered_min_max = function (tree) do
    if (tree) do
      var r = tree[2];
      var v = tree[1];
      var match = is_ordered_min_max(tree[0]);
      if (typeof match == "number") do
        if (match >= 50834029) do
          var match$1 = is_ordered_min_max(r);
          if (typeof match$1 == "number") do
            if (match$1 >= 50834029) do
              return --[ `V ]--[
                      86,
                      --[ tuple ]--[
                        v,
                        v
                      ]
                    ];
            end else do
              return --[ No ]--17505;
            end
          end else do
            var match$2 = match$1[1];
            if (Curry._2(cmp, v, match$2[0]) < 0) do
              return --[ `V ]--[
                      86,
                      --[ tuple ]--[
                        v,
                        match$2[1]
                      ]
                    ];
            end else do
              return --[ No ]--17505;
            end
          end
        end else do
          return --[ No ]--17505;
        end
      end else do
        var match$3 = match[1];
        var max_v = match$3[1];
        var min_v = match$3[0];
        var match$4 = is_ordered_min_max(r);
        if (typeof match$4 == "number") do
          if (match$4 >= 50834029 and Curry._2(cmp, max_v, v) < 0) do
            return --[ `V ]--[
                    86,
                    --[ tuple ]--[
                      min_v,
                      v
                    ]
                  ];
          end else do
            return --[ No ]--17505;
          end
        end else do
          var match$5 = match$4[1];
          if (Curry._2(cmp, max_v, match$5[0]) < 0) do
            return --[ `V ]--[
                    86,
                    --[ tuple ]--[
                      min_v,
                      match$5[1]
                    ]
                  ];
          end else do
            return --[ No ]--17505;
          end
        end
      end
    end else do
      return --[ Empty ]--50834029;
    end
  end;
  return is_ordered_min_max(tree) ~= --[ No ]--17505;
end

function invariant(cmp, t) do
  check_height_and_diff(t);
  return is_ordered(cmp, t);
end

function compare_aux(cmp, _e1, _e2) do
  while(true) do
    var e2 = _e2;
    var e1 = _e1;
    if (e1) do
      if (e2) do
        var c = Curry._2(cmp, e1[0], e2[0]);
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

function compare(cmp, s1, s2) do
  return compare_aux(cmp, cons_enum(s1, --[ End ]--0), cons_enum(s2, --[ End ]--0));
end

var empty = --[ Empty ]--0;

var choose = min_elt;

exports.cons_enum = cons_enum;
exports.height = height;
exports.min_elt = min_elt;
exports.max_elt = max_elt;
exports.empty = empty;
exports.is_empty = is_empty;
exports.cardinal_aux = cardinal_aux;
exports.cardinal = cardinal;
exports.elements_aux = elements_aux;
exports.elements = elements;
exports.choose = choose;
exports.iter = iter;
exports.fold = fold;
exports.for_all = for_all;
exports.exists = exists;
exports.max_int3 = max_int3;
exports.max_int_2 = max_int_2;
exports.Height_invariant_broken = Height_invariant_broken;
exports.Height_diff_borken = Height_diff_borken;
exports.check_height_and_diff = check_height_and_diff;
exports.check = check;
exports.create = create;
exports.internal_bal = internal_bal;
exports.remove_min_elt = remove_min_elt;
exports.singleton = singleton;
exports.internal_merge = internal_merge;
exports.add_min_element = add_min_element;
exports.add_max_element = add_max_element;
exports.internal_join = internal_join;
exports.internal_concat = internal_concat;
exports.filter = filter;
exports.partition = partition;
exports.of_sorted_list = of_sorted_list;
exports.of_sorted_array = of_sorted_array;
exports.is_ordered = is_ordered;
exports.invariant = invariant;
exports.compare_aux = compare_aux;
exports.compare = compare;
--[ No side effect ]--
