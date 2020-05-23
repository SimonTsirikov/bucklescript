'use strict';

var Mt = require("./mt.js");
var Char = require("../../lib/js/char.js");
var List = require("../../lib/js/list.js");
var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var Curry = require("../../lib/js/curry.js");
var Format = require("../../lib/js/format.js");
var $$String = require("../../lib/js/string.js");
var Hashtbl = require("../../lib/js/hashtbl.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_option = require("../../lib/js/caml_option.js");
var Caml_string = require("../../lib/js/caml_string.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function union(_l, _l$prime) do
  while(true) do
    var l$prime = _l$prime;
    var l = _l;
    if (l$prime) then do
      if (l) then do
        var r$prime = l$prime[1];
        var match = l$prime[0];
        var c2$prime = match[1];
        var c1$prime = match[0];
        var r = l[1];
        var match$1 = l[0];
        var c2 = match$1[1];
        var c1 = match$1[0];
        if ((c2 + 1 | 0) < c1$prime) then do
          return --[ :: ]--[
                  --[ tuple ]--[
                    c1,
                    c2
                  ],
                  union(r, l$prime)
                ];
        end else if ((c2$prime + 1 | 0) < c1) then do
          return --[ :: ]--[
                  --[ tuple ]--[
                    c1$prime,
                    c2$prime
                  ],
                  union(l, r$prime)
                ];
        end else if (c2 < c2$prime) then do
          _l$prime = --[ :: ]--[
            --[ tuple ]--[
              c1 < c1$prime ? c1 : c1$prime,
              c2$prime
            ],
            r$prime
          ];
          _l = r;
          continue ;
        end else do
          _l$prime = r$prime;
          _l = --[ :: ]--[
            --[ tuple ]--[
              c1 < c1$prime ? c1 : c1$prime,
              c2
            ],
            r
          ];
          continue ;
        end end  end  end 
      end else do
        return l$prime;
      end end 
    end else do
      return l;
    end end 
  end;
end

function inter(_l, _l$prime) do
  while(true) do
    var l$prime = _l$prime;
    var l = _l;
    if (l$prime and l) then do
      var r$prime = l$prime[1];
      var match = l$prime[0];
      var c2$prime = match[1];
      var c1$prime = match[0];
      var r = l[1];
      var match$1 = l[0];
      var c2 = match$1[1];
      var c1 = match$1[0];
      if (Caml_obj.caml_lessthan(c2, c1$prime)) then do
        _l = r;
        continue ;
      end else if (Caml_obj.caml_lessthan(c2$prime, c1)) then do
        _l$prime = r$prime;
        continue ;
      end else if (Caml_obj.caml_lessthan(c2, c2$prime)) then do
        return --[ :: ]--[
                --[ tuple ]--[
                  Caml_obj.caml_max(c1, c1$prime),
                  c2
                ],
                inter(r, l$prime)
              ];
      end else do
        return --[ :: ]--[
                --[ tuple ]--[
                  Caml_obj.caml_max(c1, c1$prime),
                  c2$prime
                ],
                inter(l, r$prime)
              ];
      end end  end  end 
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function diff(_l, _l$prime) do
  while(true) do
    var l$prime = _l$prime;
    var l = _l;
    if (l$prime) then do
      if (l) then do
        var r$prime = l$prime[1];
        var match = l$prime[0];
        var c2$prime = match[1];
        var c1$prime = match[0];
        var r = l[1];
        var match$1 = l[0];
        var c2 = match$1[1];
        var c1 = match$1[0];
        if (c2 < c1$prime) then do
          return --[ :: ]--[
                  --[ tuple ]--[
                    c1,
                    c2
                  ],
                  diff(r, l$prime)
                ];
        end else if (c2$prime < c1) then do
          _l$prime = r$prime;
          continue ;
        end else do
          var r$prime$prime = c2$prime < c2 ? --[ :: ]--[
              --[ tuple ]--[
                c2$prime + 1 | 0,
                c2
              ],
              r
            ] : r;
          if (c1 < c1$prime) then do
            return --[ :: ]--[
                    --[ tuple ]--[
                      c1,
                      c1$prime - 1 | 0
                    ],
                    diff(r$prime$prime, r$prime)
                  ];
          end else do
            _l$prime = r$prime;
            _l = r$prime$prime;
            continue ;
          end end 
        end end  end 
      end else do
        return --[ [] ]--0;
      end end 
    end else do
      return l;
    end end 
  end;
end

function single(c) do
  return --[ :: ]--[
          --[ tuple ]--[
            c,
            c
          ],
          --[ [] ]--0
        ];
end

function seq(c, c$prime) do
  if (Caml_obj.caml_lessequal(c, c$prime)) then do
    return --[ :: ]--[
            --[ tuple ]--[
              c,
              c$prime
            ],
            --[ [] ]--0
          ];
  end else do
    return --[ :: ]--[
            --[ tuple ]--[
              c$prime,
              c
            ],
            --[ [] ]--0
          ];
  end end 
end

function offset(o, l) do
  if (l) then do
    var match = l[0];
    return --[ :: ]--[
            --[ tuple ]--[
              match[0] + o | 0,
              match[1] + o | 0
            ],
            offset(o, l[1])
          ];
  end else do
    return --[ [] ]--0;
  end end 
end

function mem(c, _s) do
  while(true) do
    var s = _s;
    if (s) then do
      var match = s[0];
      if (c <= match[1]) then do
        return c >= match[0];
      end else do
        _s = s[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function hash_rec(param) do
  if (param) then do
    var match = param[0];
    return (match[0] + Caml_int32.imul(13, match[1]) | 0) + Caml_int32.imul(257, hash_rec(param[1])) | 0;
  end else do
    return 0;
  end end 
end

function one_char(param) do
  if (param and !param[1]) then do
    var match = param[0];
    var i = match[0];
    if (Caml_obj.caml_equal(i, match[1])) then do
      return Caml_option.some(i);
    end else do
      return ;
    end end 
  end
   end 
end

function compare(param, param$1) do
  var c = Caml_obj.caml_compare(param[0], param$1[0]);
  if (c ~= 0) then do
    return c;
  end else do
    return Caml_obj.caml_compare(param[1], param$1[1]);
  end end 
end

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
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal(l, x, d, r) do
  var hl = l ? l[--[ h ]--4] : 0;
  var hr = r ? r[--[ h ]--4] : 0;
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
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end end  end 
end

function add(x, data, m) do
  if (m) then do
    var r = m[--[ r ]--3];
    var d = m[--[ d ]--2];
    var v = m[--[ v ]--1];
    var l = m[--[ l ]--0];
    var c = compare(x, v);
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

var cany = --[ :: ]--[
  --[ tuple ]--[
    0,
    255
  ],
  --[ [] ]--0
];

function intersect(x, y) do
  return (x & y) ~= 0;
end

function $plus$plus(x, y) do
  return x | y;
end

function from_char(param) do
  if (param >= 170) then do
    if (param >= 187) then do
      var switcher = param - 192 | 0;
      if (switcher > 54 or switcher < 0) then do
        if (switcher >= 56) then do
          return 2;
        end else do
          return 4;
        end end 
      end else if (switcher ~= 23) then do
        return 2;
      end else do
        return 4;
      end end  end 
    end else do
      var switcher$1 = param - 171 | 0;
      if (!(switcher$1 > 14 or switcher$1 < 0) and switcher$1 ~= 10) then do
        return 4;
      end else do
        return 2;
      end end 
    end end 
  end else if (param >= 65) then do
    var switcher$2 = param - 91 | 0;
    if (switcher$2 > 5 or switcher$2 < 0) then do
      if (switcher$2 >= 32) then do
        return 4;
      end else do
        return 2;
      end end 
    end else if (switcher$2 ~= 4) then do
      return 4;
    end else do
      return 2;
    end end  end 
  end else if (param >= 48) then do
    if (param >= 58) then do
      return 4;
    end else do
      return 2;
    end end 
  end else if (param ~= 10) then do
    return 4;
  end else do
    return 12;
  end end  end  end  end 
end

function height$1(param) do
  if (param) then do
    return param[--[ h ]--3];
  end else do
    return 0;
  end end 
end

function create$1(l, v, r) do
  var hl = l ? l[--[ h ]--3] : 0;
  var hr = r ? r[--[ h ]--3] : 0;
  return --[ Node ]--[
          --[ l ]--l,
          --[ v ]--v,
          --[ r ]--r,
          --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
        ];
end

function bal$1(l, v, r) do
  var hl = l ? l[--[ h ]--3] : 0;
  var hr = r ? r[--[ h ]--3] : 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      var lr = l[--[ r ]--2];
      var lv = l[--[ v ]--1];
      var ll = l[--[ l ]--0];
      if (height$1(ll) >= height$1(lr)) then do
        return create$1(ll, lv, create$1(lr, v, r));
      end else if (lr) then do
        return create$1(create$1(ll, lv, lr[--[ l ]--0]), lr[--[ v ]--1], create$1(lr[--[ r ]--2], v, r));
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
      var rr = r[--[ r ]--2];
      var rv = r[--[ v ]--1];
      var rl = r[--[ l ]--0];
      if (height$1(rr) >= height$1(rl)) then do
        return create$1(create$1(l, v, rl), rv, rr);
      end else if (rl) then do
        return create$1(create$1(l, v, rl[--[ l ]--0]), rl[--[ v ]--1], create$1(rl[--[ r ]--2], rv, rr));
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
            --[ l ]--l,
            --[ v ]--v,
            --[ r ]--r,
            --[ h ]--hl >= hr ? hl + 1 | 0 : hr + 1 | 0
          ];
  end end  end 
end

function add$1(x, t) do
  if (t) then do
    var r = t[--[ r ]--2];
    var v = t[--[ v ]--1];
    var l = t[--[ l ]--0];
    var c = Caml_primitive.caml_int_compare(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      var ll = add$1(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal$1(ll, v, r);
      end end 
    end else do
      var rr = add$1(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal$1(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[ Node ]--[
            --[ l : Empty ]--0,
            --[ v ]--x,
            --[ r : Empty ]--0,
            --[ h ]--1
          ];
  end end 
end

function hash_combine(h, accu) do
  return Caml_int32.imul(accu, 65599) + h | 0;
end

var empty = do
  marks: --[ [] ]--0,
  pmarks: --[ Empty ]--0
end;

function hash(m, accu) do
  var _l = m.marks;
  var _accu = hash_combine(Hashtbl.hash(m.pmarks), accu);
  while(true) do
    var accu$1 = _accu;
    var l = _l;
    if (l) then do
      var match = l[0];
      _accu = hash_combine(match[0], hash_combine(match[1], accu$1));
      _l = l[1];
      continue ;
    end else do
      return accu$1;
    end end 
  end;
end

function marks_set_idx(idx, marks) do
  if (marks) then do
    var match = marks[0];
    if (match[1] ~= -1) then do
      return marks;
    end else do
      return --[ :: ]--[
              --[ tuple ]--[
                match[0],
                idx
              ],
              marks_set_idx(idx, marks[1])
            ];
    end end 
  end else do
    return marks;
  end end 
end

function marks_set_idx$1(marks, idx) do
  return do
          marks: marks_set_idx(idx, marks.marks),
          pmarks: marks.pmarks
        end;
end

function first(f, _param) do
  while(true) do
    var param = _param;
    if (param) then do
      var res = Curry._1(f, param[0]);
      if (res ~= undefined) then do
        return res;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return ;
    end end 
  end;
end

var eps_expr = do
  id: 0,
  def: --[ Eps ]--0
end;

function mk_expr(ids, def) do
  ids.contents = ids.contents + 1 | 0;
  return do
          id: ids.contents,
          def: def
        end;
end

function cst(ids, s) do
  if (s ? false : true) then do
    return mk_expr(ids, --[ Alt ]--Block.__(1, [--[ [] ]--0]));
  end else do
    return mk_expr(ids, --[ Cst ]--Block.__(0, [s]));
  end end 
end

function alt(ids, l) do
  if (l) then do
    if (l[1]) then do
      return mk_expr(ids, --[ Alt ]--Block.__(1, [l]));
    end else do
      return l[0];
    end end 
  end else do
    return mk_expr(ids, --[ Alt ]--Block.__(1, [--[ [] ]--0]));
  end end 
end

function seq$1(ids, kind, x, y) do
  var match = x.def;
  var match$1 = y.def;
  var exit = 0;
  if (typeof match == "number") then do
    return y;
  end else if (match.tag == --[ Alt ]--1 and !match[0]) then do
    return x;
  end else do
    exit = 2;
  end end  end 
  if (exit == 2) then do
    if (typeof match$1 == "number") then do
      if (kind == --[ First ]--332064784) then do
        return x;
      end
       end 
    end else if (match$1.tag == --[ Alt ]--1 and !match$1[0]) then do
      return y;
    end
     end  end 
  end
   end 
  return mk_expr(ids, --[ Seq ]--Block.__(2, [
                kind,
                x,
                y
              ]));
end

function is_eps(expr) do
  var match = expr.def;
  if (typeof match == "number") then do
    return true;
  end else do
    return false;
  end end 
end

function rep(ids, kind, sem, x) do
  return mk_expr(ids, --[ Rep ]--Block.__(3, [
                kind,
                sem,
                x
              ]));
end

function erase(ids, m, m$prime) do
  return mk_expr(ids, --[ Erase ]--Block.__(5, [
                m,
                m$prime
              ]));
end

function rename(ids, x) do
  var match = x.def;
  if (typeof match == "number") then do
    return mk_expr(ids, x.def);
  end else do
    switch (match.tag | 0) do
      case --[ Alt ]--1 :
          return mk_expr(ids, --[ Alt ]--Block.__(1, [List.map((function (param) do
                                return rename(ids, param);
                              end), match[0])]));
      case --[ Seq ]--2 :
          return mk_expr(ids, --[ Seq ]--Block.__(2, [
                        match[0],
                        rename(ids, match[1]),
                        rename(ids, match[2])
                      ]));
      case --[ Rep ]--3 :
          return mk_expr(ids, --[ Rep ]--Block.__(3, [
                        match[0],
                        match[1],
                        rename(ids, match[2])
                      ]));
      default:
        return mk_expr(ids, x.def);
    end
  end end 
end

function equal(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      var match = l1[0];
      switch (match.tag | 0) do
        case --[ TSeq ]--0 :
            if (l2) then do
              var match$1 = l2[0];
              switch (match$1.tag | 0) do
                case --[ TSeq ]--0 :
                    if (match[1].id == match$1[1].id and equal(match[0], match$1[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      continue ;
                    end else do
                      return false;
                    end end 
                case --[ TExp ]--1 :
                case --[ TMatch ]--2 :
                    return false;
                
              end
            end else do
              return false;
            end end 
        case --[ TExp ]--1 :
            if (l2) then do
              var match$2 = l2[0];
              switch (match$2.tag | 0) do
                case --[ TExp ]--1 :
                    if (match[1].id == match$2[1].id and Caml_obj.caml_equal(match[0], match$2[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      continue ;
                    end else do
                      return false;
                    end end 
                case --[ TSeq ]--0 :
                case --[ TMatch ]--2 :
                    return false;
                
              end
            end else do
              return false;
            end end 
        case --[ TMatch ]--2 :
            if (l2) then do
              var match$3 = l2[0];
              switch (match$3.tag | 0) do
                case --[ TSeq ]--0 :
                case --[ TExp ]--1 :
                    return false;
                case --[ TMatch ]--2 :
                    if (Caml_obj.caml_equal(match[0], match$3[0])) then do
                      _l2 = l2[1];
                      _l1 = l1[1];
                      continue ;
                    end else do
                      return false;
                    end end 
                
              end
            end else do
              return false;
            end end 
        
      end
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function hash$1(_l, _accu) do
  while(true) do
    var accu = _accu;
    var l = _l;
    if (l) then do
      var match = l[0];
      switch (match.tag | 0) do
        case --[ TSeq ]--0 :
            _accu = hash_combine(388635598, hash_combine(match[1].id, hash$1(match[0], accu)));
            _l = l[1];
            continue ;
        case --[ TExp ]--1 :
            _accu = hash_combine(726404471, hash_combine(match[1].id, hash(match[0], accu)));
            _l = l[1];
            continue ;
        case --[ TMatch ]--2 :
            _accu = hash_combine(471882453, hash(match[0], accu));
            _l = l[1];
            continue ;
        
      end
    end else do
      return accu;
    end end 
  end;
end

function tseq(kind, x, y, rem) do
  if (x) then do
    var match = x[0];
    switch (match.tag | 0) do
      case --[ TExp ]--1 :
          if (typeof match[1].def == "number" and !x[1]) then do
            return --[ :: ]--[
                    --[ TExp ]--Block.__(1, [
                        match[0],
                        y
                      ]),
                    rem
                  ];
          end
           end 
          break;
      case --[ TSeq ]--0 :
      case --[ TMatch ]--2 :
          break;
      
    end
  end else do
    return rem;
  end end 
  return --[ :: ]--[
          --[ TSeq ]--Block.__(0, [
              x,
              y,
              kind
            ]),
          rem
        ];
end

var dummy = do
  idx: -1,
  category: -1,
  desc: --[ [] ]--0,
  status: undefined,
  hash: -1
end;

function hash$2(idx, cat, desc) do
  return hash$1(desc, hash_combine(idx, hash_combine(cat, 0))) & 1073741823;
end

function mk(idx, cat, desc) do
  return do
          idx: idx,
          category: cat,
          desc: desc,
          status: undefined,
          hash: hash$2(idx, cat, desc)
        end;
end

function create$2(cat, e) do
  return mk(0, cat, --[ :: ]--[
              --[ TExp ]--Block.__(1, [
                  empty,
                  e
                ]),
              --[ [] ]--0
            ]);
end

function equal$1(x, y) do
  if (x.hash == y.hash and x.idx == y.idx and x.category == y.category) then do
    return equal(x.desc, y.desc);
  end else do
    return false;
  end end 
end

function hash$3(t) do
  return t.hash;
end

var Table = Hashtbl.Make(do
      equal: equal$1,
      hash: hash$3
    end);

function reset_table(a) do
  return $$Array.fill(a, 0, #a, false);
end

function mark_used_indices(tbl) do
  return (function (param) do
      return List.iter((function (param) do
                    switch (param.tag | 0) do
                      case --[ TSeq ]--0 :
                          return mark_used_indices(tbl)(param[0]);
                      case --[ TExp ]--1 :
                      case --[ TMatch ]--2 :
                          break;
                      
                    end
                    return List.iter((function (param) do
                                  var i = param[1];
                                  if (i >= 0) then do
                                    return Caml_array.caml_array_set(tbl, i, true);
                                  end else do
                                    return 0;
                                  end end 
                                end), param[0].marks);
                  end), param);
    end);
end

function find_free(tbl, _idx, len) do
  while(true) do
    var idx = _idx;
    if (idx == len or !Caml_array.caml_array_get(tbl, idx)) then do
      return idx;
    end else do
      _idx = idx + 1 | 0;
      continue ;
    end end 
  end;
end

function free_index(tbl_ref, l) do
  var tbl = tbl_ref.contents;
  reset_table(tbl);
  mark_used_indices(tbl)(l);
  var len = #tbl;
  var idx = find_free(tbl, 0, len);
  if (idx == len) then do
    tbl_ref.contents = Caml_array.caml_make_vect((len << 1), false);
  end
   end 
  return idx;
end

var remove_matches = List.filter((function (param) do
        switch (param.tag | 0) do
          case --[ TSeq ]--0 :
          case --[ TExp ]--1 :
              return true;
          case --[ TMatch ]--2 :
              return false;
          
        end
      end));

function split_at_match_rec(_l$prime, _param) do
  while(true) do
    var param = _param;
    var l$prime = _l$prime;
    if (param) then do
      var x = param[0];
      switch (x.tag | 0) do
        case --[ TSeq ]--0 :
        case --[ TExp ]--1 :
            _param = param[1];
            _l$prime = --[ :: ]--[
              x,
              l$prime
            ];
            continue ;
        case --[ TMatch ]--2 :
            return --[ tuple ]--[
                    List.rev(l$prime),
                    Curry._1(remove_matches, param[1])
                  ];
        
      end
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "re_automata.ml",
              429,
              21
            ]
          ];
    end end 
  end;
end

function remove_duplicates(prev, _l, y) do
  while(true) do
    var l = _l;
    if (l) then do
      var x = l[0];
      switch (x.tag | 0) do
        case --[ TSeq ]--0 :
            var x$1 = x[1];
            var match = remove_duplicates(prev, x[0], x$1);
            var match$1 = remove_duplicates(match[1], l[1], y);
            return --[ tuple ]--[
                    tseq(x[2], match[0], x$1, match$1[0]),
                    match$1[1]
                  ];
        case --[ TExp ]--1 :
            var x$2 = x[1];
            if (typeof x$2.def == "number") then do
              var r = l[1];
              if (List.memq(y.id, prev)) then do
                _l = r;
                continue ;
              end else do
                var match$2 = remove_duplicates(--[ :: ]--[
                      y.id,
                      prev
                    ], r, y);
                return --[ tuple ]--[
                        --[ :: ]--[
                          x,
                          match$2[0]
                        ],
                        match$2[1]
                      ];
              end end 
            end else do
              var r$1 = l[1];
              if (List.memq(x$2.id, prev)) then do
                _l = r$1;
                continue ;
              end else do
                var match$3 = remove_duplicates(--[ :: ]--[
                      x$2.id,
                      prev
                    ], r$1, y);
                return --[ tuple ]--[
                        --[ :: ]--[
                          x,
                          match$3[0]
                        ],
                        match$3[1]
                      ];
              end end 
            end end 
        case --[ TMatch ]--2 :
            return --[ tuple ]--[
                    --[ :: ]--[
                      x,
                      --[ [] ]--0
                    ],
                    prev
                  ];
        
      end
    end else do
      return --[ tuple ]--[
              --[ [] ]--0,
              prev
            ];
    end end 
  end;
end

function set_idx(idx, param) do
  if (param) then do
    var match = param[0];
    switch (match.tag | 0) do
      case --[ TSeq ]--0 :
          return --[ :: ]--[
                  --[ TSeq ]--Block.__(0, [
                      set_idx(idx, match[0]),
                      match[1],
                      match[2]
                    ]),
                  set_idx(idx, param[1])
                ];
      case --[ TExp ]--1 :
          return --[ :: ]--[
                  --[ TExp ]--Block.__(1, [
                      marks_set_idx$1(match[0], idx),
                      match[1]
                    ]),
                  set_idx(idx, param[1])
                ];
      case --[ TMatch ]--2 :
          return --[ :: ]--[
                  --[ TMatch ]--Block.__(2, [marks_set_idx$1(match[0], idx)]),
                  set_idx(idx, param[1])
                ];
      
    end
  end else do
    return --[ [] ]--0;
  end end 
end

function filter_marks(b, e, marks) do
  return do
          marks: List.filter((function (param) do
                    var i = param[0];
                    if (i < b) then do
                      return true;
                    end else do
                      return i > e;
                    end end 
                  end))(marks.marks),
          pmarks: marks.pmarks
        end;
end

function delta_1(marks, c, next_cat, prev_cat, x, rem) do
  var match = x.def;
  if (typeof match == "number") then do
    return --[ :: ]--[
            --[ TMatch ]--Block.__(2, [marks]),
            rem
          ];
  end else do
    switch (match.tag | 0) do
      case --[ Cst ]--0 :
          if (mem(c, match[0])) then do
            return --[ :: ]--[
                    --[ TExp ]--Block.__(1, [
                        marks,
                        eps_expr
                      ]),
                    rem
                  ];
          end else do
            return rem;
          end end 
      case --[ Alt ]--1 :
          return delta_2(marks, c, next_cat, prev_cat, match[0], rem);
      case --[ Seq ]--2 :
          var y$prime = delta_1(marks, c, next_cat, prev_cat, match[1], --[ [] ]--0);
          return delta_seq(c, next_cat, prev_cat, match[0], y$prime, match[2], rem);
      case --[ Rep ]--3 :
          var kind = match[1];
          var y$prime$1 = delta_1(marks, c, next_cat, prev_cat, match[2], --[ [] ]--0);
          var match$1 = first((function (param) do
                  switch (param.tag | 0) do
                    case --[ TSeq ]--0 :
                    case --[ TExp ]--1 :
                        return ;
                    case --[ TMatch ]--2 :
                        return param[0];
                    
                  end
                end), y$prime$1);
          var match$2 = match$1 ~= undefined ? --[ tuple ]--[
              Curry._1(remove_matches, y$prime$1),
              match$1
            ] : --[ tuple ]--[
              y$prime$1,
              marks
            ];
          var y$prime$prime = match$2[0];
          if (match[0] >= 620821490) then do
            return --[ :: ]--[
                    --[ TMatch ]--Block.__(2, [marks]),
                    tseq(kind, y$prime$prime, x, rem)
                  ];
          end else do
            return tseq(kind, y$prime$prime, x, --[ :: ]--[
                        --[ TMatch ]--Block.__(2, [match$2[1]]),
                        rem
                      ]);
          end end 
      case --[ Mark ]--4 :
          var i = match[0];
          var marks_marks = --[ :: ]--[
            --[ tuple ]--[
              i,
              -1
            ],
            List.remove_assq(i, marks.marks)
          ];
          var marks_pmarks = marks.pmarks;
          var marks$1 = do
            marks: marks_marks,
            pmarks: marks_pmarks
          end;
          return --[ :: ]--[
                  --[ TMatch ]--Block.__(2, [marks$1]),
                  rem
                ];
      case --[ Erase ]--5 :
          return --[ :: ]--[
                  --[ TMatch ]--Block.__(2, [filter_marks(match[0], match[1], marks)]),
                  rem
                ];
      case --[ Before ]--6 :
          if (intersect(next_cat, match[0])) then do
            return --[ :: ]--[
                    --[ TMatch ]--Block.__(2, [marks]),
                    rem
                  ];
          end else do
            return rem;
          end end 
      case --[ After ]--7 :
          if (intersect(prev_cat, match[0])) then do
            return --[ :: ]--[
                    --[ TMatch ]--Block.__(2, [marks]),
                    rem
                  ];
          end else do
            return rem;
          end end 
      case --[ Pmark ]--8 :
          var marks_marks$1 = marks.marks;
          var marks_pmarks$1 = add$1(match[0], marks.pmarks);
          var marks$2 = do
            marks: marks_marks$1,
            pmarks: marks_pmarks$1
          end;
          return --[ :: ]--[
                  --[ TMatch ]--Block.__(2, [marks$2]),
                  rem
                ];
      
    end
  end end 
end

function delta_2(marks, c, next_cat, prev_cat, l, rem) do
  if (l) then do
    return delta_1(marks, c, next_cat, prev_cat, l[0], delta_2(marks, c, next_cat, prev_cat, l[1], rem));
  end else do
    return rem;
  end end 
end

function delta_seq(c, next_cat, prev_cat, kind, y, z, rem) do
  var match = first((function (param) do
          switch (param.tag | 0) do
            case --[ TSeq ]--0 :
            case --[ TExp ]--1 :
                return ;
            case --[ TMatch ]--2 :
                return param[0];
            
          end
        end), y);
  if (match ~= undefined) then do
    var marks = match;
    if (kind ~= -730718166) then do
      if (kind >= 332064784) then do
        var match$1 = split_at_match_rec(--[ [] ]--0, y);
        return tseq(kind, match$1[0], z, delta_1(marks, c, next_cat, prev_cat, z, tseq(kind, match$1[1], z, rem)));
      end else do
        return delta_1(marks, c, next_cat, prev_cat, z, tseq(kind, Curry._1(remove_matches, y), z, rem));
      end end 
    end else do
      return tseq(kind, Curry._1(remove_matches, y), z, delta_1(marks, c, next_cat, prev_cat, z, rem));
    end end 
  end else do
    return tseq(kind, y, z, rem);
  end end 
end

function delta_4(c, next_cat, prev_cat, l, rem) do
  if (l) then do
    var c$1 = c;
    var next_cat$1 = next_cat;
    var prev_cat$1 = prev_cat;
    var x = l[0];
    var rem$1 = delta_4(c, next_cat, prev_cat, l[1], rem);
    switch (x.tag | 0) do
      case --[ TSeq ]--0 :
          var y$prime = delta_4(c$1, next_cat$1, prev_cat$1, x[0], --[ [] ]--0);
          return delta_seq(c$1, next_cat$1, prev_cat$1, x[2], y$prime, x[1], rem$1);
      case --[ TExp ]--1 :
          return delta_1(x[0], c$1, next_cat$1, prev_cat$1, x[1], rem$1);
      case --[ TMatch ]--2 :
          return --[ :: ]--[
                  x,
                  rem$1
                ];
      
    end
  end else do
    return rem;
  end end 
end

function delta(tbl_ref, next_cat, $$char, st) do
  var prev_cat = st.category;
  var match = remove_duplicates(--[ [] ]--0, delta_4($$char, next_cat, prev_cat, st.desc, --[ [] ]--0), eps_expr);
  var expr$prime = match[0];
  var idx = free_index(tbl_ref, expr$prime);
  var expr$prime$prime = set_idx(idx, expr$prime);
  return mk(idx, next_cat, expr$prime$prime);
end

function flatten_match(m) do
  var ma = List.fold_left((function (ma, param) do
          return Caml_primitive.caml_int_max(ma, param[0]);
        end), -1, m);
  var res = Caml_array.caml_make_vect(ma + 1 | 0, -1);
  List.iter((function (param) do
          return Caml_array.caml_array_set(res, param[0], param[1]);
        end), m);
  return res;
end

function status(s) do
  var match = s.status;
  if (match ~= undefined) then do
    return match;
  end else do
    var match$1 = s.desc;
    var st;
    if (match$1) then do
      var match$2 = match$1[0];
      switch (match$2.tag | 0) do
        case --[ TSeq ]--0 :
        case --[ TExp ]--1 :
            st = --[ Running ]--1;
            break;
        case --[ TMatch ]--2 :
            var m = match$2[0];
            st = --[ Match ]--[
              flatten_match(m.marks),
              m.pmarks
            ];
            break;
        
      end
    end else do
      st = --[ Failed ]--0;
    end end 
    s.status = st;
    return st;
  end end 
end

var Re_automata_Category = do
  $plus$plus: $plus$plus,
  from_char: from_char,
  inexistant: 1,
  letter: 2,
  not_letter: 4,
  newline: 8,
  lastnewline: 16,
  search_boundary: 32
end;

var Re_automata_State = do
  dummy: dummy,
  create: create$2,
  Table: Table
end;

function iter(_n, f, _v) do
  while(true) do
    var v = _v;
    var n = _n;
    if (n == 0) then do
      return v;
    end else do
      _v = Curry._1(f, v);
      _n = n - 1 | 0;
      continue ;
    end end 
  end;
end

function category(re, c) do
  if (c == -1) then do
    return Re_automata_Category.inexistant;
  end else if (c == re.lnl) then do
    return Curry._2(Re_automata_Category.$plus$plus, Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.lastnewline, Re_automata_Category.newline), Re_automata_Category.not_letter);
  end else do
    return Curry._1(Re_automata_Category.from_char, Caml_bytes.get(re.col_repr, c));
  end end  end 
end

var dummy_next = [];

var unknown_state = do
  idx: -2,
  real_idx: 0,
  next: dummy_next,
  final: --[ [] ]--0,
  desc: Re_automata_State.dummy
end;

function mk_state(ncol, desc) do
  var match = status(desc);
  var break_state = typeof match == "number" ? match == 0 : true;
  return do
          idx: break_state ? -3 : desc.idx,
          real_idx: desc.idx,
          next: break_state ? dummy_next : Caml_array.caml_make_vect(ncol, unknown_state),
          final: --[ [] ]--0,
          desc: desc
        end;
end

function find_state(re, desc) do
  try do
    return Curry._2(Re_automata_State.Table.find, re.states, desc);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var st = mk_state(re.ncol, desc);
      Curry._3(Re_automata_State.Table.add, re.states, desc, st);
      return st;
    end else do
      throw exn;
    end end 
  end
end

function delta$1(info, cat, c, st) do
  var desc = delta(info.re.tbl, cat, c, st.desc);
  var len = #info.positions;
  if (desc.idx == len and len > 0) then do
    var pos = info.positions;
    info.positions = Caml_array.caml_make_vect((len << 1), 0);
    $$Array.blit(pos, 0, info.positions, 0, len);
  end
   end 
  return desc;
end

function validate(info, s, pos, st) do
  var c = Caml_bytes.get(info.i_cols, Caml_string.get(s, pos));
  var cat = category(info.re, c);
  var desc$prime = delta$1(info, cat, c, st);
  var st$prime = find_state(info.re, desc$prime);
  return Caml_array.caml_array_set(st.next, c, st$prime);
end

function loop(info, s, pos, st) do
  if (pos < info.last) then do
    var st$prime = Caml_array.caml_array_get(st.next, Caml_bytes.get(info.i_cols, Caml_string.get(s, pos)));
    var info$1 = info;
    var s$1 = s;
    var _pos = pos;
    var _st = st;
    var _st$prime = st$prime;
    while(true) do
      var st$prime$1 = _st$prime;
      var st$1 = _st;
      var pos$1 = _pos;
      if (st$prime$1.idx >= 0) then do
        var pos$2 = pos$1 + 1 | 0;
        if (pos$2 < info$1.last) then do
          var st$prime$prime = Caml_array.caml_array_get(st$prime$1.next, Caml_bytes.get(info$1.i_cols, Caml_string.get(s$1, pos$2)));
          Caml_array.caml_array_set(info$1.positions, st$prime$1.idx, pos$2);
          _st$prime = st$prime$prime;
          _st = st$prime$1;
          _pos = pos$2;
          continue ;
        end else do
          Caml_array.caml_array_set(info$1.positions, st$prime$1.idx, pos$2);
          return st$prime$1;
        end end 
      end else if (st$prime$1.idx == -3) then do
        Caml_array.caml_array_set(info$1.positions, st$prime$1.real_idx, pos$1 + 1 | 0);
        return st$prime$1;
      end else do
        validate(info$1, s$1, pos$1, st$1);
        return loop(info$1, s$1, pos$1, st$1);
      end end  end 
    end;
  end else do
    return st;
  end end 
end

function $$final(info, st, cat) do
  try do
    return List.assq(cat, st.final);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var st$prime = delta$1(info, cat, -1, st);
      var res_000 = st$prime.idx;
      var res_001 = status(st$prime);
      var res = --[ tuple ]--[
        res_000,
        res_001
      ];
      st.final = --[ :: ]--[
        --[ tuple ]--[
          cat,
          res
        ],
        st.final
      ];
      return res;
    end else do
      throw exn;
    end end 
  end
end

function find_initial_state(re, cat) do
  try do
    return List.assq(cat, re.initial_states);
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      var st = find_state(re, Curry._2(Re_automata_State.create, cat, re.initial));
      re.initial_states = --[ :: ]--[
        --[ tuple ]--[
          cat,
          st
        ],
        re.initial_states
      ];
      return st;
    end else do
      throw exn;
    end end 
  end
end

function get_color(re, s, pos) do
  if (pos < 0) then do
    return -1;
  end else do
    var slen = #s;
    if (pos >= slen) then do
      return -1;
    end else if (pos == (slen - 1 | 0) and re.lnl ~= -1 and Caml_string.get(s, pos) == --[ "\n" ]--10) then do
      return re.lnl;
    end else do
      return Caml_bytes.get(re.cols, Caml_string.get(s, pos));
    end end  end 
  end end 
end

function scan_str(info, s, initial_state, groups) do
  var pos = info.pos;
  var last = info.last;
  if (last == #s and info.re.lnl ~= -1 and last > pos and Caml_string.get(s, last - 1 | 0) == --[ "\n" ]--10) then do
    var info$1 = do
      re: info.re,
      i_cols: info.i_cols,
      positions: info.positions,
      pos: info.pos,
      last: last - 1 | 0
    end;
    var st = scan_str(info$1, s, initial_state, groups);
    if (st.idx == -3) then do
      return st;
    end else do
      var info$2 = info$1;
      var pos$1 = last - 1 | 0;
      var st$1 = st;
      var groups$1 = groups;
      while(true) do
        var st$prime = Caml_array.caml_array_get(st$1.next, info$2.re.lnl);
        if (st$prime.idx >= 0) then do
          if (groups$1) then do
            Caml_array.caml_array_set(info$2.positions, st$prime.idx, pos$1 + 1 | 0);
          end
           end 
          return st$prime;
        end else if (st$prime.idx == -3) then do
          if (groups$1) then do
            Caml_array.caml_array_set(info$2.positions, st$prime.real_idx, pos$1 + 1 | 0);
          end
           end 
          return st$prime;
        end else do
          var c = info$2.re.lnl;
          var real_c = Caml_bytes.get(info$2.i_cols, --[ "\n" ]--10);
          var cat = category(info$2.re, c);
          var desc$prime = delta$1(info$2, cat, real_c, st$1);
          var st$prime$1 = find_state(info$2.re, desc$prime);
          Caml_array.caml_array_set(st$1.next, c, st$prime$1);
          continue ;
        end end  end 
      end;
    end end 
  end else if (groups) then do
    return loop(info, s, pos, initial_state);
  end else do
    var info$3 = info;
    var s$1 = s;
    var _pos = pos;
    var last$1 = last;
    var _st = initial_state;
    while(true) do
      var st$2 = _st;
      var pos$2 = _pos;
      if (pos$2 < last$1) then do
        var st$prime$2 = Caml_array.caml_array_get(st$2.next, Caml_bytes.get(info$3.i_cols, Caml_string.get(s$1, pos$2)));
        if (st$prime$2.idx >= 0) then do
          _st = st$prime$2;
          _pos = pos$2 + 1 | 0;
          continue ;
        end else if (st$prime$2.idx == -3) then do
          return st$prime$2;
        end else do
          validate(info$3, s$1, pos$2, st$2);
          continue ;
        end end  end 
      end else do
        return st$2;
      end end 
    end;
  end end  end 
end

function cadd(c, s) do
  return union(single(c), s);
end

function trans_set(cache, cm, s) do
  var match = one_char(s);
  if (match ~= undefined) then do
    return single(Caml_bytes.get(cm, match));
  end else do
    var v_000 = hash_rec(s);
    var v = --[ tuple ]--[
      v_000,
      s
    ];
    try do
      var x = v;
      var _param = cache.contents;
      while(true) do
        var param = _param;
        if (param) then do
          var c = compare(x, param[--[ v ]--1]);
          if (c == 0) then do
            return param[--[ d ]--2];
          end else do
            _param = c < 0 ? param[--[ l ]--0] : param[--[ r ]--3];
            continue ;
          end end 
        end else do
          throw Caml_builtin_exceptions.not_found;
        end end 
      end;
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        var l = List.fold_right((function (param, l) do
                return union(seq(Caml_bytes.get(cm, param[0]), Caml_bytes.get(cm, param[1])), l);
              end), s, --[ [] ]--0);
        cache.contents = add(v, l, cache.contents);
        return l;
      end else do
        throw exn;
      end end 
    end
  end end 
end

function is_charset(_param) do
  while(true) do
    var param = _param;
    if (typeof param == "number") then do
      return false;
    end else do
      switch (param.tag | 0) do
        case --[ Set ]--0 :
            return true;
        case --[ Sem ]--4 :
        case --[ Sem_greedy ]--5 :
            _param = param[1];
            continue ;
        case --[ No_group ]--7 :
        case --[ Case ]--9 :
        case --[ No_case ]--10 :
            _param = param[0];
            continue ;
        case --[ Alternative ]--2 :
        case --[ Intersection ]--11 :
        case --[ Complement ]--12 :
            return List.for_all(is_charset, param[0]);
        case --[ Difference ]--13 :
            if (is_charset(param[0])) then do
              _param = param[1];
              continue ;
            end else do
              return false;
            end end 
        default:
          return false;
      end
    end end 
  end;
end

function split(s, cm) do
  var _t = s;
  var f = function (i, j) do
    cm[i] = --[ "\001" ]--1;
    cm[j + 1 | 0] = --[ "\001" ]--1;
    return --[ () ]--0;
  end;
  while(true) do
    var t = _t;
    if (t) then do
      var match = t[0];
      Curry._2(f, match[0], match[1]);
      _t = t[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

var cupper = union(seq(--[ "A" ]--65, --[ "Z" ]--90), union(seq(--[ "\192" ]--192, --[ "\214" ]--214), seq(--[ "\216" ]--216, --[ "\222" ]--222)));

var clower = offset(32, cupper);

var calpha = List.fold_right(cadd, --[ :: ]--[
      --[ "\170" ]--170,
      --[ :: ]--[
        --[ "\181" ]--181,
        --[ :: ]--[
          --[ "\186" ]--186,
          --[ :: ]--[
            --[ "\223" ]--223,
            --[ :: ]--[
              --[ "\255" ]--255,
              --[ [] ]--0
            ]
          ]
        ]
      ]
    ], union(clower, cupper));

var cdigit = seq(--[ "0" ]--48, --[ "9" ]--57);

var calnum = union(calpha, cdigit);

var cword = union(--[ :: ]--[
      --[ tuple ]--[
        --[ "_" ]--95,
        --[ "_" ]--95
      ],
      --[ [] ]--0
    ], calnum);

function colorize(c, regexp) do
  var lnl = do
    contents: false
  end;
  var colorize$1 = function (_regexp) do
    while(true) do
      var regexp = _regexp;
      if (typeof regexp == "number") then do
        switch (regexp) do
          case --[ Beg_of_line ]--0 :
          case --[ End_of_line ]--1 :
              return split(--[ :: ]--[
                          --[ tuple ]--[
                            --[ "\n" ]--10,
                            --[ "\n" ]--10
                          ],
                          --[ [] ]--0
                        ], c);
          case --[ Beg_of_word ]--2 :
          case --[ End_of_word ]--3 :
          case --[ Not_bound ]--4 :
              return split(cword, c);
          case --[ Last_end_of_line ]--7 :
              lnl.contents = true;
              return --[ () ]--0;
          case --[ Beg_of_str ]--5 :
          case --[ End_of_str ]--6 :
          case --[ Start ]--8 :
          case --[ Stop ]--9 :
              return --[ () ]--0;
          
        end
      end else do
        switch (regexp.tag | 0) do
          case --[ Set ]--0 :
              return split(regexp[0], c);
          case --[ Sequence ]--1 :
          case --[ Alternative ]--2 :
              return List.iter(colorize$1, regexp[0]);
          case --[ Repeat ]--3 :
          case --[ Group ]--6 :
          case --[ No_group ]--7 :
          case --[ Nest ]--8 :
              _regexp = regexp[0];
              continue ;
          case --[ Sem ]--4 :
          case --[ Sem_greedy ]--5 :
          case --[ Pmark ]--14 :
              _regexp = regexp[1];
              continue ;
          default:
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "re.ml",
                    502,
                    35
                  ]
                ];
        end
      end end 
    end;
  end;
  colorize$1(regexp);
  return lnl.contents;
end

function flatten_cmap(cm) do
  var c = Caml_bytes.caml_create_bytes(256);
  var col_repr = Caml_bytes.caml_create_bytes(256);
  var v = 0;
  c[0] = --[ "\000" ]--0;
  col_repr[0] = --[ "\000" ]--0;
  for(var i = 1; i <= 255; ++i)do
    if (Caml_bytes.get(cm, i) ~= --[ "\000" ]--0) then do
      v = v + 1 | 0;
    end
     end 
    c[i] = Char.chr(v);
    col_repr[v] = Char.chr(i);
  end
  return --[ tuple ]--[
          c,
          Bytes.sub(col_repr, 0, v + 1 | 0),
          v + 1 | 0
        ];
end

function equal$2(_x1, _x2) do
  while(true) do
    var x2 = _x2;
    var x1 = _x1;
    if (typeof x1 == "number") then do
      switch (x1) do
        case --[ Beg_of_line ]--0 :
            if (typeof x2 == "number") then do
              return x2 == 0;
            end else do
              return false;
            end end 
        case --[ End_of_line ]--1 :
            if (typeof x2 == "number") then do
              return x2 == 1;
            end else do
              return false;
            end end 
        case --[ Beg_of_word ]--2 :
            if (typeof x2 == "number") then do
              return x2 == 2;
            end else do
              return false;
            end end 
        case --[ End_of_word ]--3 :
            if (typeof x2 == "number") then do
              return x2 == 3;
            end else do
              return false;
            end end 
        case --[ Not_bound ]--4 :
            if (typeof x2 == "number") then do
              return x2 == 4;
            end else do
              return false;
            end end 
        case --[ Beg_of_str ]--5 :
            if (typeof x2 == "number") then do
              return x2 == 5;
            end else do
              return false;
            end end 
        case --[ End_of_str ]--6 :
            if (typeof x2 == "number") then do
              return x2 == 6;
            end else do
              return false;
            end end 
        case --[ Last_end_of_line ]--7 :
            if (typeof x2 == "number") then do
              return x2 == 7;
            end else do
              return false;
            end end 
        case --[ Start ]--8 :
            if (typeof x2 == "number") then do
              return x2 == 8;
            end else do
              return false;
            end end 
        case --[ Stop ]--9 :
            if (typeof x2 == "number") then do
              return x2 >= 9;
            end else do
              return false;
            end end 
        
      end
    end else do
      switch (x1.tag | 0) do
        case --[ Set ]--0 :
            if (typeof x2 == "number" or x2.tag) then do
              return false;
            end else do
              return Caml_obj.caml_equal(x1[0], x2[0]);
            end end 
        case --[ Sequence ]--1 :
            if (typeof x2 == "number" or x2.tag ~= --[ Sequence ]--1) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end 
        case --[ Alternative ]--2 :
            if (typeof x2 == "number" or x2.tag ~= --[ Alternative ]--2) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end 
        case --[ Repeat ]--3 :
            if (typeof x2 == "number" or !(x2.tag == --[ Repeat ]--3 and x1[1] == x2[1] and Caml_obj.caml_equal(x1[2], x2[2]))) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              continue ;
            end end 
        case --[ Sem ]--4 :
            if (typeof x2 == "number" or !(x2.tag == --[ Sem ]--4 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              continue ;
            end end 
        case --[ Sem_greedy ]--5 :
            if (typeof x2 == "number" or !(x2.tag == --[ Sem_greedy ]--5 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              continue ;
            end end 
        case --[ Group ]--6 :
            return false;
        case --[ No_group ]--7 :
            if (typeof x2 == "number" or x2.tag ~= --[ No_group ]--7) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              continue ;
            end end 
        case --[ Nest ]--8 :
            if (typeof x2 == "number" or x2.tag ~= --[ Nest ]--8) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              continue ;
            end end 
        case --[ Case ]--9 :
            if (typeof x2 == "number" or x2.tag ~= --[ Case ]--9) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              continue ;
            end end 
        case --[ No_case ]--10 :
            if (typeof x2 == "number" or x2.tag ~= --[ No_case ]--10) then do
              return false;
            end else do
              _x2 = x2[0];
              _x1 = x1[0];
              continue ;
            end end 
        case --[ Intersection ]--11 :
            if (typeof x2 == "number" or x2.tag ~= --[ Intersection ]--11) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end 
        case --[ Complement ]--12 :
            if (typeof x2 == "number" or x2.tag ~= --[ Complement ]--12) then do
              return false;
            end else do
              return eq_list(x1[0], x2[0]);
            end end 
        case --[ Difference ]--13 :
            if (typeof x2 == "number" or !(x2.tag == --[ Difference ]--13 and equal$2(x1[0], x2[0]))) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              continue ;
            end end 
        case --[ Pmark ]--14 :
            if (typeof x2 == "number" or !(x2.tag == --[ Pmark ]--14 and x1[0] == x2[0])) then do
              return false;
            end else do
              _x2 = x2[1];
              _x1 = x1[1];
              continue ;
            end end 
        
      end
    end end 
  end;
end

function eq_list(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) then do
      if (l2 and equal$2(l1[0], l2[0])) then do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (l2) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end

function sequence(l) do
  if (l and !l[1]) then do
    return l[0];
  end else do
    return --[ Sequence ]--Block.__(1, [l]);
  end end 
end

function merge_sequences(_param) do
  while(true) do
    var param = _param;
    if (param) then do
      var x = param[0];
      if (typeof x ~= "number") then do
        switch (x.tag | 0) do
          case --[ Sequence ]--1 :
              var match = x[0];
              if (match) then do
                var y = match[1];
                var x$1 = match[0];
                var r$prime = merge_sequences(param[1]);
                var exit = 0;
                if (r$prime) then do
                  var match$1 = r$prime[0];
                  if (typeof match$1 == "number" or match$1.tag ~= --[ Sequence ]--1) then do
                    exit = 2;
                  end else do
                    var match$2 = match$1[0];
                    if (match$2 and equal$2(x$1, match$2[0])) then do
                      return --[ :: ]--[
                              --[ Sequence ]--Block.__(1, [--[ :: ]--[
                                    x$1,
                                    --[ :: ]--[
                                      --[ Alternative ]--Block.__(2, [--[ :: ]--[
                                            sequence(y),
                                            --[ :: ]--[
                                              sequence(match$2[1]),
                                              --[ [] ]--0
                                            ]
                                          ]]),
                                      --[ [] ]--0
                                    ]
                                  ]]),
                              r$prime[1]
                            ];
                    end else do
                      exit = 2;
                    end end 
                  end end 
                end else do
                  exit = 2;
                end end 
                if (exit == 2) then do
                  return --[ :: ]--[
                          --[ Sequence ]--Block.__(1, [--[ :: ]--[
                                x$1,
                                y
                              ]]),
                          r$prime
                        ];
                end
                 end 
              end
               end 
              break;
          case --[ Alternative ]--2 :
              _param = Pervasives.$at(x[0], param[1]);
              continue ;
          default:
            
        end
      end
       end 
      return --[ :: ]--[
              x,
              merge_sequences(param[1])
            ];
    end else do
      return --[ [] ]--0;
    end end 
  end;
end

function enforce_kind(ids, kind, kind$prime, cr) do
  if (kind ~= 332064784 or kind$prime == 332064784) then do
    return cr;
  end else do
    return seq$1(ids, kind$prime, cr, mk_expr(ids, --[ Eps ]--0));
  end end 
end

function translate(ids, kind, _ign_group, ign_case, _greedy, pos, cache, c, _param) do
  while(true) do
    var param = _param;
    var greedy = _greedy;
    var ign_group = _ign_group;
    if (typeof param == "number") then do
      switch (param) do
        case --[ Beg_of_line ]--0 :
            var c$1 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.newline);
            return --[ tuple ]--[
                    mk_expr(ids, --[ After ]--Block.__(7, [c$1])),
                    kind
                  ];
        case --[ End_of_line ]--1 :
            var c$2 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.newline);
            return --[ tuple ]--[
                    mk_expr(ids, --[ Before ]--Block.__(6, [c$2])),
                    kind
                  ];
        case --[ Beg_of_word ]--2 :
            var c$3 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.not_letter);
            var c$4 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.letter);
            return --[ tuple ]--[
                    seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ After ]--Block.__(7, [c$3])), mk_expr(ids, --[ Before ]--Block.__(6, [c$4]))),
                    kind
                  ];
        case --[ End_of_word ]--3 :
            var c$5 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.letter);
            var c$6 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.not_letter);
            return --[ tuple ]--[
                    seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ After ]--Block.__(7, [c$5])), mk_expr(ids, --[ Before ]--Block.__(6, [c$6]))),
                    kind
                  ];
        case --[ Not_bound ]--4 :
            return --[ tuple ]--[
                    alt(ids, --[ :: ]--[
                          seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ After ]--Block.__(7, [Re_automata_Category.letter])), mk_expr(ids, --[ Before ]--Block.__(6, [Re_automata_Category.letter]))),
                          --[ :: ]--[
                            seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ After ]--Block.__(7, [Re_automata_Category.letter])), mk_expr(ids, --[ Before ]--Block.__(6, [Re_automata_Category.letter]))),
                            --[ [] ]--0
                          ]
                        ]),
                    kind
                  ];
        case --[ Beg_of_str ]--5 :
            return --[ tuple ]--[
                    mk_expr(ids, --[ After ]--Block.__(7, [Re_automata_Category.inexistant])),
                    kind
                  ];
        case --[ End_of_str ]--6 :
            return --[ tuple ]--[
                    mk_expr(ids, --[ Before ]--Block.__(6, [Re_automata_Category.inexistant])),
                    kind
                  ];
        case --[ Last_end_of_line ]--7 :
            var c$7 = Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.inexistant, Re_automata_Category.lastnewline);
            return --[ tuple ]--[
                    mk_expr(ids, --[ Before ]--Block.__(6, [c$7])),
                    kind
                  ];
        case --[ Start ]--8 :
            return --[ tuple ]--[
                    mk_expr(ids, --[ After ]--Block.__(7, [Re_automata_Category.search_boundary])),
                    kind
                  ];
        case --[ Stop ]--9 :
            return --[ tuple ]--[
                    mk_expr(ids, --[ Before ]--Block.__(6, [Re_automata_Category.search_boundary])),
                    kind
                  ];
        
      end
    end else do
      switch (param.tag | 0) do
        case --[ Set ]--0 :
            return --[ tuple ]--[
                    cst(ids, trans_set(cache, c, param[0])),
                    kind
                  ];
        case --[ Sequence ]--1 :
            return --[ tuple ]--[
                    trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]),
                    kind
                  ];
        case --[ Alternative ]--2 :
            var merged_sequences = merge_sequences(param[0]);
            if (merged_sequences and !merged_sequences[1]) then do
              var match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, merged_sequences[0]);
              return --[ tuple ]--[
                      enforce_kind(ids, kind, match[1], match[0]),
                      kind
                    ];
            end
             end 
            return --[ tuple ]--[
                    alt(ids, List.map((function(ign_group,greedy)do
                            return function (r$prime) do
                              var match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r$prime);
                              return enforce_kind(ids, kind, match[1], match[0]);
                            end
                            end(ign_group,greedy)), merged_sequences)),
                    kind
                  ];
        case --[ Repeat ]--3 :
            var j = param[2];
            var i = param[1];
            var match$1 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]);
            var kind$prime = match$1[1];
            var cr = match$1[0];
            var rem;
            if (j ~= undefined) then do
              var f = greedy >= 620821490 ? (function(cr,kind$prime)do
                return function (rem) do
                  return alt(ids, --[ :: ]--[
                              mk_expr(ids, --[ Eps ]--0),
                              --[ :: ]--[
                                seq$1(ids, kind$prime, rename(ids, cr), rem),
                                --[ [] ]--0
                              ]
                            ]);
                end
                end(cr,kind$prime)) : (function(cr,kind$prime)do
                return function (rem) do
                  return alt(ids, --[ :: ]--[
                              seq$1(ids, kind$prime, rename(ids, cr), rem),
                              --[ :: ]--[
                                mk_expr(ids, --[ Eps ]--0),
                                --[ [] ]--0
                              ]
                            ]);
                end
                end(cr,kind$prime));
              rem = iter(j - i | 0, f, mk_expr(ids, --[ Eps ]--0));
            end else do
              rem = rep(ids, greedy, kind$prime, cr);
            end end 
            return --[ tuple ]--[
                    iter(i, (function(cr,kind$prime)do
                        return function (rem) do
                          return seq$1(ids, kind$prime, rename(ids, cr), rem);
                        end
                        end(cr,kind$prime)), rem),
                    kind
                  ];
        case --[ Sem ]--4 :
            var kind$prime$1 = param[0];
            var match$2 = translate(ids, kind$prime$1, ign_group, ign_case, greedy, pos, cache, c, param[1]);
            return --[ tuple ]--[
                    enforce_kind(ids, kind$prime$1, match$2[1], match$2[0]),
                    kind$prime$1
                  ];
        case --[ Sem_greedy ]--5 :
            _param = param[1];
            _greedy = param[0];
            continue ;
        case --[ Group ]--6 :
            var r$prime = param[0];
            if (ign_group) then do
              _param = r$prime;
              continue ;
            end else do
              var p = pos.contents;
              pos.contents = pos.contents + 2 | 0;
              var match$3 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r$prime);
              return --[ tuple ]--[
                      seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ Mark ]--Block.__(4, [p])), seq$1(ids, --[ First ]--332064784, match$3[0], mk_expr(ids, --[ Mark ]--Block.__(4, [p + 1 | 0])))),
                      match$3[1]
                    ];
            end end 
        case --[ No_group ]--7 :
            _param = param[0];
            _ign_group = true;
            continue ;
        case --[ Nest ]--8 :
            var b = pos.contents;
            var match$4 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[0]);
            var kind$prime$2 = match$4[1];
            var cr$1 = match$4[0];
            var e = pos.contents - 1 | 0;
            if (e < b) then do
              return --[ tuple ]--[
                      cr$1,
                      kind$prime$2
                    ];
            end else do
              return --[ tuple ]--[
                      seq$1(ids, --[ First ]--332064784, erase(ids, b, e), cr$1),
                      kind$prime$2
                    ];
            end end 
        case --[ Pmark ]--14 :
            var match$5 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param[1]);
            return --[ tuple ]--[
                    seq$1(ids, --[ First ]--332064784, mk_expr(ids, --[ Pmark ]--Block.__(8, [param[0]])), match$5[0]),
                    match$5[1]
                  ];
        default:
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "re.ml",
                  714,
                  4
                ]
              ];
      end
    end end 
  end;
