'use strict';

var Curry = require("./curry.js");
var Caml_obj = require("./caml_obj.js");
var Pervasives = require("./pervasives.js");
var Caml_option = require("./caml_option.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function length(l) do
  var _len = 0;
  var _param = l;
  while(true) do
    var param = _param;
    var len = _len;
    if (param) do
      _param = param[1];
      _len = len + 1 | 0;
      continue ;
    end else do
      return len;
    end
  end;
end

function cons(a, l) do
  return --[ :: ]--[
          a,
          l
        ];
end

function hd(param) do
  if (param) do
    return param[0];
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "hd"
        ];
  end
end

function tl(param) do
  if (param) do
    return param[1];
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "tl"
        ];
  end
end

function nth(l, n) do
  if (n < 0) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.nth"
        ];
  end
  var _l = l;
  var _n = n;
  while(true) do
    var n$1 = _n;
    var l$1 = _l;
    if (l$1) do
      if (n$1 == 0) do
        return l$1[0];
      end else do
        _n = n$1 - 1 | 0;
        _l = l$1[1];
        continue ;
      end
    end else do
      throw [
            Caml_builtin_exceptions.failure,
            "nth"
          ];
    end
  end;
end

function nth_opt(l, n) do
  if (n < 0) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.nth"
        ];
  end
  var _l = l;
  var _n = n;
  while(true) do
    var n$1 = _n;
    var l$1 = _l;
    if (l$1) do
      if (n$1 == 0) do
        return Caml_option.some(l$1[0]);
      end else do
        _n = n$1 - 1 | 0;
        _l = l$1[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function rev_append(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) do
      _l2 = --[ :: ]--[
        l1[0],
        l2
      ];
      _l1 = l1[1];
      continue ;
    end else do
      return l2;
    end
  end;
end

function rev(l) do
  return rev_append(l, --[ [] ]--0);
end

function init_tailrec_aux(_acc, _i, n, f) do
  while(true) do
    var i = _i;
    var acc = _acc;
    if (i >= n) do
      return acc;
    end else do
      _i = i + 1 | 0;
      _acc = --[ :: ]--[
        Curry._1(f, i),
        acc
      ];
      continue ;
    end
  end;
end

function init_aux(i, n, f) do
  if (i >= n) do
    return --[ [] ]--0;
  end else do
    var r = Curry._1(f, i);
    return --[ :: ]--[
            r,
            init_aux(i + 1 | 0, n, f)
          ];
  end
end

function init(len, f) do
  if (len < 0) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.init"
        ];
  end
  if (len > 10000) do
    return rev_append(init_tailrec_aux(--[ [] ]--0, 0, len, f), --[ [] ]--0);
  end else do
    return init_aux(0, len, f);
  end
end

function flatten(param) do
  if (param) do
    return Pervasives.$at(param[0], flatten(param[1]));
  end else do
    return --[ [] ]--0;
  end
end

function map(f, param) do
  if (param) do
    var r = Curry._1(f, param[0]);
    return --[ :: ]--[
            r,
            map(f, param[1])
          ];
  end else do
    return --[ [] ]--0;
  end
end

function mapi(i, f, param) do
  if (param) do
    var r = Curry._2(f, i, param[0]);
    return --[ :: ]--[
            r,
            mapi(i + 1 | 0, f, param[1])
          ];
  end else do
    return --[ [] ]--0;
  end
end

function mapi$1(f, l) do
  return mapi(0, f, l);
end

function rev_map(f, l) do
  var _accu = --[ [] ]--0;
  var _param = l;
  while(true) do
    var param = _param;
    var accu = _accu;
    if (param) do
      _param = param[1];
      _accu = --[ :: ]--[
        Curry._1(f, param[0]),
        accu
      ];
      continue ;
    end else do
      return accu;
    end
  end;
end

