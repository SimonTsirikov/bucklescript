'use strict';

List = require("../../lib/js/list.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Pervasives = require("../../lib/js/pervasives.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function length_aux(_len, _param) do
  while(true) do
    param = _param;
    len = _len;
    if (param) then do
      _param = param[1];
      _len = len + 1 | 0;
      continue ;
    end else do
      return len;
    end end 
  end;
end

function length(l) do
  return length_aux(0, l);
end

function hd(param) do
  if (param) then do
    return param[0];
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "hd"
        ];
  end end 
end

function tl(param) do
  if (param) then do
    return param[1];
  end else do
    throw [
          Caml_builtin_exceptions.failure,
          "tl"
        ];
  end end 
end

function nth(l, n) do
  if (n < 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.nth"
        ];
  end
   end 
  _l = l;
  _n = n;
  while(true) do
    n$1 = _n;
    l$1 = _l;
    if (l$1) then do
      if (n$1 == 0) then do
        return l$1[0];
      end else do
        _n = n$1 - 1 | 0;
        _l = l$1[1];
        continue ;
      end end 
    end else do
      throw [
            Caml_builtin_exceptions.failure,
            "nth"
          ];
    end end 
  end;
end

function rev_append(_l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      _l2 = --[ :: ]--[
        l1[0],
        l2
      ];
      _l1 = l1[1];
      continue ;
    end else do
      return l2;
    end end 
  end;
end

function rev(l) do
  return rev_append(l, --[ [] ]--0);
end

function flatten(param) do
  if (param) then do
    return Pervasives.$at(param[0], flatten(param[1]));
  end else do
    return --[ [] ]--0;
  end end 
end

function map(f, param) do
  if (param) then do
    r = Curry._1(f, param[0]);
    return --[ :: ]--[
            r,
            map(f, param[1])
          ];
  end else do
    return --[ [] ]--0;
  end end 
end

function mapi(i, f, param) do
  if (param) then do
    r = Curry._2(f, i, param[0]);
    return --[ :: ]--[
            r,
            mapi(i + 1 | 0, f, param[1])
          ];
  end else do
    return --[ [] ]--0;
  end end 
end

function mapi$1(f, l) do
  return mapi(0, f, l);
end

function rev_map(f, l) do
  _accu = --[ [] ]--0;
  _param = l;
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[1];
      _accu = --[ :: ]--[
        Curry._1(f, param[0]),
        accu
      ];
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      Curry._1(f, param[0]);
      _param = param[1];
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function iteri(f, l) do
  _i = 0;
  f$1 = f;
  _param = l;
  while(true) do
    param = _param;
    i = _i;
    if (param) then do
      Curry._2(f$1, i, param[0]);
      _param = param[1];
      _i = i + 1 | 0;
      continue ;
    end else do
      return --[ () ]--0;
    end end 
  end;
end

function fold_left(f, _accu, _l) do
  while(true) do
    l = _l;
    accu = _accu;
    if (l) then do
      _l = l[1];
      _accu = Curry._2(f, accu, l[0]);
      continue ;
    end else do
      return accu;
    end end 
  end;
end

function fold_right(f, l, accu) do
  if (l) then do
    return Curry._2(f, l[0], fold_right(f, l[1], accu));
  end else do
    return accu;
  end end 
end

function map2(f, l1, l2) do
  if (l1) then do
    if (l2) then do
      r = Curry._2(f, l1[0], l2[0]);
      return --[ :: ]--[
              r,
              map2(f, l1[1], l2[1])
            ];
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.map2"
          ];
    end end 
  end else if (l2) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.map2"
        ];
  end else do
    return --[ [] ]--0;
  end end  end 
end

function rev_map2(f, l1, l2) do
  _accu = --[ [] ]--0;
  _l1 = l1;
  _l2 = l2;
  while(true) do
    l2$1 = _l2;
    l1$1 = _l1;
    accu = _accu;
    if (l1$1) then do
      if (l2$1) then do
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
      end end 
    end else do
      if (l2$1) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.rev_map2"
            ];
      end
       end 
      return accu;
    end end 
  end;
end

function iter2(f, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        Curry._2(f, l1[0], l2[0]);
        _l2 = l2[1];
        _l1 = l1[1];
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.iter2"
            ];
      end end 
    end else if (l2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.iter2"
          ];
    end else do
      return --[ () ]--0;
    end end  end 
  end;
end

function fold_left2(f, _accu, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    accu = _accu;
    if (l1) then do
      if (l2) then do
        _l2 = l2[1];
        _l1 = l1[1];
        _accu = Curry._3(f, accu, l1[0], l2[0]);
        continue ;
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.fold_left2"
            ];
      end end 
    end else do
      if (l2) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.fold_left2"
            ];
      end
       end 
      return accu;
    end end 
  end;
