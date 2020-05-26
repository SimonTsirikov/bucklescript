'use strict';

Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function blackify(s) do
  if (s and s[0]) then do
    return --[ tuple ]--[
            --[ Node ]--[
              --[ Black ]--0,
              s[1],
              s[2],
              s[3]
            ],
            false
          ];
  end else do
    return --[ tuple ]--[
            s,
            true
          ];
  end end 
end end

function is_empty(param) do
  if (param) then do
    return false;
  end else do
    return true;
  end end 
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      y = param[2];
      if (x == y) then do
        return true;
      end else if (x < y) then do
        _param = param[1];
        continue ;
      end else do
        _param = param[3];
        continue ;
      end end  end 
    end else do
      return false;
    end end 
  end;
end end

function balance_left(l, x, r) do
  exit = 0;
  a;
  x$1;
  b;
  y;
  c;
  z;
  d;
  if (l and l[0]) then do
    a$1 = l[1];
    exit$1 = 0;
    if (a$1 and a$1[0]) then do
      a = a$1[1];
      x$1 = a$1[2];
      b = a$1[3];
      y = l[2];
      c = l[3];
      z = x;
      d = r;
      exit = 2;
    end else do
      exit$1 = 3;
    end end 
    if (exit$1 == 3) then do
      match = l[3];
      if (match and match[0]) then do
        a = a$1;
        x$1 = l[2];
        b = match[1];
        y = match[2];
        c = match[3];
        z = x;
        d = r;
        exit = 2;
      end else do
        exit = 1;
      end end 
    end
     end 
  end else do
    exit = 1;
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ = 1 then do
        return --[ Node ]--[
                --[ Black ]--0,
                l,
                x,
                r
              ];end end end 
     if ___conditional___ = 2 then do
        return --[ Node ]--[
                --[ Red ]--1,
                --[ Node ]--[
                  --[ Black ]--0,
                  a,
                  x$1,
                  b
                ],
                y,
                --[ Node ]--[
                  --[ Black ]--0,
                  c,
                  z,
                  d
                ]
              ];end end end 
     do
    
  end
end end

function balance_right(l, x, r) do
  exit = 0;
  a;
  x$1;
  b;
  y;
  c;
  z;
  d;
  if (r and r[0]) then do
    b$1 = r[1];
    exit$1 = 0;
    if (b$1 and b$1[0]) then do
      a = l;
      x$1 = x;
      b = b$1[1];
      y = b$1[2];
      c = b$1[3];
      z = r[2];
      d = r[3];
      exit = 2;
    end else do
      exit$1 = 3;
    end end 
    if (exit$1 == 3) then do
      match = r[3];
      if (match and match[0]) then do
        a = l;
        x$1 = x;
        b = b$1;
        y = r[2];
        c = match[1];
        z = match[2];
        d = match[3];
        exit = 2;
      end else do
        exit = 1;
      end end 
    end
     end 
  end else do
    exit = 1;
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ = 1 then do
        return --[ Node ]--[
                --[ Black ]--0,
                l,
                x,
                r
              ];end end end 
     if ___conditional___ = 2 then do
        return --[ Node ]--[
                --[ Red ]--1,
                --[ Node ]--[
                  --[ Black ]--0,
                  a,
                  x$1,
                  b
                ],
                y,
                --[ Node ]--[
                  --[ Black ]--0,
                  c,
                  z,
                  d
                ]
              ];end end end 
     do
    
  end
end end

function singleton(x) do
  return --[ Node ]--[
          --[ Black ]--0,
          --[ Empty ]--0,
          x,
          --[ Empty ]--0
        ];
end end

function unbalanced_left(param) do
  if (param) then do
    if (param[0]) then do
      match = param[1];
      if (match and !match[0]) then do
        return --[ tuple ]--[
                balance_left(--[ Node ]--[
                      --[ Red ]--1,
                      match[1],
                      match[2],
                      match[3]
                    ], param[2], param[3]),
                false
              ];
      end
       end 
    end else do
      match$1 = param[1];
      if (match$1) then do
        if (match$1[0]) then do
          match$2 = match$1[3];
          if (match$2 and !match$2[0]) then do
            return --[ tuple ]--[
                    --[ Node ]--[
                      --[ Black ]--0,
                      match$1[1],
                      match$1[2],
                      balance_left(--[ Node ]--[
                            --[ Red ]--1,
                            match$2[1],
                            match$2[2],
                            match$2[3]
                          ], param[2], param[3])
                    ],
                    false
                  ];
          end
           end 
        end else do
          return --[ tuple ]--[
                  balance_left(--[ Node ]--[
                        --[ Red ]--1,
                        match$1[1],
                        match$1[2],
                        match$1[3]
                      ], param[2], param[3]),
                  true
                ];
        end end 
      end
       end 
    end end 
  end
   end 
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "rbset.ml",
          57,
          9
        ]
      ];