function iter(f, _param) do
  while(true) do
    var param = _param;
    if (param) do
      Curry._1(f, param[0]);
      _param = param[1];
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function iteri(f, l) do
  var _i = 0;
  var f$1 = f;
  var _param = l;
  while(true) do
    var param = _param;
    var i = _i;
    if (param) do
      Curry._2(f$1, i, param[0]);
      _param = param[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end
  end;
end

function fold_left(f, _accu, _l) do
  while(true) do
    var l = _l;
    var accu = _accu;
    if (l) do
      _l = l[1];
      _accu = Curry._2(f, accu, l[0]);
      continue ;
    end else do
      return accu;
    end
  end;
end

function fold_right(f, l, accu) do
  if (l) do
    return Curry._2(f, l[0], fold_right(f, l[1], accu));
  end else do
    return accu;
  end
end

function map2(f, l1, l2) do
  if (l1) do
    if (l2) do
      var r = Curry._2(f, l1[0], l2[0]);
      return --[ :: ]--[
              r,
              map2(f, l1[1], l2[1])
            ];
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.map2"
          ];
    end
  end else if (l2) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.map2"
        ];
  end else do
    return --[ [] ]--0;
  end
end

function rev_map2(f, l1, l2) do
  var _accu = --[ [] ]--0;
  var _l1 = l1;
  var _l2 = l2;
  while(true) do
    var l2$1 = _l2;
    var l1$1 = _l1;
    var accu = _accu;
    if (l1$1) do
      if (l2$1) do
        _l2 = l2$1[1];
        _l1 = l1$1[1];
        _accu = --[ :: ]--[
          Curry._2(f, l1$1[0], l2$1[0]),
          accu
        ];
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.rev_map2"
            ];
      end
    end else do
      if (l2$1) do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.rev_map2"
            ];
      end
      return accu;
    end
  end;
end

function iter2(f, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) do
      if (l2) do
        Curry._2(f, l1[0], l2[0]);
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.iter2"
            ];
      end
    end else if (l2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.iter2"
          ];
    end else do
      return --[ () ]--0;
    end
  end;
end

function fold_left2(f, _accu, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    var accu = _accu;
    if (l1) do
      if (l2) do
        _l2 = l2[1];
        _l1 = l1[1];
        _accu = Curry._3(f, accu, l1[0], l2[0]);
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.fold_left2"
            ];
      end
    end else do
      if (l2) do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.fold_left2"
            ];
      end
      return accu;
    end
  end;
end

function fold_right2(f, l1, l2, accu) do
  if (l1) do
    if (l2) do
      return Curry._3(f, l1[0], l2[0], fold_right2(f, l1[1], l2[1], accu));
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end
  end else do
    if (l2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end
    return accu;
  end
end

function for_all(p, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (Curry._1(p, param[0])) do
        _param = param[1];
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
      if (Curry._1(p, param[0])) do
        return true;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function for_all2(p, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) do
      if (l2) do
        if (Curry._2(p, l1[0], l2[0])) do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
        end else do
          return false;
        end
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.for_all2"
            ];
      end
    end else if (l2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.for_all2"
          ];
    end else do
      return true;
    end
  end;
end

function exists2(p, _l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) do
      if (l2) do
        if (Curry._2(p, l1[0], l2[0])) do
          return true;
        end else do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
        end
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.exists2"
            ];
      end
    end else if (l2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.exists2"
          ];
    end else do
      return false;
    end
  end;
end