end

function trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, param) do
  if (param) then do
    var rem = param[1];
    var r = param[0];
    if (rem) then do
      var match = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r);
      var cr$prime = match[0];
      var cr$prime$prime = trans_seq(ids, kind, ign_group, ign_case, greedy, pos, cache, c, rem);
      if (is_eps(cr$prime$prime)) then do
        return cr$prime;
      end else if (is_eps(cr$prime)) then do
        return cr$prime$prime;
      end else do
        return seq$1(ids, match[1], cr$prime, cr$prime$prime);
      end end  end 
    end else do
      var match$1 = translate(ids, kind, ign_group, ign_case, greedy, pos, cache, c, r);
      return enforce_kind(ids, kind, match$1[1], match$1[0]);
    end end 
  end else do
    return mk_expr(ids, --[ Eps ]--0);
  end end 
end

function case_insens(s) do
  return union(s, union(offset(32, inter(s, cupper)), offset(-32, inter(s, clower))));
end

function as_set(param) do
  if (typeof param == "number") then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "re.ml",
            747,
            13
          ]
        ];
  end else if (param.tag) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "re.ml",
            747,
            13
          ]
        ];
  end else do
    return param[0];
  end end  end 
end

function handle_case(_ign_case, _r) do
  while(true) do
    var r = _r;
    var ign_case = _ign_case;
    if (typeof r == "number") then do
      return r;
    end else do
      switch (r.tag | 0) do
        case --[ Set ]--0 :
            var s = r[0];
            return --[ Set ]--Block.__(0, [ign_case ? case_insens(s) : s]);
        case --[ Sequence ]--1 :
            return --[ Sequence ]--Block.__(1, [List.map((function(ign_case)do
                          return function (param) do
                            return handle_case(ign_case, param);
                          end
                          end(ign_case)), r[0])]);
        case --[ Alternative ]--2 :
            var l$prime = List.map((function(ign_case)do
                return function (param) do
                  return handle_case(ign_case, param);
                end
                end(ign_case)), r[0]);
            if (is_charset(--[ Alternative ]--Block.__(2, [l$prime]))) then do
              return --[ Set ]--Block.__(0, [List.fold_left((function (s, r) do
                                return union(s, as_set(r));
                              end), --[ [] ]--0, l$prime)]);
            end else do
              return --[ Alternative ]--Block.__(2, [l$prime]);
            end end 
        case --[ Repeat ]--3 :
            return --[ Repeat ]--Block.__(3, [
                      handle_case(ign_case, r[0]),
                      r[1],
                      r[2]
                    ]);
        case --[ Sem ]--4 :
            var r$prime = handle_case(ign_case, r[1]);
            if (is_charset(r$prime)) then do
              return r$prime;
            end else do
              return --[ Sem ]--Block.__(4, [
                        r[0],
                        r$prime
                      ]);
            end end 
        case --[ Sem_greedy ]--5 :
            var r$prime$1 = handle_case(ign_case, r[1]);
            if (is_charset(r$prime$1)) then do
              return r$prime$1;
            end else do
              return --[ Sem_greedy ]--Block.__(5, [
                        r[0],
                        r$prime$1
                      ]);
            end end 
        case --[ Group ]--6 :
            return --[ Group ]--Block.__(6, [handle_case(ign_case, r[0])]);
        case --[ No_group ]--7 :
            var r$prime$2 = handle_case(ign_case, r[0]);
            if (is_charset(r$prime$2)) then do
              return r$prime$2;
            end else do
              return --[ No_group ]--Block.__(7, [r$prime$2]);
            end end 
        case --[ Nest ]--8 :
            var r$prime$3 = handle_case(ign_case, r[0]);
            if (is_charset(r$prime$3)) then do
              return r$prime$3;
            end else do
              return --[ Nest ]--Block.__(8, [r$prime$3]);
            end end 
        case --[ Case ]--9 :
            _r = r[0];
            _ign_case = false;
            continue ;
        case --[ No_case ]--10 :
            _r = r[0];
            _ign_case = true;
            continue ;
        case --[ Intersection ]--11 :
            var l$prime$1 = List.map((function(ign_case)do
                return function (r) do
                  return handle_case(ign_case, r);
                end
                end(ign_case)), r[0]);
            return --[ Set ]--Block.__(0, [List.fold_left((function (s, r) do
                              return inter(s, as_set(r));
                            end), cany, l$prime$1)]);
        case --[ Complement ]--12 :
            var l$prime$2 = List.map((function(ign_case)do
                return function (r) do
                  return handle_case(ign_case, r);
                end
                end(ign_case)), r[0]);
            return --[ Set ]--Block.__(0, [diff(cany, List.fold_left((function (s, r) do
                                  return union(s, as_set(r));
                                end), --[ [] ]--0, l$prime$2))]);
        case --[ Difference ]--13 :
            return --[ Set ]--Block.__(0, [inter(as_set(handle_case(ign_case, r[0])), diff(cany, as_set(handle_case(ign_case, r[1]))))]);
        case --[ Pmark ]--14 :
            return --[ Pmark ]--Block.__(14, [
                      r[0],
                      handle_case(ign_case, r[1])
                    ]);
        
      end
    end end 
  end;
