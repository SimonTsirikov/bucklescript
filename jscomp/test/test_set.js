'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function Make(Ord) do
  var height = function (param) do
    if (param) then do
      return param[3];
    end else do
      return 0;
    end end 
  end;
  var create = function (l, v, r) do
    var hl = l ? l[3] : 0;
    var hr = r ? r[3] : 0;
    return --[ Node ]--[
            l,
            v,
            r,
            hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end;
  var bal = function (l, v, r) do
    var hl = l ? l[3] : 0;
    var hr = r ? r[3] : 0;
    if (hl > (hr + 2 | 0)) then do
      if (l) then do
        var lr = l[2];
        var lv = l[1];
        var ll = l[0];
        if (height(ll) >= height(lr)) then do
          return create(ll, lv, create(lr, v, r));
        end else if (lr) then do
          return create(create(ll, lv, lr[0]), lr[1], create(lr[2], v, r));
        end else do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Set.bal"
              ];
        end end  end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Set.bal"
            ];
      end end 
    end else if (hr > (hl + 2 | 0)) then do
      if (r) then do
        var rr = r[2];
        var rv = r[1];
        var rl = r[0];
        if (height(rr) >= height(rl)) then do
          return create(create(l, v, rl), rv, rr);
        end else if (rl) then do
          return create(create(l, v, rl[0]), rl[1], create(rl[2], rv, rr));
        end else do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "Set.bal"
              ];
        end end  end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Set.bal"
            ];
      end end 
    end else do
      return --[ Node ]--[
              l,
              v,
              r,
              hl >= hr ? hl + 1 | 0 : hr + 1 | 0
            ];
    end end  end 
  end;
  var add = function (x, t) do
    if (t) then do
      var r = t[2];
      var v = t[1];
      var l = t[0];
      var c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return t;
      end else if (c < 0) then do
        return bal(add(x, l), v, r);
      end else do
        return bal(l, v, add(x, r));
      end end  end 
    end else do
      return --[ Node ]--[
              --[ Empty ]--0,
              x,
              --[ Empty ]--0,
              1
            ];
    end end 
  end;
  var singleton = function (x) do
    return --[ Node ]--[
            --[ Empty ]--0,
            x,
            --[ Empty ]--0,
            1
          ];
  end;
  var add_min_element = function (v, param) do
    if (param) then do
      return bal(add_min_element(v, param[0]), param[1], param[2]);
    end else do
      return singleton(v);
    end end 
  end;
  var add_max_element = function (v, param) do
    if (param) then do
      return bal(param[0], param[1], add_max_element(v, param[2]));
    end else do
      return singleton(v);
    end end 
  end;
  var join = function (l, v, r) do
    if (l) then do
      if (r) then do
        var rh = r[3];
        var lh = l[3];
        if (lh > (rh + 2 | 0)) then do
          return bal(l[0], l[1], join(l[2], v, r));
        end else if (rh > (lh + 2 | 0)) then do
          return bal(join(l, v, r[0]), r[1], r[2]);
        end else do
          return create(l, v, r);
        end end  end 
      end else do
        return add_max_element(v, l);
      end end 
    end else do
      return add_min_element(v, r);
    end end 
  end;
  var min_elt = function (_param) do
    while(true) do
      var param = _param;
      if (param) then do
        var l = param[0];
        if (l) then do
          _param = l;
          continue ;
        end else do
          return param[1];
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end;
  var max_elt = function (_param) do
    while(true) do
      var param = _param;
      if (param) then do
        var r = param[2];
        if (r) then do
          _param = r;
          continue ;
        end else do
          return param[1];
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end;
  var remove_min_elt = function (param) do
    if (param) then do
      var l = param[0];
      if (l) then do
        return bal(remove_min_elt(l), param[1], param[2]);
      end else do
        return param[2];
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Set.remove_min_elt"
          ];
    end end 
  end;
  var merge = function (t1, t2) do
    if (t1) then do
      if (t2) then do
        return bal(t1, min_elt(t2), remove_min_elt(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
    end end 
  end;
  var concat = function (t1, t2) do
    if (t1) then do
      if (t2) then do
        return join(t1, min_elt(t2), remove_min_elt(t2));
      end else do
        return t1;
      end end 
    end else do
      return t2;
    end end 
  end;
  var split = function (x, param) do
    if (param) then do
      var r = param[2];
      var v = param[1];
      var l = param[0];
      var c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return --[ tuple ]--[
                l,
                true,
                r
              ];
      end else if (c < 0) then do
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
      end end  end 
    end else do
      return --[ tuple ]--[
              --[ Empty ]--0,
              false,
              --[ Empty ]--0
            ];
    end end 
  end;
  var is_empty = function (param) do
    if (param) then do
      return false;
    end else do
      return true;
    end end 
  end;
  var mem = function (x, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        var c = Curry._2(Ord.compare, x, param[1]);
        if (c == 0) then do
          return true;
        end else do
          _param = c < 0 ? param[0] : param[2];
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end;
  var remove = function (x, param) do
    if (param) then do
      var r = param[2];
      var v = param[1];
      var l = param[0];
      var c = Curry._2(Ord.compare, x, v);
      if (c == 0) then do
        return merge(l, r);
      end else if (c < 0) then do
        return bal(remove(x, l), v, r);
      end else do
        return bal(l, v, remove(x, r));
      end end  end 
    end else do
      return --[ Empty ]--0;
    end end 
  end;
  var union = function (s1, s2) do
    if (s1) then do
      if (s2) then do
        var h2 = s2[3];
        var v2 = s2[1];
        var h1 = s1[3];
        var v1 = s1[1];
        if (h1 >= h2) then do
          if (h2 == 1) then do
            return add(v2, s1);
          end else do
            var match = split(v1, s2);
            return join(union(s1[0], match[0]), v1, union(s1[2], match[2]));
          end end 
        end else if (h1 == 1) then do
          return add(v1, s2);
        end else do
          var match$1 = split(v2, s1);
          return join(union(match$1[0], s2[0]), v2, union(match$1[2], s2[2]));
        end end  end 
      end else do
        return s1;
      end end 
    end else do
      return s2;
    end end 
  end;
  var inter = function (s1, s2) do
    if (s1 and s2) then do
      var r1 = s1[2];
      var v1 = s1[1];
      var l1 = s1[0];
      var match = split(v1, s2);
      var l2 = match[0];
      if (match[1]) then do
        return join(inter(l1, l2), v1, inter(r1, match[2]));
      end else do
        return concat(inter(l1, l2), inter(r1, match[2]));
      end end 
    end else do
      return --[ Empty ]--0;
    end end 
  end;
  var diff = function (s1, s2) do
    if (s1) then do
      if (s2) then do
        var r1 = s1[2];
        var v1 = s1[1];
        var l1 = s1[0];
        var match = split(v1, s2);
        var l2 = match[0];
        if (match[1]) then do
          return concat(diff(l1, l2), diff(r1, match[2]));
        end else do
          return join(diff(l1, l2), v1, diff(r1, match[2]));
        end end 
      end else do
        return s1;
      end end 
    end else do
      return --[ Empty ]--0;
    end end 
  end;
  var cons_enum = function (_s, _e) do
    while(true) do
      var e = _e;
      var s = _s;
      if (s) then do
        _e = --[ More ]--[
          s[1],
          s[2],
          e
        ];
        _s = s[0];
        continue ;
      end else do
        return e;
      end end 
    end;
  end;
  var compare_aux = function (_e1, _e2) do
    while(true) do
      var e2 = _e2;
      var e1 = _e1;
      if (e1) then do
        if (e2) then do
          var c = Curry._2(Ord.compare, e1[0], e2[0]);
          if (c ~= 0) then do
            return c;
          end else do
            _e2 = cons_enum(e2[1], e2[2]);
            _e1 = cons_enum(e1[1], e1[2]);
            continue ;
          end end 
        end else do
          return 1;
        end end 
      end else if (e2) then do
        return -1;
      end else do
        return 0;
      end end  end 
    end;
  end;
  var compare = function (s1, s2) do
    return compare_aux(cons_enum(s1, --[ End ]--0), cons_enum(s2, --[ End ]--0));
  end;
  var equal = function (s1, s2) do
    return compare(s1, s2) == 0;
  end;
  var subset = function (_s1, _s2) do
    while(true) do
      var s2 = _s2;
      var s1 = _s1;
      if (s1) then do
        if (s2) then do
          var r2 = s2[2];
          var l2 = s2[0];
          var r1 = s1[2];
          var v1 = s1[1];
          var l1 = s1[0];
          var c = Curry._2(Ord.compare, v1, s2[1]);
          if (c == 0) then do
            if (subset(l1, l2)) then do
              _s2 = r2;
              _s1 = r1;
              continue ;
            end else do
              return false;
            end end 
          end else if (c < 0) then do
            if (subset(--[ Node ]--[
                    l1,
                    v1,
                    --[ Empty ]--0,
                    0
                  ], l2)) then do
              _s1 = r1;
              continue ;
            end else do
              return false;
            end end 
          end else if (subset(--[ Node ]--[
                  --[ Empty ]--0,
                  v1,
                  r1,
                  0
                ], r2)) then do
            _s1 = l1;
            continue ;
          end else do
            return false;
          end end  end  end 
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end;
  var iter = function (f, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        iter(f, param[0]);
        Curry._1(f, param[1]);
        _param = param[2];
        continue ;
      end else do
        return --[ () ]--0;
      end end 
    end;
  end;
  var fold = function (f, _s, _accu) do
    while(true) do
      var accu = _accu;
      var s = _s;
      if (s) then do
        _accu = Curry._2(f, s[1], fold(f, s[0], accu));
        _s = s[2];
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var for_all = function (p, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        if (Curry._1(p, param[1]) and for_all(p, param[0])) then do
          _param = param[2];
          continue ;
        end else do
          return false;
        end end 
      end else do
        return true;
      end end 
    end;
  end;
  var exists = function (p, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        if (Curry._1(p, param[1]) or exists(p, param[0])) then do
          return true;
        end else do
          _param = param[2];
          continue ;
        end end 
      end else do
        return false;
      end end 
    end;
  end;
  var filter = function (p, param) do
    if (param) then do
      var v = param[1];
      var l$prime = filter(p, param[0]);
      var pv = Curry._1(p, v);
      var r$prime = filter(p, param[2]);
      if (pv) then do
        return join(l$prime, v, r$prime);
      end else do
        return concat(l$prime, r$prime);
      end end 
    end else do
      return --[ Empty ]--0;
    end end 
  end;
  var partition = function (p, param) do
    if (param) then do
      var v = param[1];
      var match = partition(p, param[0]);
      var lf = match[1];
      var lt = match[0];
      var pv = Curry._1(p, v);
      var match$1 = partition(p, param[2]);
      var rf = match$1[1];
      var rt = match$1[0];
      if (pv) then do
        return --[ tuple ]--[
                join(lt, v, rt),
                concat(lf, rf)
              ];
      end else do
        return --[ tuple ]--[
                concat(lt, rt),
                join(lf, v, rf)
              ];
      end end 
    end else do
      return --[ tuple ]--[
              --[ Empty ]--0,
              --[ Empty ]--0
            ];
    end end 
  end;
  var cardinal = function (param) do
    if (param) then do
      return (cardinal(param[0]) + 1 | 0) + cardinal(param[2]) | 0;
    end else do
      return 0;
    end end 
  end;
  var elements_aux = function (_accu, _param) do
    while(true) do
      var param = _param;
      var accu = _accu;
      if (param) then do
        _param = param[0];
        _accu = --[ :: ]--[
          param[1],
          elements_aux(accu, param[2])
        ];
        continue ;
      end else do
        return accu;
      end end 
    end;
  end;
  var elements = function (s) do
    return elements_aux(--[ [] ]--0, s);
  end;
  var find = function (x, _param) do
    while(true) do
      var param = _param;
      if (param) then do
        var v = param[1];
        var c = Curry._2(Ord.compare, x, v);
        if (c == 0) then do
          return v;
        end else do
          _param = c < 0 ? param[0] : param[2];
          continue ;
        end end 
      end else do
        throw Caml_builtin_exceptions.not_found;
      end end 
    end;
  end;
  var of_sorted_list = function (l) do
    var sub = function (n, l) do
      switch (n) do
        case 0 :
            return --[ tuple ]--[
                    --[ Empty ]--0,
                    l
                  ];
        case 1 :
            if (l) then do
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
             end 
            break;
        case 2 :
            if (l) then do
              var match = l[1];
              if (match) then do
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
            end
             end 
            break;
        case 3 :
            if (l) then do
              var match$1 = l[1];
              if (match$1) then do
                var match$2 = match$1[1];
                if (match$2) then do
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
               end 
            end
             end 
            break;
        default:
          
      end
      var nl = n / 2 | 0;
      var match$3 = sub(nl, l);
      var l$1 = match$3[1];
      if (l$1) then do
        var match$4 = sub((n - nl | 0) - 1 | 0, l$1[1]);
        return --[ tuple ]--[
                create(match$3[0], l$1[0], match$4[0]),
                match$4[1]
              ];
      end else do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "test_set.ml",
                372,
                18
              ]
            ];
      end end 
    end;
    return sub(List.length(l), l)[0];
  end;
  var of_list = function (l) do
    if (l) then do
      var match = l[1];
      var x0 = l[0];
      if (match) then do
        var match$1 = match[1];
        var x1 = match[0];
        if (match$1) then do
          var match$2 = match$1[1];
          var x2 = match$1[0];
          if (match$2) then do
            var match$3 = match$2[1];
            var x3 = match$2[0];
            if (match$3) then do
              if (match$3[1]) then do
                return of_sorted_list(List.sort_uniq(Ord.compare, l));
              end else do
                return add(match$3[0], add(x3, add(x2, add(x1, singleton(x0)))));
              end end 
            end else do
              return add(x3, add(x2, add(x1, singleton(x0))));
            end end 
          end else do
            return add(x2, add(x1, singleton(x0)));
          end end 
        end else do
          return add(x1, singleton(x0));
        end end 
      end else do
        return singleton(x0);
      end end 
    end else do
      return --[ Empty ]--0;
    end end 
  end;
  return do
          height: height,
          create: create,
          bal: bal,
          add: add,
          singleton: singleton,
          add_min_element: add_min_element,
          add_max_element: add_max_element,
          join: join,
          min_elt: min_elt,
          max_elt: max_elt,
          remove_min_elt: remove_min_elt,
          merge: merge,
          concat: concat,
          split: split,
          empty: --[ Empty ]--0,
          is_empty: is_empty,
          mem: mem,
          remove: remove,
          union: union,
          inter: inter,
          diff: diff,
          cons_enum: cons_enum,
          compare_aux: compare_aux,
          compare: compare,
          equal: equal,
          subset: subset,
          iter: iter,
          fold: fold,
          for_all: for_all,
          exists: exists,
          filter: filter,
          partition: partition,
          cardinal: cardinal,
          elements_aux: elements_aux,
          elements: elements,
          choose: min_elt,
          find: find,
          of_sorted_list: of_sorted_list,
          of_list: of_list
        end;
end

var N = do
  a: 3
end;

exports.Make = Make;
exports.N = N;
--[ No side effect ]--