function mem(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (Caml_obj.caml_equal(param[0], x)) do
        return true;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function memq(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (param[0] == x) do
        return true;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function assoc(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var match = param[0];
      if (Caml_obj.caml_equal(match[0], x)) do
        return match[1];
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function assoc_opt(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var match = param[0];
      if (Caml_obj.caml_equal(match[0], x)) do
        return Caml_option.some(match[1]);
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function assq(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var match = param[0];
      if (match[0] == x) do
        return match[1];
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function assq_opt(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var match = param[0];
      if (match[0] == x) do
        return Caml_option.some(match[1]);
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function mem_assoc(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (Caml_obj.caml_equal(param[0][0], x)) do
        return true;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function mem_assq(x, _param) do
  while(true) do
    var param = _param;
    if (param) do
      if (param[0][0] == x) do
        return true;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return false;
    end
  end;
end

function remove_assoc(x, param) do
  if (param) do
    var l = param[1];
    var pair = param[0];
    if (Caml_obj.caml_equal(pair[0], x)) do
      return l;
    end else do
      return --[ :: ]--[
              pair,
              remove_assoc(x, l)
            ];
    end
  end else do
    return --[ [] ]--0;
  end
end

function remove_assq(x, param) do
  if (param) do
    var l = param[1];
    var pair = param[0];
    if (pair[0] == x) do
      return l;
    end else do
      return --[ :: ]--[
              pair,
              remove_assq(x, l)
            ];
    end
  end else do
    return --[ [] ]--0;
  end
end

function find(p, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var x = param[0];
      if (Curry._1(p, x)) do
        return x;
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function find_opt(p, _param) do
  while(true) do
    var param = _param;
    if (param) do
      var x = param[0];
      if (Curry._1(p, x)) do
        return Caml_option.some(x);
      end else do
        _param = param[1];
        continue ;
      end
    end else do
      return ;
    end
  end;
end

function find_all(p) do
  return (function (param) do
      var _accu = --[ [] ]--0;
      var _param = param;
      while(true) do
        var param$1 = _param;
        var accu = _accu;
        if (param$1) do
          var l = param$1[1];
          var x = param$1[0];
          if (Curry._1(p, x)) do
            _param = l;
            _accu = --[ :: ]--[
              x,
              accu
            ];
            continue ;
          end else do
            _param = l;
            continue ;
          end
        end else do
          return rev_append(accu, --[ [] ]--0);
        end
      end;
    end);
end

function partition(p, l) do
  var _yes = --[ [] ]--0;
  var _no = --[ [] ]--0;
  var _param = l;
  while(true) do
    var param = _param;
    var no = _no;
    var yes = _yes;
    if (param) do
      var l$1 = param[1];
      var x = param[0];
      if (Curry._1(p, x)) do
        _param = l$1;
        _yes = --[ :: ]--[
          x,
          yes
        ];
        continue ;
      end else do
        _param = l$1;
        _no = --[ :: ]--[
          x,
          no
        ];
        continue ;
      end
    end else do
      return --[ tuple ]--[
              rev_append(yes, --[ [] ]--0),
              rev_append(no, --[ [] ]--0)
            ];
    end
  end;
end

function split(param) do
  if (param) do
    var match = param[0];
    var match$1 = split(param[1]);
    return --[ tuple ]--[
            --[ :: ]--[
              match[0],
              match$1[0]
            ],
            --[ :: ]--[
              match[1],
              match$1[1]
            ]
          ];
  end else do
    return --[ tuple ]--[
            --[ [] ]--0,
            --[ [] ]--0
          ];
  end
end

function combine(l1, l2) do
  if (l1) do
    if (l2) do
      return --[ :: ]--[
              --[ tuple ]--[
                l1[0],
                l2[0]
              ],
              combine(l1[1], l2[1])
            ];
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.combine"
          ];
    end
  end else if (l2) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.combine"
        ];
  end else do
    return --[ [] ]--0;
  end
end

function merge(cmp, l1, l2) do
  if (l1) do
    if (l2) do
      var h2 = l2[0];
      var h1 = l1[0];
      if (Curry._2(cmp, h1, h2) <= 0) do
        return --[ :: ]--[
                h1,
                merge(cmp, l1[1], l2)
              ];
      end else do
        return --[ :: ]--[
                h2,
                merge(cmp, l1, l2[1])
              ];
      end
    end else do
      return l1;
    end
  end else do
    return l2;
  end
end

function chop(_k, _l) do
  while(true) do
    var l = _l;
    var k = _k;
    if (k == 0) do
      return l;
    end else if (l) do
      _l = l[1];
      _k = k - 1 | 0;
      continue ;
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "list.ml",
              262,
              11
            ]
          ];
    end
  end;
end

function stable_sort(cmp, l) do
  var sort = function (n, l) do
    if (n ~= 2) do
      if (n == 3 and l) do
        var match = l[1];
        if (match) do
          var match$1 = match[1];
          if (match$1) do
            var x3 = match$1[0];
            var x2 = match[0];
            var x1 = l[0];
            if (Curry._2(cmp, x1, x2) <= 0) do
              if (Curry._2(cmp, x2, x3) <= 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else if (Curry._2(cmp, x1, x3) <= 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                return --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end
            end else if (Curry._2(cmp, x1, x3) <= 0) do
              return --[ :: ]--[
                      x2,
                      --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x3,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end else if (Curry._2(cmp, x2, x3) <= 0) do
              return --[ :: ]--[
                      x2,
                      --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end else do
              return --[ :: ]--[
                      x3,
                      --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end
          end
          
        end
        
      end
      
    end else if (l) do
      var match$2 = l[1];
      if (match$2) do
        var x2$1 = match$2[0];
        var x1$1 = l[0];
        if (Curry._2(cmp, x1$1, x2$1) <= 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ :: ]--[
                    x2$1,
                    --[ [] ]--0
                  ]
                ];
        end else do
          return --[ :: ]--[
                  x2$1,
                  --[ :: ]--[
                    x1$1,
                    --[ [] ]--0
                  ]
                ];
        end
      end
      
    end
    var n1 = (n >> 1);
    var n2 = n - n1 | 0;
    var l2 = chop(n1, l);
    var s1 = rev_sort(n1, l);
    var s2 = rev_sort(n2, l2);
    var _l1 = s1;
    var _l2 = s2;
    var _accu = --[ [] ]--0;
    while(true) do
      var accu = _accu;
      var l2$1 = _l2;
      var l1 = _l1;
      if (l1) do
        if (l2$1) do
          var h2 = l2$1[0];
          var h1 = l1[0];
          if (Curry._2(cmp, h1, h2) > 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l1 = l1[1];
            continue ;
          end else do
            _accu = --[ :: ]--[
              h2,
              accu
            ];
            _l2 = l2$1[1];
            continue ;
          end
        end else do
          return rev_append(l1, accu);
        end
      end else do
        return rev_append(l2$1, accu);
      end
    end;
  end;
  var rev_sort = function (n, l) do
    if (n ~= 2) do
      if (n == 3 and l) do
        var match = l[1];
        if (match) do
          var match$1 = match[1];
          if (match$1) do
            var x3 = match$1[0];
            var x2 = match[0];
            var x1 = l[0];
            if (Curry._2(cmp, x1, x2) > 0) do
              if (Curry._2(cmp, x2, x3) > 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else if (Curry._2(cmp, x1, x3) > 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                return --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end
            end else if (Curry._2(cmp, x1, x3) > 0) do
              return --[ :: ]--[
                      x2,
                      --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x3,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end else if (Curry._2(cmp, x2, x3) > 0) do
              return --[ :: ]--[
                      x2,
                      --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end else do
              return --[ :: ]--[
                      x3,
                      --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ]
                    ];
            end
          end
          
        end
        
      end
      
    end else if (l) do
      var match$2 = l[1];
      if (match$2) do
        var x2$1 = match$2[0];
        var x1$1 = l[0];
        if (Curry._2(cmp, x1$1, x2$1) > 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ :: ]--[
                    x2$1,
                    --[ [] ]--0
                  ]
                ];
        end else do
          return --[ :: ]--[
                  x2$1,
                  --[ :: ]--[
                    x1$1,
                    --[ [] ]--0
                  ]
                ];
        end
      end
      
    end
    var n1 = (n >> 1);
    var n2 = n - n1 | 0;
    var l2 = chop(n1, l);
    var s1 = sort(n1, l);
    var s2 = sort(n2, l2);
    var _l1 = s1;
    var _l2 = s2;
    var _accu = --[ [] ]--0;
    while(true) do
      var accu = _accu;
      var l2$1 = _l2;
      var l1 = _l1;
      if (l1) do
        if (l2$1) do
          var h2 = l2$1[0];
          var h1 = l1[0];
          if (Curry._2(cmp, h1, h2) <= 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l1 = l1[1];
            continue ;
          end else do
            _accu = --[ :: ]--[
              h2,
              accu
            ];
            _l2 = l2$1[1];
            continue ;
          end
        end else do
          return rev_append(l1, accu);
        end
      end else do
        return rev_append(l2$1, accu);
      end
    end;
  end;
  var len = length(l);
  if (len < 2) do
    return l;
  end else do
    return sort(len, l);
  end
end

function sort_uniq(cmp, l) do
  var sort = function (n, l) do
    if (n ~= 2) do
      if (n == 3 and l) do
        var match = l[1];
        if (match) do
          var match$1 = match[1];
          if (match$1) do
            var x3 = match$1[0];
            var x2 = match[0];
            var x1 = l[0];
            var c = Curry._2(cmp, x1, x2);
            if (c == 0) do
              var c$1 = Curry._2(cmp, x2, x3);
              if (c$1 == 0) do
                return --[ :: ]--[
                        x2,
                        --[ [] ]--0
                      ];
              end else if (c$1 < 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x3,
                          --[ [] ]--0
                        ]
                      ];
              end else do
                return --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end
            end else if (c < 0) do
              var c$2 = Curry._2(cmp, x2, x3);
              if (c$2 == 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$2 < 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                var c$3 = Curry._2(cmp, x1, x3);
                if (c$3 == 0) do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$3 < 0) do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x3,
                            --[ :: ]--[
                              x2,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end else do
                  return --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x1,
                            --[ :: ]--[
                              x2,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end
              end
            end else do
              var c$4 = Curry._2(cmp, x1, x3);
              if (c$4 == 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$4 < 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                var c$5 = Curry._2(cmp, x2, x3);
                if (c$5 == 0) do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x1,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$5 < 0) do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ :: ]--[
                              x1,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end else do
                  return --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x2,
                            --[ :: ]--[
                              x1,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end
              end
            end
          end
          
        end
        
      end
      
    end else if (l) do
      var match$2 = l[1];
      if (match$2) do
        var x2$1 = match$2[0];
        var x1$1 = l[0];
        var c$6 = Curry._2(cmp, x1$1, x2$1);
        if (c$6 == 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ [] ]--0
                ];
        end else if (c$6 < 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ :: ]--[
                    x2$1,
                    --[ [] ]--0
                  ]
                ];
        end else do
          return --[ :: ]--[
                  x2$1,
                  --[ :: ]--[
                    x1$1,
                    --[ [] ]--0
                  ]
                ];
        end
      end
      
    end
    var n1 = (n >> 1);
    var n2 = n - n1 | 0;
    var l2 = chop(n1, l);
    var s1 = rev_sort(n1, l);
    var s2 = rev_sort(n2, l2);
    var _l1 = s1;
    var _l2 = s2;
    var _accu = --[ [] ]--0;
    while(true) do
      var accu = _accu;
      var l2$1 = _l2;
      var l1 = _l1;
      if (l1) do
        if (l2$1) do
          var t2 = l2$1[1];
          var h2 = l2$1[0];
          var t1 = l1[1];
          var h1 = l1[0];
          var c$7 = Curry._2(cmp, h1, h2);
          if (c$7 == 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l2 = t2;
            _l1 = t1;
            continue ;
          end else if (c$7 > 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l1 = t1;
            continue ;
          end else do
            _accu = --[ :: ]--[
              h2,
              accu
            ];
            _l2 = t2;
            continue ;
          end
        end else do
          return rev_append(l1, accu);
        end
      end else do
        return rev_append(l2$1, accu);
      end
    end;
  end;
  var rev_sort = function (n, l) do
    if (n ~= 2) do
      if (n == 3 and l) do
        var match = l[1];
        if (match) do
          var match$1 = match[1];
          if (match$1) do
            var x3 = match$1[0];
            var x2 = match[0];
            var x1 = l[0];
            var c = Curry._2(cmp, x1, x2);
            if (c == 0) do
              var c$1 = Curry._2(cmp, x2, x3);
              if (c$1 == 0) do
                return --[ :: ]--[
                        x2,
                        --[ [] ]--0
                      ];
              end else if (c$1 > 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x3,
                          --[ [] ]--0
                        ]
                      ];
              end else do
                return --[ :: ]--[
                        x3,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end
            end else if (c > 0) do
              var c$2 = Curry._2(cmp, x2, x3);
              if (c$2 == 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$2 > 0) do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                var c$3 = Curry._2(cmp, x1, x3);
                if (c$3 == 0) do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$3 > 0) do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x3,
                            --[ :: ]--[
                              x2,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end else do
                  return --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x1,
                            --[ :: ]--[
                              x2,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end
              end
            end else do
              var c$4 = Curry._2(cmp, x1, x3);
              if (c$4 == 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$4 > 0) do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x3,
                            --[ [] ]--0
                          ]
                        ]
                      ];
              end else do
                var c$5 = Curry._2(cmp, x2, x3);
                if (c$5 == 0) do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x1,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$5 > 0) do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x3,
                            --[ :: ]--[
                              x1,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end else do
                  return --[ :: ]--[
                          x3,
                          --[ :: ]--[
                            x2,
                            --[ :: ]--[
                              x1,
                              --[ [] ]--0
                            ]
                          ]
                        ];
                end
              end
            end
          end
          
        end
        
      end
      
    end else if (l) do
      var match$2 = l[1];
      if (match$2) do
        var x2$1 = match$2[0];
        var x1$1 = l[0];
        var c$6 = Curry._2(cmp, x1$1, x2$1);
        if (c$6 == 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ [] ]--0
                ];
        end else if (c$6 > 0) do
          return --[ :: ]--[
                  x1$1,
                  --[ :: ]--[
                    x2$1,
                    --[ [] ]--0
                  ]
                ];
        end else do
          return --[ :: ]--[
                  x2$1,
                  --[ :: ]--[
                    x1$1,
                    --[ [] ]--0
                  ]
                ];
        end
      end
      
    end
    var n1 = (n >> 1);
    var n2 = n - n1 | 0;
    var l2 = chop(n1, l);
    var s1 = sort(n1, l);
    var s2 = sort(n2, l2);
    var _l1 = s1;
    var _l2 = s2;
    var _accu = --[ [] ]--0;
    while(true) do
      var accu = _accu;
      var l2$1 = _l2;
      var l1 = _l1;
      if (l1) do
        if (l2$1) do
          var t2 = l2$1[1];
          var h2 = l2$1[0];
          var t1 = l1[1];
          var h1 = l1[0];
          var c$7 = Curry._2(cmp, h1, h2);
          if (c$7 == 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l2 = t2;
            _l1 = t1;
            continue ;
          end else if (c$7 < 0) do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l1 = t1;
            continue ;
          end else do
            _accu = --[ :: ]--[
              h2,
              accu
            ];
            _l2 = t2;
            continue ;
          end
        end else do
          return rev_append(l1, accu);
        end
      end else do
        return rev_append(l2$1, accu);
      end
    end;
  end;
  var len = length(l);
  if (len < 2) do
    return l;
  end else do
    return sort(len, l);
  end
end

function compare_lengths(_l1, _l2) do
  while(true) do
    var l2 = _l2;
    var l1 = _l1;
    if (l1) do
      if (l2) do
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        return 1;
      end
    end else if (l2) do
      return -1;
    end else do
      return 0;
    end
  end;
end

function compare_length_with(_l, _n) do
  while(true) do
    var n = _n;
    var l = _l;
    if (l) do
      if (n <= 0) do
        return 1;
      end else do
        _n = n - 1 | 0;
        _l = l[1];
        continue ;
      end
    end else if (n == 0) do
      return 0;
    end else if (n > 0) do
      return -1;
    end else do
      return 1;
    end
  end;
end

var append = Pervasives.$at;

var concat = flatten;

var filter = find_all;

var sort = stable_sort;

var fast_sort = stable_sort;

exports.length = length;
exports.compare_lengths = compare_lengths;
exports.compare_length_with = compare_length_with;
exports.cons = cons;
exports.hd = hd;
exports.tl = tl;
exports.nth = nth;
exports.nth_opt = nth_opt;
exports.rev = rev;
exports.init = init;
exports.append = append;
exports.rev_append = rev_append;
exports.concat = concat;
exports.flatten = flatten;
exports.iter = iter;
exports.iteri = iteri;
exports.map = map;
exports.mapi = mapi$1;
exports.rev_map = rev_map;
exports.fold_left = fold_left;
exports.fold_right = fold_right;
exports.iter2 = iter2;
exports.map2 = map2;
exports.rev_map2 = rev_map2;
exports.fold_left2 = fold_left2;
exports.fold_right2 = fold_right2;
exports.for_all = for_all;
exports.exists = exists;
exports.for_all2 = for_all2;
exports.exists2 = exists2;
exports.mem = mem;
exports.memq = memq;
exports.find = find;
exports.find_opt = find_opt;
exports.filter = filter;
exports.find_all = find_all;
exports.partition = partition;
exports.assoc = assoc;
exports.assoc_opt = assoc_opt;
exports.assq = assq;
exports.assq_opt = assq_opt;
exports.mem_assoc = mem_assoc;
exports.mem_assq = mem_assq;
exports.remove_assoc = remove_assoc;
exports.remove_assq = remove_assq;
exports.split = split;
exports.combine = combine;
exports.sort = sort;
exports.stable_sort = stable_sort;
exports.fast_sort = fast_sort;
exports.sort_uniq = sort_uniq;
exports.merge = merge;
--[ No side effect ]--
