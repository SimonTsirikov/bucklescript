__console = {log = print};

Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function blackify(s) do
  if (s and s[1]) then do
    return --[[ tuple ]]{
            --[[ Node ]]{
              --[[ Black ]]0,
              s[2],
              s[3],
              s[4]
            },
            false
          };
  end else do
    return --[[ tuple ]]{
            s,
            true
          };
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
      y = param[3];
      if (x == y) then do
        return true;
      end else if (x < y) then do
        _param = param[2];
        ::continue:: ;
      end else do
        _param = param[4];
        ::continue:: ;
      end end  end 
    end else do
      return false;
    end end 
  end;
end end

function balance_left(l, x, r) do
  exit = 0;
  a;
  x_1;
  b;
  y;
  c;
  z;
  d;
  if (l and l[1]) then do
    a_1 = l[2];
    exit_1 = 0;
    if (a_1 and a_1[1]) then do
      a = a_1[2];
      x_1 = a_1[3];
      b = a_1[4];
      y = l[3];
      c = l[4];
      z = x;
      d = r;
      exit = 2;
    end else do
      exit_1 = 3;
    end end 
    if (exit_1 == 3) then do
      match = l[4];
      if (match and match[1]) then do
        a = a_1;
        x_1 = l[3];
        b = match[2];
        y = match[3];
        c = match[4];
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
     if ___conditional___ == 1 then do
        return --[[ Node ]]{
                --[[ Black ]]0,
                l,
                x,
                r
              }; end end 
     if ___conditional___ == 2 then do
        return --[[ Node ]]{
                --[[ Red ]]1,
                --[[ Node ]]{
                  --[[ Black ]]0,
                  a,
                  x_1,
                  b
                },
                y,
                --[[ Node ]]{
                  --[[ Black ]]0,
                  c,
                  z,
                  d
                }
              }; end end 
    
  end
end end

function balance_right(l, x, r) do
  exit = 0;
  a;
  x_1;
  b;
  y;
  c;
  z;
  d;
  if (r and r[1]) then do
    b_1 = r[2];
    exit_1 = 0;
    if (b_1 and b_1[1]) then do
      a = l;
      x_1 = x;
      b = b_1[2];
      y = b_1[3];
      c = b_1[4];
      z = r[3];
      d = r[4];
      exit = 2;
    end else do
      exit_1 = 3;
    end end 
    if (exit_1 == 3) then do
      match = r[4];
      if (match and match[1]) then do
        a = l;
        x_1 = x;
        b = b_1;
        y = r[3];
        c = match[2];
        z = match[3];
        d = match[4];
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
     if ___conditional___ == 1 then do
        return --[[ Node ]]{
                --[[ Black ]]0,
                l,
                x,
                r
              }; end end 
     if ___conditional___ == 2 then do
        return --[[ Node ]]{
                --[[ Red ]]1,
                --[[ Node ]]{
                  --[[ Black ]]0,
                  a,
                  x_1,
                  b
                },
                y,
                --[[ Node ]]{
                  --[[ Black ]]0,
                  c,
                  z,
                  d
                }
              }; end end 
    
  end
end end

function singleton(x) do
  return --[[ Node ]]{
          --[[ Black ]]0,
          --[[ Empty ]]0,
          x,
          --[[ Empty ]]0
        };
end end

function unbalanced_left(param) do
  if (param) then do
    if (param[1]) then do
      match = param[2];
      if (match and not match[1]) then do
        return --[[ tuple ]]{
                balance_left(--[[ Node ]]{
                      --[[ Red ]]1,
                      match[2],
                      match[3],
                      match[4]
                    }, param[3], param[4]),
                false
              };
      end
       end 
    end else do
      match_1 = param[2];
      if (match_1) then do
        if (match_1[1]) then do
          match_2 = match_1[4];
          if (match_2 and not match_2[1]) then do
            return --[[ tuple ]]{
                    --[[ Node ]]{
                      --[[ Black ]]0,
                      match_1[2],
                      match_1[3],
                      balance_left(--[[ Node ]]{
                            --[[ Red ]]1,
                            match_2[2],
                            match_2[3],
                            match_2[4]
                          }, param[3], param[4])
                    },
                    false
                  };
          end
           end 
        end else do
          return --[[ tuple ]]{
                  balance_left(--[[ Node ]]{
                        --[[ Red ]]1,
                        match_1[2],
                        match_1[3],
                        match_1[4]
                      }, param[3], param[4]),
                  true
                };
        end end 
      end
       end 
    end end 
  end
   end 
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "rbset.ml",
      57,
      9
    }
  })