end

function anchored(_param) do
  while(true) do
    var param = _param;
    if (typeof param == "number") then do
      switch (param) do
        case --[ Beg_of_str ]--5 :
        case --[ Start ]--8 :
            return true;
        default:
          return false;
      end
    end else do
      switch (param.tag | 0) do
        case --[ Sequence ]--1 :
            return List.exists(anchored, param[0]);
        case --[ Alternative ]--2 :
            return List.for_all(anchored, param[0]);
        case --[ Repeat ]--3 :
            if (param[1] > 0) then do
              _param = param[0];
              continue ;
            end else do
              return false;
            end end 
        case --[ Group ]--6 :
        case --[ No_group ]--7 :
        case --[ Nest ]--8 :
        case --[ Case ]--9 :
        case --[ No_case ]--10 :
            _param = param[0];
            continue ;
        case --[ Sem ]--4 :
        case --[ Sem_greedy ]--5 :
        case --[ Pmark ]--14 :
            _param = param[1];
            continue ;
        default:
          return false;
      end
    end end 
  end;
end

function alt$1(l) do
  if (l and !l[1]) then do
    return l[0];
  end else do
    return --[ Alternative ]--Block.__(2, [l]);
  end end 
end

function seq$2(l) do
  if (l and !l[1]) then do
    return l[0];
  end else do
    return --[ Sequence ]--Block.__(1, [l]);
  end end 