end

function fold_right2(f, l1, l2, accu) do
  if (l1) then do
    if (l2) then do
      return Curry._3(f, l1[0], l2[0], fold_right2(f, l1[1], l2[1], accu));
    end else do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end end 
  end else do
    if (l2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.fold_right2"
          ];
    end
     end 
    return accu;
  end end 
end

function for_all(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[0])) then do
        _param = param[1];
        continue ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end

function exists(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[0])) then do
        return true;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function for_all2(p, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        if (Curry._2(p, l1[0], l2[0])) then do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
        end else do
          return false;
        end end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.for_all2"
            ];
      end end 
    end else if (l2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.for_all2"
          ];
    end else do
      return true;
    end end  end 
  end;
end

function exists2(p, _l1, _l2) do
  while(true) do
    l2 = _l2;
    l1 = _l1;
    if (l1) then do
      if (l2) then do
        if (Curry._2(p, l1[0], l2[0])) then do
          return true;
        end else do
          _l2 = l2[1];
          _l1 = l1[1];
          continue ;
        end end 
      end else do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "List.exists2"
            ];
      end end 
    end else if (l2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "List.exists2"
          ];
    end else do
      return false;
    end end  end 
  end;
end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Caml_obj.caml_equal(param[0], x)) then do
        return true;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function memq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (param[0] == x) then do
        return true;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function assoc(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[0];
      if (Caml_obj.caml_equal(match[0], x)) then do
        return match[1];
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function assq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      match = param[0];
      if (match[0] == x) then do
        return match[1];
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function mem_assoc(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Caml_obj.caml_equal(param[0][0], x)) then do
        return true;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function mem_assq(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (param[0][0] == x) then do
        return true;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      return false;
    end end 
  end;
end

function remove_assoc(x, param) do
  if (param) then do
    l = param[1];
    pair = param[0];
    if (Caml_obj.caml_equal(pair[0], x)) then do
      return l;
    end else do
      return --[ :: ]--[
              pair,
              remove_assoc(x, l)
            ];
    end end 
  end else do
    return --[ [] ]--0;
  end end 
end

function remove_assq(x, param) do
  if (param) then do
    l = param[1];
    pair = param[0];
    if (pair[0] == x) then do
      return l;
    end else do
      return --[ :: ]--[
              pair,
              remove_assq(x, l)
            ];
    end end 
  end else do
    return --[ [] ]--0;
  end end 
end

function find(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      x = param[0];
      if (Curry._1(p, x)) then do
        return x;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function find_all(p) do
  return (function (param) do
      _accu = --[ [] ]--0;
      _param = param;
      while(true) do
        param$1 = _param;
        accu = _accu;
        if (param$1) then do
          l = param$1[1];
          x = param$1[0];
          if (Curry._1(p, x)) then do
            _param = l;
            _accu = --[ :: ]--[
              x,
              accu
            ];
            continue ;
          end else do
            _param = l;
            continue ;
          end end 
        end else do
          return rev_append(accu, --[ [] ]--0);
        end end 
      end;
    end);
end

function partition(p, l) do
  _yes = --[ [] ]--0;
  _no = --[ [] ]--0;
  _param = l;
  while(true) do
    param = _param;
    no = _no;
    yes = _yes;
    if (param) then do
      l$1 = param[1];
      x = param[0];
      if (Curry._1(p, x)) then do
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
      end end 
    end else do
      return --[ tuple ]--[
              rev_append(yes, --[ [] ]--0),
              rev_append(no, --[ [] ]--0)
            ];
    end end 
  end;
end

function split(param) do
  if (param) then do
    match = param[0];
    match$1 = split(param[1]);
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
  end end 
end

function combine(l1, l2) do
  if (l1) then do
    if (l2) then do
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
    end end 
  end else if (l2) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "List.combine"
        ];
  end else do
    return --[ [] ]--0;
  end end  end 
end

function merge(cmp, l1, l2) do
  if (l1) then do
    if (l2) then do
      h2 = l2[0];
      h1 = l1[0];
      if (Curry._2(cmp, h1, h2) <= 0) then do
        return --[ :: ]--[
                h1,
                merge(cmp, l1[1], l2)
              ];
      end else do
        return --[ :: ]--[
                h2,
                merge(cmp, l1, l2[1])
              ];
      end end 
    end else do
      return l1;
    end end 
  end else do
    return l2;
  end end 
end

function chop(_k, _l) do
  while(true) do
    l = _l;
    k = _k;
    if (k == 0) then do
      return l;
    end else if (l) then do
      _l = l[1];
      _k = k - 1 | 0;
      continue ;
    end else do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "test_list.ml",
              224,
              11
            ]
          ];
    end end  end 
  end;