end end

function unbalanced_right(param) do
  if (param) then do
    if (param[0]) then do
      match = param[3];
      if (match and !match[0]) then do
        return --[ tuple ]--[
                balance_right(param[1], param[2], --[ Node ]--[
                      --[ Red ]--1,
                      match[1],
                      match[2],
                      match[3]
                    ]),
                false
              ];
      end
       end 
    end else do
      match$1 = param[3];
      if (match$1) then do
        x = param[2];
        a = param[1];
        if (match$1[0]) then do
          match$2 = match$1[1];
          if (match$2 and !match$2[0]) then do
            return --[ tuple ]--[
                    --[ Node ]--[
                      --[ Black ]--0,
                      balance_right(a, x, --[ Node ]--[
                            --[ Red ]--1,
                            match$2[1],
                            match$2[2],
                            match$2[3]
                          ]),
                      match$1[2],
                      match$1[3]
                    ],
                    false
                  ];
          end
           end 
        end else do
          return --[ tuple ]--[
                  balance_right(a, x, --[ Node ]--[
                        --[ Red ]--1,
                        match$1[1],
                        match$1[2],
                        match$1[3]
                      ]),
                  true
                ];
        end end 
      end
       end 
    end end 
  end
   end 
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "rbset.ml",
          63,
          9
        ]
      ];
end end

function lbalance(x1, x2, x3) do
  if (x1 and x1[0]) then do
    r = x1[3];
    l = x1[1];
    if (l and l[0]) then do
      return --[ Node ]--[
              --[ Red ]--1,
              --[ Node ]--[
                --[ Black ]--0,
                l[1],
                l[2],
                l[3]
              ],
              x1[2],
              --[ Node ]--[
                --[ Black ]--0,
                r,
                x2,
                x3
              ]
            ];
    end
     end 
    if (r and r[0]) then do
      y = r[2];
      return --[ Node ]--[
              --[ Red ]--1,
              --[ Node ]--[
                --[ Black ]--0,
                l,
                y,
                r[1]
              ],
              y,
              --[ Node ]--[
                --[ Black ]--0,
                r[3],
                x2,
                x3
              ]
            ];
    end else do
      return --[ Node ]--[
              --[ Black ]--0,
              x1,
              x2,
              x3
            ];
    end end 
  end else do
    return --[ Node ]--[
            --[ Black ]--0,
            x1,
            x2,
            x3
          ];
  end end 
end end

function rbalance(x1, x2, x3) do
  if (x3 and x3[0]) then do
    b = x3[1];
    exit = 0;
    if (b and b[0]) then do
      return --[ Node ]--[
              --[ Red ]--1,
              --[ Node ]--[
                --[ Black ]--0,
                x1,
                x2,
                b[1]
              ],
              b[2],
              --[ Node ]--[
                --[ Black ]--0,
                b[3],
                x3[2],
                x3[3]
              ]
            ];
    end else do
      exit = 2;
    end end 
    if (exit == 2) then do
      match = x3[3];
      if (match and match[0]) then do
        return --[ Node ]--[
                --[ Red ]--1,
                --[ Node ]--[
                  --[ Black ]--0,
                  x1,
                  x2,
                  b
                ],
                x3[2],
                --[ Node ]--[
                  --[ Black ]--0,
                  match[1],
                  match[2],
                  match[3]
                ]
              ];
      end
       end 
    end
     end 
  end
   end 
  return --[ Node ]--[
          --[ Black ]--0,
          x1,
          x2,
          x3
        ];
end end

function ins(x, s) do
  if (s) then do
    if (s[0]) then do
      y = s[2];
      if (x == y) then do
        return s;
      end else do
        b = s[3];
        a = s[1];
        if (x < y) then do
          return --[ Node ]--[
                  --[ Red ]--1,
                  ins(x, a),
                  y,
                  b
                ];
        end else do
          return --[ Node ]--[
                  --[ Red ]--1,
                  a,
                  y,
                  ins(x, b)
                ];
        end end 
      end end 
    end else do
      y$1 = s[2];
      if (x == y$1) then do
        return s;
      end else do
        b$1 = s[3];
        a$1 = s[1];
        if (x < y$1) then do
          return lbalance(ins(x, a$1), y$1, b$1);
        end else do
          return rbalance(a$1, y$1, ins(x, b$1));
        end end 
      end end 
    end end 
  end else do
    return --[ Node ]--[
            --[ Red ]--1,
            --[ Empty ]--0,
            x,
            --[ Empty ]--0
          ];
  end end 