end

var epsilon = --[ Sequence ]--Block.__(1, [--[ [] ]--0]);

function repn(r, i, j) do
  if (i < 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Re.repn"
        ];
  end
   end 
  if (j ~= undefined and j < i) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Re.repn"
        ];
  end
   end 
  return --[ Repeat ]--Block.__(3, [
            r,
            i,
            j
          ]);
end

function set(str) do
  var s = --[ [] ]--0;
  for(var i = 0 ,i_finish = #str - 1 | 0; i <= i_finish; ++i)do
    s = union(single(Caml_string.get(str, i)), s);
  end
  return --[ Set ]--Block.__(0, [s]);
end

function compl(l) do
  var r = --[ Complement ]--Block.__(12, [l]);
  if (is_charset(r)) then do
    return r;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Re.compl"
        ];
  end end 
end

var any = --[ Set ]--Block.__(0, [cany]);

var notnl = --[ Set ]--Block.__(0, [diff(cany, --[ :: ]--[
          --[ tuple ]--[
            --[ "\n" ]--10,
            --[ "\n" ]--10
          ],
          --[ [] ]--0
        ])]);

var lower = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ "a" ]--97, --[ "z" ]--122)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [--[ :: ]--[
              --[ tuple ]--[
                --[ "\181" ]--181,
                --[ "\181" ]--181
              ],
              --[ [] ]--0
            ]]),
        --[ :: ]--[
          --[ Set ]--Block.__(0, [seq(--[ "\223" ]--223, --[ "\246" ]--246)]),
          --[ :: ]--[
            --[ Set ]--Block.__(0, [seq(--[ "\248" ]--248, --[ "\255" ]--255)]),
            --[ [] ]--0
          ]
        ]
      ]
    ]);