end

function stable_sort(cmp, l) do
  sort = function (n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[1];
        if (match) then do
          match$1 = match[1];
          if (match$1) then do
            x3 = match$1[0];
            x2 = match[0];
            x1 = l[0];
            if (Curry._2(cmp, x1, x2) <= 0) then do
              if (Curry._2(cmp, x2, x3) <= 0) then do
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
              end else if (Curry._2(cmp, x1, x3) <= 0) then do
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
              end end  end 
            end else if (Curry._2(cmp, x1, x3) <= 0) then do
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
            end else if (Curry._2(cmp, x2, x3) <= 0) then do
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
            end end  end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match$2 = l[1];
      if (match$2) then do
        x2$1 = match$2[0];
        x1$1 = l[0];
        if (Curry._2(cmp, x1$1, x2$1) <= 0) then do
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
        end end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = rev_sort(n1, l);
    s2 = rev_sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[ [] ]--0;
    while(true) do
      accu = _accu;
      l2$1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2$1) then do
          h2 = l2$1[0];
          h1 = l1[0];
          if (Curry._2(cmp, h1, h2) > 0) then do
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
          end end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2$1, accu);
      end end 
    end;
  end;
  rev_sort = function (n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[1];
        if (match) then do
          match$1 = match[1];
          if (match$1) then do
            x3 = match$1[0];
            x2 = match[0];
            x1 = l[0];
            if (Curry._2(cmp, x1, x2) > 0) then do
              if (Curry._2(cmp, x2, x3) > 0) then do
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
              end else if (Curry._2(cmp, x1, x3) > 0) then do
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
              end end  end 
            end else if (Curry._2(cmp, x1, x3) > 0) then do
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
            end else if (Curry._2(cmp, x2, x3) > 0) then do
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
            end end  end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match$2 = l[1];
      if (match$2) then do
        x2$1 = match$2[0];
        x1$1 = l[0];
        if (Curry._2(cmp, x1$1, x2$1) > 0) then do
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
        end end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = sort(n1, l);
    s2 = sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[ [] ]--0;
    while(true) do
      accu = _accu;
      l2$1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2$1) then do
          h2 = l2$1[0];
          h1 = l1[0];
          if (Curry._2(cmp, h1, h2) <= 0) then do
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
          end end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2$1, accu);
      end end 
    end;
  end;
  len = length_aux(0, l);
  if (len < 2) then do
    return l;
  end else do
    return sort(len, l);
  end end 
end