end end

function unbalanced_right(param) do
  if (param) then do
    if (param[1]) then do
      match = param[4];
      if (match and not match[1]) then do
        return --[[ tuple ]]{
                balance_right(param[2], param[3], --[[ Node ]]{
                      --[[ Red ]]1,
                      match[2],
                      match[3],
                      match[4]
                    }),
                false
              };
      end
       end 
    end else do
      match_1 = param[4];
      if (match_1) then do
        x = param[3];
        a = param[2];
        if (match_1[1]) then do
          match_2 = match_1[2];
          if (match_2 and not match_2[1]) then do
            return --[[ tuple ]]{
                    --[[ Node ]]{
                      --[[ Black ]]0,
                      balance_right(a, x, --[[ Node ]]{
                            --[[ Red ]]1,
                            match_2[2],
                            match_2[3],
                            match_2[4]
                          }),
                      match_1[3],
                      match_1[4]
                    },
                    false
                  };
          end
           end 
        end else do
          return --[[ tuple ]]{
                  balance_right(a, x, --[[ Node ]]{
                        --[[ Red ]]1,
                        match_1[2],
                        match_1[3],
                        match_1[4]
                      }),
                  true
                };
        end end 
      end
       end 
    end end 
  end
   end 
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "rbset.ml",
      63,
      9
    }
  })
end end

function lbalance(x1, x2, x3) do
  if (x1 and x1[1]) then do
    r = x1[4];
    l = x1[2];
    if (l and l[1]) then do
      return --[[ Node ]]{
              --[[ Red ]]1,
              --[[ Node ]]{
                --[[ Black ]]0,
                l[2],
                l[3],
                l[4]
              },
              x1[3],
              --[[ Node ]]{
                --[[ Black ]]0,
                r,
                x2,
                x3
              }
            };
    end
     end 
    if (r and r[1]) then do
      y = r[3];
      return --[[ Node ]]{
              --[[ Red ]]1,
              --[[ Node ]]{
                --[[ Black ]]0,
                l,
                y,
                r[2]
              },
              y,
              --[[ Node ]]{
                --[[ Black ]]0,
                r[4],
                x2,
                x3
              }
            };
    end else do
      return --[[ Node ]]{
              --[[ Black ]]0,
              x1,
              x2,
              x3
            };
    end end 
  end else do
    return --[[ Node ]]{
            --[[ Black ]]0,
            x1,
            x2,
            x3
          };
  end end 
end end

function rbalance(x1, x2, x3) do
  if (x3 and x3[1]) then do
    b = x3[2];
    exit = 0;
    if (b and b[1]) then do
      return --[[ Node ]]{
              --[[ Red ]]1,
              --[[ Node ]]{
                --[[ Black ]]0,
                x1,
                x2,
                b[2]
              },
              b[3],
              --[[ Node ]]{
                --[[ Black ]]0,
                b[4],
                x3[3],
                x3[4]
              }
            };
    end else do
      exit = 2;
    end end 
    if (exit == 2) then do
      match = x3[4];
      if (match and match[1]) then do
        return --[[ Node ]]{
                --[[ Red ]]1,
                --[[ Node ]]{
                  --[[ Black ]]0,
                  x1,
                  x2,
                  b
                },
                x3[3],
                --[[ Node ]]{
                  --[[ Black ]]0,
                  match[2],
                  match[3],
                  match[4]
                }
              };
      end
       end 
    end
     end 
  end
   end 
  return --[[ Node ]]{
          --[[ Black ]]0,
          x1,
          x2,
          x3
        };
end end