var upper = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ "A" ]--65, --[ "Z" ]--90)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "\192" ]--192, --[ "\214" ]--214)]),
        --[ :: ]--[
          --[ Set ]--Block.__(0, [seq(--[ "\216" ]--216, --[ "\222" ]--222)]),
          --[ [] ]--0
        ]
      ]
    ]);

var alpha = alt$1(--[ :: ]--[
      lower,
      --[ :: ]--[
        upper,
        --[ :: ]--[
          --[ Set ]--Block.__(0, [--[ :: ]--[
                --[ tuple ]--[
                  --[ "\170" ]--170,
                  --[ "\170" ]--170
                ],
                --[ [] ]--0
              ]]),
          --[ :: ]--[
            --[ Set ]--Block.__(0, [--[ :: ]--[
                  --[ tuple ]--[
                    --[ "\186" ]--186,
                    --[ "\186" ]--186
                  ],
                  --[ [] ]--0
                ]]),
            --[ [] ]--0
          ]
        ]
      ]
    ]);

var digit = --[ Set ]--Block.__(0, [seq(--[ "0" ]--48, --[ "9" ]--57)]);

var alnum = alt$1(--[ :: ]--[
      alpha,
      --[ :: ]--[
        digit,
        --[ [] ]--0
      ]
    ]);