function sort_uniq(cmp, l) do
  sort = function (n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[1];
        if (match) then do
          match$1 = match[1];
          if (match$1) then do
            x3 = match$1[0];
            x2 = match[0];
            x1 = l[0];
            c = Curry._2(cmp, x1, x2);
            if (c == 0) then do
              c$1 = Curry._2(cmp, x2, x3);
              if (c$1 == 0) then do
                return --[ :: ]--[
                        x2,
                        --[ [] ]--0
                      ];
              end else if (c$1 < 0) then do
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
              end end  end 
            end else if (c < 0) then do
              c$2 = Curry._2(cmp, x2, x3);
              if (c$2 == 0) then do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$2 < 0) then do
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
                c$3 = Curry._2(cmp, x1, x3);
                if (c$3 == 0) then do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$3 < 0) then do
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
                end end  end 
              end end  end 
            end else do
              c$4 = Curry._2(cmp, x1, x3);
              if (c$4 == 0) then do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$4 < 0) then do
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
                c$5 = Curry._2(cmp, x2, x3);
                if (c$5 == 0) then do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x1,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$5 < 0) then do
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
                end end  end 
              end end  end 
            end end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match$2 = l[1];
      if (match$2) then do
        x2$1 = match$2[0];
        x1$1 = l[0];
        c$6 = Curry._2(cmp, x1$1, x2$1);
        if (c$6 == 0) then do
          return --[ :: ]--[
                  x1$1,
                  --[ [] ]--0
                ];
        end else if (c$6 < 0) then do
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
        end end  end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = rev_sort(n1, l);
    s2 = rev_sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[ [] ]--0;
    while(true) do
      accu = _accu;
      l2$1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2$1) then do
          t2 = l2$1[1];
          h2 = l2$1[0];
          t1 = l1[1];
          h1 = l1[0];
          c$7 = Curry._2(cmp, h1, h2);
          if (c$7 == 0) then do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l2 = t2;
            _l1 = t1;
            continue ;
          end else if (c$7 > 0) then do
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
          end end  end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2$1, accu);
      end end 
    end;
  end;
  rev_sort = function (n, l) do
    if (n ~= 2) then do
      if (n == 3 and l) then do
        match = l[1];
        if (match) then do
          match$1 = match[1];
          if (match$1) then do
            x3 = match$1[0];
            x2 = match[0];
            x1 = l[0];
            c = Curry._2(cmp, x1, x2);
            if (c == 0) then do
              c$1 = Curry._2(cmp, x2, x3);
              if (c$1 == 0) then do
                return --[ :: ]--[
                        x2,
                        --[ [] ]--0
                      ];
              end else if (c$1 > 0) then do
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
              end end  end 
            end else if (c > 0) then do
              c$2 = Curry._2(cmp, x2, x3);
              if (c$2 == 0) then do
                return --[ :: ]--[
                        x1,
                        --[ :: ]--[
                          x2,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$2 > 0) then do
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
                c$3 = Curry._2(cmp, x1, x3);
                if (c$3 == 0) then do
                  return --[ :: ]--[
                          x1,
                          --[ :: ]--[
                            x2,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$3 > 0) then do
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
                end end  end 
              end end  end 
            end else do
              c$4 = Curry._2(cmp, x1, x3);
              if (c$4 == 0) then do
                return --[ :: ]--[
                        x2,
                        --[ :: ]--[
                          x1,
                          --[ [] ]--0
                        ]
                      ];
              end else if (c$4 > 0) then do
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
                c$5 = Curry._2(cmp, x2, x3);
                if (c$5 == 0) then do
                  return --[ :: ]--[
                          x2,
                          --[ :: ]--[
                            x1,
                            --[ [] ]--0
                          ]
                        ];
                end else if (c$5 > 0) then do
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
                end end  end 
              end end  end 
            end end  end 
          end
           end 
        end
         end 
      end
       end 
    end else if (l) then do
      match$2 = l[1];
      if (match$2) then do
        x2$1 = match$2[0];
        x1$1 = l[0];
        c$6 = Curry._2(cmp, x1$1, x2$1);
        if (c$6 == 0) then do
          return --[ :: ]--[
                  x1$1,
                  --[ [] ]--0
                ];
        end else if (c$6 > 0) then do
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
        end end  end 
      end
       end 
    end
     end  end 
    n1 = (n >> 1);
    n2 = n - n1 | 0;
    l2 = chop(n1, l);
    s1 = sort(n1, l);
    s2 = sort(n2, l2);
    _l1 = s1;
    _l2 = s2;
    _accu = --[ [] ]--0;
    while(true) do
      accu = _accu;
      l2$1 = _l2;
      l1 = _l1;
      if (l1) then do
        if (l2$1) then do
          t2 = l2$1[1];
          h2 = l2$1[0];
          t1 = l1[1];
          h1 = l1[0];
          c$7 = Curry._2(cmp, h1, h2);
          if (c$7 == 0) then do
            _accu = --[ :: ]--[
              h1,
              accu
            ];
            _l2 = t2;
            _l1 = t1;
            continue ;
          end else if (c$7 < 0) then do
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
          end end  end 
        end else do
          return rev_append(l1, accu);
        end end 
      end else do
        return rev_append(l2$1, accu);
      end end 
    end;
  end;
  len = length_aux(0, l);
  if (len < 2) then do
    return l;
  end else do
    return sort(len, l);
  end end 
end

u = List.length;

append = Pervasives.$at;

concat = flatten;

filter = find_all;

sort = stable_sort;

fast_sort = stable_sort;

exports.u = u;
exports.length_aux = length_aux;
exports.length = length;
exports.hd = hd;
exports.tl = tl;
exports.nth = nth;
exports.append = append;
exports.rev_append = rev_append;
exports.rev = rev;
exports.flatten = flatten;
exports.concat = concat;
exports.map = map;
exports.mapi = mapi$1;
exports.rev_map = rev_map;
exports.iter = iter;
exports.iteri = iteri;
exports.fold_left = fold_left;
exports.fold_right = fold_right;
exports.map2 = map2;
exports.rev_map2 = rev_map2;
exports.iter2 = iter2;
exports.fold_left2 = fold_left2;
exports.fold_right2 = fold_right2;
exports.for_all = for_all;
exports.exists = exists;
exports.for_all2 = for_all2;
exports.exists2 = exists2;
exports.mem = mem;
exports.memq = memq;
exports.assoc = assoc;
exports.assq = assq;
exports.mem_assoc = mem_assoc;
exports.mem_assq = mem_assq;
exports.remove_assoc = remove_assoc;
exports.remove_assq = remove_assq;
exports.find = find;
exports.find_all = find_all;
exports.filter = filter;
exports.partition = partition;
exports.split = split;
exports.combine = combine;
exports.merge = merge;
exports.chop = chop;
exports.stable_sort = stable_sort;
exports.sort = sort;
exports.fast_sort = fast_sort;
exports.sort_uniq = sort_uniq;
--[ No side effect ]--