end end

function add(x, s) do
  s$1 = ins(x, s);
  if (s$1 and s$1[0]) then do
    return --[ Node ]--[
            --[ Black ]--0,
            s$1[1],
            s$1[2],
            s$1[3]
          ];
  end else do
    return s$1;
  end end 
end end

function remove_min(param) do
  if (param) then do
    c = param[0];
    if (c) then do
      if (!param[1]) then do
        return --[ tuple ]--[
                param[3],
                param[2],
                false
              ];
      end
       end 
    end else if (!param[1]) then do
      match = param[3];
      x = param[2];
      if (match) then do
        if (match[0]) then do
          return --[ tuple ]--[
                  --[ Node ]--[
                    --[ Black ]--0,
                    match[1],
                    match[2],
                    match[3]
                  ],
                  x,
                  false
                ];
        end else do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "rbset.ml",
                  115,
                  4
                ]
              ];
        end end 
      end else do
        return --[ tuple ]--[
                --[ Empty ]--0,
                x,
                true
              ];
      end end 
    end
     end  end 
    match$1 = remove_min(param[1]);
    y = match$1[1];
    s_001 = match$1[0];
    s_002 = param[2];
    s_003 = param[3];
    s = --[ Node ]--[
      c,
      s_001,
      s_002,
      s_003
    ];
    if (match$1[2]) then do
      match$2 = unbalanced_right(s);
      return --[ tuple ]--[
              match$2[0],
              y,
              match$2[1]
            ];
    end else do
      return --[ tuple ]--[
              s,
              y,
              false
            ];
    end end 
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "rbset.ml",
            115,
            4
          ]
        ];
  end end 
end end

function remove_aux(x, n) do
  if (n) then do
    r = n[3];
    y = n[2];
    l = n[1];
    c = n[0];
    if (x == y) then do
      if (r) then do
        match = remove_min(r);
        n_002 = match[1];
        n_003 = match[0];
        n$1 = --[ Node ]--[
          c,
          l,
          n_002,
          n_003
        ];
        if (match[2]) then do
          return unbalanced_left(n$1);
        end else do
          return --[ tuple ]--[
                  n$1,
                  false
                ];
        end end 
      end else if (c == --[ Red ]--1) then do
        return --[ tuple ]--[
                l,
                false
              ];
      end else do
        return blackify(l);
      end end  end 
    end else if (x < y) then do
      match$1 = remove_aux(x, l);
      n_001 = match$1[0];
      n$2 = --[ Node ]--[
        c,
        n_001,
        y,
        r
      ];
      if (match$1[1]) then do
        return unbalanced_right(n$2);
      end else do
        return --[ tuple ]--[
                n$2,
                false
              ];
      end end 
    end else do
      match$2 = remove_aux(x, r);
      n_003$1 = match$2[0];
      n$3 = --[ Node ]--[
        c,
        l,
        y,
        n_003$1
      ];
      if (match$2[1]) then do
        return unbalanced_left(n$3);
      end else do
        return --[ tuple ]--[
                n$3,
                false
              ];
      end end 
    end end  end 
  end else do
    return --[ tuple ]--[
            --[ Empty ]--0,
            false
          ];
  end end 
end end

function remove(x, s) do
  return remove_aux(x, s)[0];
end end

function cardinal(param) do
  if (param) then do
    return (1 + cardinal(param[1]) | 0) + cardinal(param[3]) | 0;
  end else do
    return 0;
  end end 
end end

empty = --[ Empty ]--0;

exports.blackify = blackify;
exports.empty = empty;
exports.is_empty = is_empty;
exports.mem = mem;
exports.balance_left = balance_left;
exports.balance_right = balance_right;
exports.singleton = singleton;
exports.unbalanced_left = unbalanced_left;
exports.unbalanced_right = unbalanced_right;
exports.lbalance = lbalance;
exports.rbalance = rbalance;
exports.ins = ins;
exports.add = add;
exports.remove_min = remove_min;
exports.remove_aux = remove_aux;
exports.remove = remove;
exports.cardinal = cardinal;
--[ No side effect ]--