var wordc = alt$1(--[ :: ]--[
      alnum,
      --[ :: ]--[
        --[ Set ]--Block.__(0, [--[ :: ]--[
              --[ tuple ]--[
                --[ "_" ]--95,
                --[ "_" ]--95
              ],
              --[ [] ]--0
            ]]),
        --[ [] ]--0
      ]
    ]);

var ascii = --[ Set ]--Block.__(0, [seq(--[ "\000" ]--0, --[ "\127" ]--127)]);

var blank = set("\t ");

var cntrl = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ "\000" ]--0, --[ "\031" ]--31)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "\127" ]--127, --[ "\159" ]--159)]),
        --[ [] ]--0
      ]
    ]);

var graph = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ "!" ]--33, --[ "~" ]--126)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "\160" ]--160, --[ "\255" ]--255)]),
        --[ [] ]--0
      ]
    ]);

var print = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ " " ]--32, --[ "~" ]--126)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "\160" ]--160, --[ "\255" ]--255)]),
        --[ [] ]--0
      ]
    ]);

var punct = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [seq(--[ "!" ]--33, --[ "/" ]--47)]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ ":" ]--58, --[ "@" ]--64)]),
        --[ :: ]--[
          --[ Set ]--Block.__(0, [seq(--[ "[" ]--91, --[ "`" ]--96)]),
          --[ :: ]--[
            --[ Set ]--Block.__(0, [seq(--[ "{" ]--123, --[ "~" ]--126)]),
            --[ :: ]--[
              --[ Set ]--Block.__(0, [seq(--[ "\160" ]--160, --[ "\169" ]--169)]),
              --[ :: ]--[
                --[ Set ]--Block.__(0, [seq(--[ "\171" ]--171, --[ "\180" ]--180)]),
                --[ :: ]--[
                  --[ Set ]--Block.__(0, [seq(--[ "\182" ]--182, --[ "\185" ]--185)]),
                  --[ :: ]--[
                    --[ Set ]--Block.__(0, [seq(--[ "\187" ]--187, --[ "\191" ]--191)]),
                    --[ :: ]--[
                      --[ Set ]--Block.__(0, [--[ :: ]--[
                            --[ tuple ]--[
                              --[ "\215" ]--215,
                              --[ "\215" ]--215
                            ],
                            --[ [] ]--0
                          ]]),
                      --[ :: ]--[
                        --[ Set ]--Block.__(0, [--[ :: ]--[
                              --[ tuple ]--[
                                --[ "\247" ]--247,
                                --[ "\247" ]--247
                              ],
                              --[ [] ]--0
                            ]]),
                        --[ [] ]--0
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]);

var space = alt$1(--[ :: ]--[
      --[ Set ]--Block.__(0, [--[ :: ]--[
            --[ tuple ]--[
              --[ " " ]--32,
              --[ " " ]--32
            ],
            --[ [] ]--0
          ]]),
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "\t" ]--9, --[ "\r" ]--13)]),
        --[ [] ]--0
      ]
    ]);

var xdigit = alt$1(--[ :: ]--[
      digit,
      --[ :: ]--[
        --[ Set ]--Block.__(0, [seq(--[ "a" ]--97, --[ "f" ]--102)]),
        --[ :: ]--[
          --[ Set ]--Block.__(0, [seq(--[ "A" ]--65, --[ "F" ]--70)]),
          --[ [] ]--0
        ]
      ]
    ]);

function compile(r) do
  var regexp = anchored(r) ? --[ Group ]--Block.__(6, [r]) : seq$2(--[ :: ]--[
          --[ Sem ]--Block.__(4, [
              --[ Shortest ]---1034406550,
              repn(any, 0, undefined)
            ]),
          --[ :: ]--[
            --[ Group ]--Block.__(6, [r]),
            --[ [] ]--0
          ]
        ]);
  var regexp$1 = handle_case(false, regexp);
  var c = Bytes.make(257, --[ "\000" ]--0);
  var need_lnl = colorize(c, regexp$1);
  var match = flatten_cmap(c);
  var ncol = match[2];
  var col = match[0];
  var lnl = need_lnl ? ncol : -1;
  var ncol$1 = need_lnl ? ncol + 1 | 0 : ncol;
  var ids = do
    contents: 0
  end;
  var pos = do
    contents: 0
  end;
  var match$1 = translate(ids, --[ First ]--332064784, false, false, --[ Greedy ]---904640576, pos, do
        contents: --[ Empty ]--0
      end, col, regexp$1);
  var r$1 = enforce_kind(ids, --[ First ]--332064784, match$1[1], match$1[0]);
  var init = r$1;
  var cols = col;
  var col_repr = match[1];
  var ncol$2 = ncol$1;
  var lnl$1 = lnl;
  var group_count = pos.contents / 2 | 0;
  return do
          initial: init,
          initial_states: --[ [] ]--0,
          cols: cols,
          col_repr: col_repr,
          ncol: ncol$2,
          lnl: lnl$1,
          tbl: do
            contents: [false]
          end,
          states: Curry._1(Re_automata_State.Table.create, 97),
          group_count: group_count
        end;
end

function exec_internal(name, posOpt, lenOpt, groups, re, s) do
  var pos = posOpt ~= undefined ? posOpt : 0;
  var len = lenOpt ~= undefined ? lenOpt : -1;
  if (pos < 0 or len < -1 or (pos + len | 0) > #s) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          name
        ];
  end
   end 
  var groups$1 = groups;
  var partial = false;
  var re$1 = re;
  var s$1 = s;
  var pos$1 = pos;
  var len$1 = len;
  var slen = #s$1;
  var last = len$1 == -1 ? slen : pos$1 + len$1 | 0;
  var tmp;
  if (groups$1) then do
    var n = #re$1.tbl.contents + 1 | 0;
    tmp = n <= 10 ? [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ] : Caml_array.caml_make_vect(n, 0);
  end else do
    tmp = [];
  end end 
  var info = do
    re: re$1,
    i_cols: re$1.cols,
    positions: tmp,
    pos: pos$1,
    last: last
  end;
  var initial_cat = pos$1 == 0 ? Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, Re_automata_Category.inexistant) : Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, category(re$1, get_color(re$1, s$1, pos$1 - 1 | 0)));
  var initial_state = find_initial_state(re$1, initial_cat);
  var st = scan_str(info, s$1, initial_state, groups$1);
  var res;
  if (st.idx == -3 or partial) then do
    res = status(st.desc);
  end else do
    var final_cat = last == slen ? Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, Re_automata_Category.inexistant) : Curry._2(Re_automata_Category.$plus$plus, Re_automata_Category.search_boundary, category(re$1, get_color(re$1, s$1, last)));
    var match = $$final(info, st, final_cat);
    if (groups$1) then do
      Caml_array.caml_array_set(info.positions, match[0], last + 1 | 0);
    end
     end 
    res = match[1];
  end end 
  if (typeof res == "number") then do
    if (res ~= 0) then do
      return --[ Running ]--1;
    end else do
      return --[ Failed ]--0;
    end end 
  end else do
    return --[ Match ]--[do
              s: s$1,
              marks: res[0],
              pmarks: res[1],
              gpos: info.positions,
              gcount: re$1.group_count
            end];
  end end 