function ins(x, s) do
  if (s) then do
    if (s[1]) then do
      y = s[3];
      if (x == y) then do
        return s;
      end else do
        b = s[4];
        a = s[2];
        if (x < y) then do
          return --[[ Node ]]{
                  --[[ Red ]]1,
                  ins(x, a),
                  y,
                  b
                };
        end else do
          return --[[ Node ]]{
                  --[[ Red ]]1,
                  a,
                  y,
                  ins(x, b)
                };
        end end 
      end end 
    end else do
      y_1 = s[3];
      if (x == y_1) then do
        return s;
      end else do
        b_1 = s[4];
        a_1 = s[2];
        if (x < y_1) then do
          return lbalance(ins(x, a_1), y_1, b_1);
        end else do
          return rbalance(a_1, y_1, ins(x, b_1));
        end end 
      end end 
    end end 
  end else do
    return --[[ Node ]]{
            --[[ Red ]]1,
            --[[ Empty ]]0,
            x,
            --[[ Empty ]]0
          };
  end end 
end end

function add(x, s) do
  s_1 = ins(x, s);
  if (s_1 and s_1[1]) then do
    return --[[ Node ]]{
            --[[ Black ]]0,
            s_1[2],
            s_1[3],
            s_1[4]
          };
  end else do
    return s_1;
  end end 
end end

function remove_min(param) do
  if (param) then do
    c = param[1];
    if (c) then do
      if (not param[2]) then do
        return --[[ tuple ]]{
                param[4],
                param[3],
                false
              };
      end
       end 
    end else if (not param[2]) then do
      match = param[4];
      x = param[3];
      if (match) then do
        if (match[1]) then do
          return --[[ tuple ]]{
                  --[[ Node ]]{
                    --[[ Black ]]0,
                    match[2],
                    match[3],
                    match[4]
                  },
                  x,
                  false
                };
        end else do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "rbset.ml",
              115,
              4
            }
          })
        end end 
      end else do
        return --[[ tuple ]]{
                --[[ Empty ]]0,
                x,
                true
              };
      end end 
    end
     end  end 
    match_1 = remove_min(param[2]);
    y = match_1[2];
    s_001 = match_1[1];
    s_002 = param[3];
    s_003 = param[4];
    s = --[[ Node ]]{
      c,
      s_001,
      s_002,
      s_003
    };
    if (match_1[3]) then do
      match_2 = unbalanced_right(s);
      return --[[ tuple ]]{
              match_2[1],
              y,
              match_2[2]
            };
    end else do
      return --[[ tuple ]]{
              s,
              y,
              false
            };
    end end 
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "rbset.ml",
        115,
        4
      }
    })
  end end 
end end

function remove_aux(x, n) do
  if (n) then do
    r = n[4];
    y = n[3];
    l = n[2];
    c = n[1];
    if (x == y) then do
      if (r) then do
        match = remove_min(r);
        n_002 = match[2];
        n_003 = match[1];
        n_1 = --[[ Node ]]{
          c,
          l,
          n_002,
          n_003
        };
        if (match[3]) then do
          return unbalanced_left(n_1);
        end else do
          return --[[ tuple ]]{
                  n_1,
                  false
                };
        end end 
      end else if (c == --[[ Red ]]1) then do
        return --[[ tuple ]]{
                l,
                false
              };
      end else do
        return blackify(l);
      end end  end 
    end else if (x < y) then do
      match_1 = remove_aux(x, l);
      n_001 = match_1[1];
      n_2 = --[[ Node ]]{
        c,
        n_001,
        y,
        r
      };
      if (match_1[2]) then do
        return unbalanced_right(n_2);
      end else do
        return --[[ tuple ]]{
                n_2,
                false
              };
      end end 
    end else do
      match_2 = remove_aux(x, r);
      n_003_1 = match_2[1];
      n_3 = --[[ Node ]]{
        c,
        l,
        y,
        n_003_1
      };
      if (match_2[2]) then do
        return unbalanced_left(n_3);
      end else do
        return --[[ tuple ]]{
                n_3,
                false
              };
      end end 
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            false
          };
  end end 
end end

function remove(x, s) do
  return remove_aux(x, s)[1];
end end

function cardinal(param) do
  if (param) then do
    return (1 + cardinal(param[2]) | 0) + cardinal(param[4]) | 0;
  end else do
    return 0;
  end end 
end end

empty = --[[ Empty ]]0;

exports = {};
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
return exports;
--[[ No side effect ]]