end

function offset$1(t, i) do
  if (((i << 1) + 1 | 0) >= #t.marks) then do
    throw Caml_builtin_exceptions.not_found;
  end
   end 
  var m1 = Caml_array.caml_array_get(t.marks, (i << 1));
  if (m1 == -1) then do
    throw Caml_builtin_exceptions.not_found;
  end
   end 
  var p1 = Caml_array.caml_array_get(t.gpos, m1) - 1 | 0;
  var p2 = Caml_array.caml_array_get(t.gpos, Caml_array.caml_array_get(t.marks, (i << 1) + 1 | 0)) - 1 | 0;
  return --[ tuple ]--[
          p1,
          p2
        ];
end

function get(t, i) do
  var match = offset$1(t, i);
  var p1 = match[0];
  return $$String.sub(t.s, p1, match[1] - p1 | 0);
end

var Parse_error = Caml_exceptions.create("Parse_error");

var Not_supported = Caml_exceptions.create("Not_supported");

function posix_class_of_string(class_) do
  switch (class_) do
    case "alnum" :
        return alnum;
    case "ascii" :
        return ascii;
    case "blank" :
        return blank;
    case "cntrl" :
        return cntrl;
    case "digit" :
        return digit;
    case "graph" :
        return graph;
    case "lower" :
        return lower;
    case "print" :
        return print;
    case "punct" :
        return punct;
    case "space" :
        return space;
    case "upper" :
        return upper;
    case "word" :
        return wordc;
    case "xdigit" :
        return xdigit;
    default:
      var s = "Invalid pcre class: " .. class_;
      throw [
            Caml_builtin_exceptions.invalid_argument,
            s
          ];
  end
end

function parse(multiline, dollar_endonly, dotall, ungreedy, s) do
  var i = do
    contents: 0
  end;
  var l = #s;
  var test = function (c) do
    if (i.contents ~= l) then do
      return Caml_string.get(s, i.contents) == c;
    end else do
      return false;
    end end 
  end;
  var accept = function (c) do
    var r = test(c);
    if (r) then do
      i.contents = i.contents + 1 | 0;
    end
     end 
    return r;
  end;
  var accept_s = function (s$prime) do
    var len = #s$prime;
    try do
      for(var j = 0 ,j_finish = len - 1 | 0; j <= j_finish; ++j)do
        try do
          if (Caml_string.get(s$prime, j) ~= Caml_string.get(s, i.contents + j | 0)) then do
            throw Pervasives.Exit;
          end
           end 
        end
        catch (exn)do
          throw Pervasives.Exit;
        end
      end
      i.contents = i.contents + len | 0;
      return true;
    end
    catch (exn$1)do
      if (exn$1 == Pervasives.Exit) then do
        return false;
      end else do
        throw exn$1;
      end end 
    end
  end;
  var get = function (param) do
    var r = Caml_string.get(s, i.contents);
    i.contents = i.contents + 1 | 0;
    return r;
  end;
  var greedy_mod = function (r) do
    var gr = accept(--[ "?" ]--63);
    var gr$1 = ungreedy ? !gr : gr;
    if (gr$1) then do
      return --[ Sem_greedy ]--Block.__(5, [
                --[ Non_greedy ]--620821490,
                r
              ]);
    end else do
      return --[ Sem_greedy ]--Block.__(5, [
                --[ Greedy ]---904640576,
                r
              ]);
    end end 
  end;
  var atom = function (param) do
    if (accept(--[ "." ]--46)) then do
      if (dotall) then do
        return any;
      end else do
        return notnl;
      end end 
    end else if (accept(--[ "(" ]--40)) then do
      if (accept(--[ "?" ]--63)) then do
        if (accept(--[ ":" ]--58)) then do
          var r = regexp$prime(branch$prime(--[ [] ]--0));
          if (!accept(--[ ")" ]--41)) then do
            throw Parse_error;
          end
           end 
          return r;
        end else if (accept(--[ "#" ]--35)) then do
          var _param = --[ () ]--0;
          while(true) do
            if (accept(--[ ")" ]--41)) then do
              return epsilon;
            end else do
              i.contents = i.contents + 1 | 0;
              _param = --[ () ]--0;
              continue ;
            end end 
          end;
        end else do
          throw Parse_error;
        end end  end 
      end else do
        var r$1 = regexp$prime(branch$prime(--[ [] ]--0));
        if (!accept(--[ ")" ]--41)) then do
          throw Parse_error;
        end
         end 
        return --[ Group ]--Block.__(6, [r$1]);
      end end 
    end else if (accept(--[ "^" ]--94)) then do
      if (multiline) then do
        return --[ Beg_of_line ]--0;
      end else do
        return --[ Beg_of_str ]--5;
      end end 
    end else if (accept(--[ "$" ]--36)) then do
      if (multiline) then do
        return --[ End_of_line ]--1;
      end else if (dollar_endonly) then do
        return --[ Last_end_of_line ]--7;
      end else do
        return --[ End_of_str ]--6;
      end end  end 
    end else if (accept(--[ "[" ]--91)) then do
      if (accept(--[ "^" ]--94)) then do
        return compl(bracket(--[ [] ]--0));
      end else do
        return alt$1(bracket(--[ [] ]--0));
      end end 
    end else if (accept(--[ "\\" ]--92)) then do
      if (i.contents == l) then do
        throw Parse_error;
      end
       end 
      var c = get(--[ () ]--0);
      switch (c) do
        case 48 :
        case 49 :
        case 50 :
        case 51 :
        case 52 :
        case 53 :
        case 54 :
        case 55 :
        case 56 :
        case 57 :
            throw Not_supported;
        case 65 :
            return --[ Beg_of_str ]--5;
        case 66 :
            return --[ Not_bound ]--4;
        case 68 :
            return compl(--[ :: ]--[
                        digit,
                        --[ [] ]--0
                      ]);
        case 71 :
            return --[ Start ]--8;
        case 83 :
            return compl(--[ :: ]--[
                        space,
                        --[ [] ]--0
                      ]);
        case 87 :
            return compl(--[ :: ]--[
                        alnum,
                        --[ :: ]--[
                          --[ Set ]--Block.__(0, [--[ :: ]--[
                                --[ tuple ]--[
                                  --[ "_" ]--95,
                                  --[ "_" ]--95
                                ],
                                --[ [] ]--0
                              ]]),
                          --[ [] ]--0
                        ]
                      ]);
        case 90 :
            return --[ Last_end_of_line ]--7;
        case 58 :
        case 59 :
        case 60 :
        case 61 :
        case 62 :
        case 63 :
        case 64 :
        case 91 :
        case 92 :
        case 93 :
        case 94 :
        case 95 :
        case 96 :
            return --[ Set ]--Block.__(0, [single(c)]);
        case 98 :
            return alt$1(--[ :: ]--[
                        --[ Beg_of_word ]--2,
                        --[ :: ]--[
                          --[ End_of_word ]--3,
                          --[ [] ]--0
                        ]
                      ]);
        case 100 :
            return digit;
        case 115 :
            return space;
        case 119 :
            return alt$1(--[ :: ]--[
                        alnum,
                        --[ :: ]--[
                          --[ Set ]--Block.__(0, [--[ :: ]--[
                                --[ tuple ]--[
                                  --[ "_" ]--95,
                                  --[ "_" ]--95
                                ],
                                --[ [] ]--0
                              ]]),
                          --[ [] ]--0
                        ]
                      ]);
        case 67 :
        case 69 :
        case 70 :
        case 72 :
        case 73 :
        case 74 :
        case 75 :
        case 76 :
        case 77 :
        case 78 :
        case 79 :
        case 80 :
        case 81 :
        case 82 :
        case 84 :
        case 85 :
        case 86 :
        case 88 :
        case 89 :
        case 97 :
        case 99 :
        case 101 :
        case 102 :
        case 103 :
        case 104 :
        case 105 :
        case 106 :
        case 107 :
        case 108 :
        case 109 :
        case 110 :
        case 111 :
        case 112 :
        case 113 :
        case 114 :
        case 116 :
        case 117 :
        case 118 :
        case 120 :
        case 121 :
            throw Parse_error;
        case 122 :
            return --[ End_of_str ]--6;
        default:
          return --[ Set ]--Block.__(0, [single(c)]);
      end
    end else do
      if (i.contents == l) then do
        throw Parse_error;
      end
       end 
      var c$1 = get(--[ () ]--0);
      if (c$1 >= 64) then do
        if (c$1 ~= 92) then do
          if (c$1 ~= 123) then do
            return --[ Set ]--Block.__(0, [single(c$1)]);
          end else do
            throw Parse_error;
          end end 
        end else do
          throw Parse_error;
        end end 
      end else if (c$1 >= 44) then do
        if (c$1 >= 63) then do
          throw Parse_error;
        end
         end 
        return --[ Set ]--Block.__(0, [single(c$1)]);
      end else do
        if (c$1 >= 42) then do
          throw Parse_error;
        end
         end 
        return --[ Set ]--Block.__(0, [single(c$1)]);
      end end  end 
    end end  end  end  end  end  end 
  end;
  var integer = function (param) do
    if (i.contents == l) then do
      return ;
    end else do
      var d = get(--[ () ]--0);
      if (d > 57 or d < 48) then do
        i.contents = i.contents - 1 | 0;
        return ;
      end else do
        var _i = d - --[ "0" ]--48 | 0;
        while(true) do
          var i$1 = _i;
          if (i.contents == l) then do
            return i$1;
          end else do
            var d$1 = get(--[ () ]--0);
            if (d$1 > 57 or d$1 < 48) then do
              i.contents = i.contents - 1 | 0;
              return i$1;
            end else do
              var i$prime = Caml_int32.imul(10, i$1) + (d$1 - --[ "0" ]--48 | 0) | 0;
              if (i$prime < i$1) then do
                throw Parse_error;
              end
               end 
              _i = i$prime;
              continue ;
            end end 
          end end 
        end;
      end end 
    end end 
  end;
  var branch$prime = function (_left) do
    while(true) do
      var left = _left;
      if (i.contents == l or test(--[ "|" ]--124) or test(--[ ")" ]--41)) then do
        return seq$2(List.rev(left));
      end else do
        _left = --[ :: ]--[
          piece(--[ () ]--0),
          left
        ];
        continue ;
      end end 
    end;
  end;
  var regexp$prime = function (_left) do
    while(true) do
      var left = _left;
      if (accept(--[ "|" ]--124)) then do
        _left = alt$1(--[ :: ]--[
              left,
              --[ :: ]--[
                branch$prime(--[ [] ]--0),
                --[ [] ]--0
              ]
            ]);
        continue ;
      end else do
        return left;
      end end 
    end;
  end;
  var bracket = function (_s) do
    while(true) do
      var s = _s;
      if (s ~= --[ [] ]--0 and accept(--[ "]" ]--93)) then do
        return s;
      end else do
        var match = $$char(--[ () ]--0);
        if (match[0] >= 748194550) then do
          var c = match[1];
          if (accept(--[ "-" ]--45)) then do
            if (accept(--[ "]" ]--93)) then do
              return --[ :: ]--[
                      --[ Set ]--Block.__(0, [single(c)]),
                      --[ :: ]--[
                        --[ Set ]--Block.__(0, [--[ :: ]--[
                              --[ tuple ]--[
                                --[ "-" ]--45,
                                --[ "-" ]--45
                              ],
                              --[ [] ]--0
                            ]]),
                        s
                      ]
                    ];
            end else do
              var match$1 = $$char(--[ () ]--0);
              if (match$1[0] >= 748194550) then do
                _s = --[ :: ]--[
                  --[ Set ]--Block.__(0, [seq(c, match$1[1])]),
                  s
                ];
                continue ;
              end else do
                return --[ :: ]--[
                        --[ Set ]--Block.__(0, [single(c)]),
                        --[ :: ]--[
                          --[ Set ]--Block.__(0, [--[ :: ]--[
                                --[ tuple ]--[
                                  --[ "-" ]--45,
                                  --[ "-" ]--45
                                ],
                                --[ [] ]--0
                              ]]),
                          --[ :: ]--[
                            match$1[1],
                            s
                          ]
                        ]
                      ];
              end end 
            end end 
          end else do
            _s = --[ :: ]--[
              --[ Set ]--Block.__(0, [single(c)]),
              s
            ];
            continue ;
          end end 
        end else do
          _s = --[ :: ]--[
            match[1],
            s
          ];
          continue ;
        end end 
      end end 
    end;
  end;
  var $$char = function (param) do
    if (i.contents == l) then do
      throw Parse_error;
    end
     end 
    var c = get(--[ () ]--0);
    if (c == --[ "[" ]--91) then do
      if (accept(--[ "=" ]--61)) then do
        throw Not_supported;
      end
       end 
      if (accept(--[ ":" ]--58)) then do
        var compl$1 = accept(--[ "^" ]--94);
        var cls;
        try do
          cls = List.find(accept_s, --[ :: ]--[
                "alnum",
                --[ :: ]--[
                  "ascii",
                  --[ :: ]--[
                    "blank",
                    --[ :: ]--[
                      "cntrl",
                      --[ :: ]--[
                        "digit",
                        --[ :: ]--[
                          "lower",
                          --[ :: ]--[
                            "print",
                            --[ :: ]--[
                              "space",
                              --[ :: ]--[
                                "upper",
                                --[ :: ]--[
                                  "word",
                                  --[ :: ]--[
                                    "punct",
                                    --[ :: ]--[
                                      "graph",
                                      --[ :: ]--[
                                        "xdigit",
                                        --[ [] ]--0
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]);
        end
        catch (exn)do
          if (exn == Caml_builtin_exceptions.not_found) then do
            throw Parse_error;
          end
           end 
          throw exn;
        end
        if (!accept_s(":]")) then do
          throw Parse_error;
        end
         end 
        var posix_class = posix_class_of_string(cls);
        var re = compl$1 ? compl(--[ :: ]--[
                posix_class,
                --[ [] ]--0
              ]) : posix_class;
        return --[ `Set ]--[
                4150146,
                re
              ];
      end else if (accept(--[ "." ]--46)) then do
        if (i.contents == l) then do
          throw Parse_error;
        end
         end 
        var c$1 = get(--[ () ]--0);
        if (!accept(--[ "." ]--46)) then do
          throw Not_supported;
        end
         end 
        if (!accept(--[ "]" ]--93)) then do
          throw Parse_error;
        end
         end 
        return --[ `Char ]--[
                748194550,
                c$1
              ];
      end else do
        return --[ `Char ]--[
                748194550,
                c
              ];
      end end  end 
    end else if (c == --[ "\\" ]--92) then do
      var c$2 = get(--[ () ]--0);
      if (c$2 >= 58) then do
        if (c$2 >= 123) then do
          return --[ `Char ]--[
                  748194550,
                  c$2
                ];
        end else do
          switch (c$2 - 58 | 0) do
            case 10 :
                return --[ `Set ]--[
                        4150146,
                        compl(--[ :: ]--[
                              digit,
                              --[ [] ]--0
                            ])
                      ];
            case 25 :
                return --[ `Set ]--[
                        4150146,
                        compl(--[ :: ]--[
                              space,
                              --[ [] ]--0
                            ])
                      ];
            case 29 :
                return --[ `Set ]--[
                        4150146,
                        compl(--[ :: ]--[
                              alnum,
                              --[ :: ]--[
                                --[ Set ]--Block.__(0, [--[ :: ]--[
                                      --[ tuple ]--[
                                        --[ "_" ]--95,
                                        --[ "_" ]--95
                                      ],
                                      --[ [] ]--0
                                    ]]),
                                --[ [] ]--0
                              ]
                            ])
                      ];
            case 0 :
            case 1 :
            case 2 :
            case 3 :
            case 4 :
            case 5 :
            case 6 :
            case 33 :
            case 34 :
            case 35 :
            case 36 :
            case 37 :
            case 38 :
                return --[ `Char ]--[
                        748194550,
                        c$2
                      ];
            case 40 :
                return --[ `Char ]--[
                        748194550,
                        --[ "\b" ]--8
                      ];
            case 42 :
                return --[ `Set ]--[
                        4150146,
                        digit
                      ];
            case 52 :
                return --[ `Char ]--[
                        748194550,
                        --[ "\n" ]--10
                      ];
            case 56 :
                return --[ `Char ]--[
                        748194550,
                        --[ "\r" ]--13
                      ];
            case 57 :
                return --[ `Set ]--[
                        4150146,
                        space
                      ];
            case 58 :
                return --[ `Char ]--[
                        748194550,
                        --[ "\t" ]--9
                      ];
            case 61 :
                return --[ `Set ]--[
                        4150146,
                        alt$1(--[ :: ]--[
                              alnum,
                              --[ :: ]--[
                                --[ Set ]--Block.__(0, [--[ :: ]--[
                                      --[ tuple ]--[
                                        --[ "_" ]--95,
                                        --[ "_" ]--95
                                      ],
                                      --[ [] ]--0
                                    ]]),
                                --[ [] ]--0
                              ]
                            ])
                      ];
            case 7 :
            case 8 :
            case 9 :
            case 11 :
            case 12 :
            case 13 :
            case 14 :
            case 15 :
            case 16 :
            case 17 :
            case 18 :
            case 19 :
            case 20 :
            case 21 :
            case 22 :
            case 23 :
            case 24 :
            case 26 :
            case 27 :
            case 28 :
            case 30 :
            case 31 :
            case 32 :
            case 39 :
            case 41 :
            case 43 :
            case 44 :
            case 45 :
            case 46 :
            case 47 :
            case 48 :
            case 49 :
            case 50 :
            case 51 :
            case 53 :
            case 54 :
            case 55 :
            case 59 :
            case 60 :
            case 62 :
            case 63 :
            case 64 :
                throw Parse_error;
            
          end
        end end 
      end else do
        if (c$2 >= 48) then do
          throw Not_supported;
        end
         end 
        return --[ `Char ]--[
                748194550,
                c$2
              ];
      end end 
    end else do
      return --[ `Char ]--[
              748194550,
              c
            ];
    end end  end 
  end;
  var piece = function (param) do
    var r = atom(--[ () ]--0);
    if (accept(--[ "*" ]--42)) then do
      return greedy_mod(repn(r, 0, undefined));
    end else if (accept(--[ "+" ]--43)) then do
      return greedy_mod(repn(r, 1, undefined));
    end else if (accept(--[ "?" ]--63)) then do
      return greedy_mod(repn(r, 0, 1));
    end else if (accept(--[ "{" ]--123)) then do
      var match = integer(--[ () ]--0);
      if (match ~= undefined) then do
        var i$1 = match;
        var j = accept(--[ "," ]--44) ? integer(--[ () ]--0) : i$1;
        if (!accept(--[ "}" ]--125)) then do
          throw Parse_error;
        end
         end 
        if (j ~= undefined and j < i$1) then do
          throw Parse_error;
        end
         end 
        return greedy_mod(repn(r, i$1, j));
      end else do
        i.contents = i.contents - 1 | 0;
        return r;
      end end 
    end else do
      return r;
    end end  end  end  end 
  end;
  var res = regexp$prime(branch$prime(--[ [] ]--0));
  if (i.contents ~= l) then do
    throw Parse_error;
  end
   end 
  return res;
end

function re(flagsOpt, pat) do
  var flags = flagsOpt ~= undefined ? flagsOpt : --[ [] ]--0;
  var opts = List.map((function (param) do
          if (param ~= 601676297) then do
            if (param >= 613575188) then do
              return --[ Anchored ]--616470068;
            end else do
              return --[ Multiline ]--1071952589;
            end end 
          end else do
            return --[ Caseless ]--604571177;
          end end 
        end), flags);
  var optsOpt = opts;
  var s = pat;
  var opts$1 = optsOpt ~= undefined ? optsOpt : --[ [] ]--0;
  var r = parse(List.memq(--[ Multiline ]--1071952589, opts$1), List.memq(--[ Dollar_endonly ]---712595228, opts$1), List.memq(--[ Dotall ]---424303016, opts$1), List.memq(--[ Ungreedy ]---243745063, opts$1), s);
  var r$1 = List.memq(--[ Anchored ]--616470068, opts$1) ? seq$2(--[ :: ]--[
          --[ Start ]--8,
          --[ :: ]--[
            r,
            --[ [] ]--0
          ]
        ]) : r;
  if (List.memq(--[ Caseless ]--604571177, opts$1)) then do
    return --[ No_case ]--Block.__(10, [r$1]);
  end else do
    return r$1;
  end end 
end

function exec(rex, pos, s) do
  var pos$1 = pos;
  var len = undefined;
  var re = rex;
  var s$1 = s;
  var match = exec_internal("Re.exec", pos$1, len, true, re, s$1);
  if (typeof match == "number") then do
    throw Caml_builtin_exceptions.not_found;
  end
   end 
  return match[0];
end

var s = Caml_bytes.bytes_to_string(Bytes.make(1048575, --[ "a" ]--97)) .. "b";

eq("File \"xx.ml\", line 7, characters 3-10", get(exec(compile(re(undefined, "aa?b")), undefined, s), 0), "aab");

Mt.from_pair_suites("Ocaml_re_test", suites.contents);

--[ Table Not a pure module ]--
