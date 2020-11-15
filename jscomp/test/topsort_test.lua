__console = {log = print};

List = require "......lib.js.list";
Curry = require "......lib.js.curry";
__String = require "......lib.js.string";
Caml_obj = require "......lib.js.caml_obj";
Pervasives = require "......lib.js.pervasives";
Caml_option = require "......lib.js.caml_option";
Caml_primitive = require "......lib.js.caml_primitive";
Caml_exceptions = require "......lib.js.caml_exceptions";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

graph = --[[ :: ]]{
  --[[ tuple ]]{
    "a",
    "b"
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "a",
      "c"
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "a",
        "d"
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "b",
          "e"
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "c",
            "f"
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "d",
              "e"
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "e",
                "f"
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "e",
                  "g"
                },
                --[[ [] ]]0
              }
            }
          }
        }
      }
    }
  }
};

function nexts(x, g) do
  return List.fold_left((function(acc, param) do
                if (param[1] == x) then do
                  return --[[ :: ]]{
                          param[2],
                          acc
                        };
                end else do
                  return acc;
                end end 
              end end), --[[ [] ]]0, g);
end end

function dfs1(_nodes, graph, _visited) do
  while(true) do
    visited = _visited;
    nodes = _nodes;
    if (nodes) then do
      xs = nodes[2];
      x = nodes[1];
      if (List.mem(x, visited)) then do
        _nodes = xs;
        ::continue:: ;
      end else do
        __console.log(x);
        _visited = --[[ :: ]]{
          x,
          visited
        };
        _nodes = Pervasives._at(nexts(x, graph), xs);
        ::continue:: ;
      end end 
    end else do
      return List.rev(visited);
    end end 
  end;
end end

if (not Caml_obj.caml_equal(dfs1(--[[ :: ]]{
            "a",
            --[[ [] ]]0
          }, graph, --[[ [] ]]0), --[[ :: ]]{
        "a",
        --[[ :: ]]{
          "d",
          --[[ :: ]]{
            "e",
            --[[ :: ]]{
              "g",
              --[[ :: ]]{
                "f",
                --[[ :: ]]{
                  "c",
                  --[[ :: ]]{
                    "b",
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      29,
      2
    }
  })
end
 end 

Pervasives.print_newline(--[[ () ]]0);

if (not Caml_obj.caml_equal(dfs1(--[[ :: ]]{
            "b",
            --[[ [] ]]0
          }, --[[ :: ]]{
            --[[ tuple ]]{
              "f",
              "d"
            },
            graph
          }, --[[ [] ]]0), --[[ :: ]]{
        "b",
        --[[ :: ]]{
          "e",
          --[[ :: ]]{
            "g",
            --[[ :: ]]{
              "f",
              --[[ :: ]]{
                "d",
                --[[ [] ]]0
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      32,
      2
    }
  })
end
 end 

function dfs2(nodes, graph, visited) do
  aux = function(_nodes, graph, _visited) do
    while(true) do
      visited = _visited;
      nodes = _nodes;
      if (nodes) then do
        xs = nodes[2];
        x = nodes[1];
        if (List.mem(x, visited)) then do
          _nodes = xs;
          ::continue:: ;
        end else do
          _visited = aux(nexts(x, graph), graph, --[[ :: ]]{
                x,
                visited
              });
          _nodes = xs;
          ::continue:: ;
        end end 
      end else do
        return visited;
      end end 
    end;
  end end;
  return List.rev(aux(nodes, graph, visited));
end end

if (not Caml_obj.caml_equal(dfs2(--[[ :: ]]{
            "a",
            --[[ [] ]]0
          }, graph, --[[ [] ]]0), --[[ :: ]]{
        "a",
        --[[ :: ]]{
          "d",
          --[[ :: ]]{
            "e",
            --[[ :: ]]{
              "g",
              --[[ :: ]]{
                "f",
                --[[ :: ]]{
                  "c",
                  --[[ :: ]]{
                    "b",
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      47,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(dfs2(--[[ :: ]]{
            "b",
            --[[ [] ]]0
          }, --[[ :: ]]{
            --[[ tuple ]]{
              "f",
              "d"
            },
            graph
          }, --[[ [] ]]0), --[[ :: ]]{
        "b",
        --[[ :: ]]{
          "e",
          --[[ :: ]]{
            "g",
            --[[ :: ]]{
              "f",
              --[[ :: ]]{
                "d",
                --[[ [] ]]0
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      48,
      2
    }
  })
end
 end 

function dfs3(nodes, graph) do
  visited = {
    contents = --[[ [] ]]0
  };
  aux = function(node, graph) do
    if (List.mem(node, visited.contents)) then do
      return 0;
    end else do
      visited.contents = --[[ :: ]]{
        node,
        visited.contents
      };
      return List.iter((function(x) do
                    return aux(x, graph);
                  end end), nexts(node, graph));
    end end 
  end end;
  List.iter((function(node) do
          return aux(node, graph);
        end end), nodes);
  return List.rev(visited.contents);
end end

if (not Caml_obj.caml_equal(dfs3(--[[ :: ]]{
            "a",
            --[[ [] ]]0
          }, graph), --[[ :: ]]{
        "a",
        --[[ :: ]]{
          "d",
          --[[ :: ]]{
            "e",
            --[[ :: ]]{
              "g",
              --[[ :: ]]{
                "f",
                --[[ :: ]]{
                  "c",
                  --[[ :: ]]{
                    "b",
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      65,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(dfs3(--[[ :: ]]{
            "b",
            --[[ [] ]]0
          }, --[[ :: ]]{
            --[[ tuple ]]{
              "f",
              "d"
            },
            graph
          }), --[[ :: ]]{
        "b",
        --[[ :: ]]{
          "e",
          --[[ :: ]]{
            "g",
            --[[ :: ]]{
              "f",
              --[[ :: ]]{
                "d",
                --[[ [] ]]0
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      66,
      2
    }
  })
end
 end 

grwork = --[[ :: ]]{
  --[[ tuple ]]{
    "wake",
    "shower"
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "shower",
      "dress"
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "dress",
        "go"
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "wake",
          "eat"
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "eat",
            "washup"
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "washup",
              "go"
            },
            --[[ [] ]]0
          }
        }
      }
    }
  }
};

function unsafe_topsort(graph) do
  visited = {
    contents = --[[ [] ]]0
  };
  sort_node = function(node) do
    if (List.mem(node, visited.contents)) then do
      return 0;
    end else do
      nodes = nexts(node, graph);
      List.iter(sort_node, nodes);
      visited.contents = --[[ :: ]]{
        node,
        visited.contents
      };
      return --[[ () ]]0;
    end end 
  end end;
  List.iter((function(param) do
          return sort_node(param[1]);
        end end), graph);
  return visited.contents;
end end

if (not Caml_obj.caml_equal(unsafe_topsort(grwork), --[[ :: ]]{
        "wake",
        --[[ :: ]]{
          "shower",
          --[[ :: ]]{
            "dress",
            --[[ :: ]]{
              "eat",
              --[[ :: ]]{
                "washup",
                --[[ :: ]]{
                  "go",
                  --[[ [] ]]0
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      110,
      2
    }
  })
end
 end 

function height(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]v,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) then do
        return create(create(ll, lv, lr[--[[ l ]]1]), lr[--[[ v ]]2], create(lr[--[[ r ]]3], v, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) then do
        return create(create(l, v, rl[--[[ l ]]1]), rl[--[[ v ]]2], create(rl[--[[ r ]]3], rv, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]v,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      ll = add(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal(ll, v, r);
      end end 
    end else do
      rr = add(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function singleton(x) do
  return --[[ Node ]]{
          --[[ l : Empty ]]0,
          --[[ v ]]x,
          --[[ r : Empty ]]0,
          --[[ h ]]1
        };
end end

function add_min_element(x, param) do
  if (param) then do
    return bal(add_min_element(x, param[--[[ l ]]1]), param[--[[ v ]]2], param[--[[ r ]]3]);
  end else do
    return singleton(x);
  end end 
end end

function add_max_element(x, param) do
  if (param) then do
    return bal(param[--[[ l ]]1], param[--[[ v ]]2], add_max_element(x, param[--[[ r ]]3]));
  end else do
    return singleton(x);
  end end 
end end

function join(l, v, r) do
  if (l) then do
    if (r) then do
      rh = r[--[[ h ]]4];
      lh = l[--[[ h ]]4];
      if (lh > (rh + 2 | 0)) then do
        return bal(l[--[[ l ]]1], l[--[[ v ]]2], join(l[--[[ r ]]3], v, r));
      end else if (rh > (lh + 2 | 0)) then do
        return bal(join(l, v, r[--[[ l ]]1]), r[--[[ v ]]2], r[--[[ r ]]3]);
      end else do
        return create(l, v, r);
      end end  end 
    end else do
      return add_max_element(v, l);
    end end 
  end else do
    return add_min_element(v, r);
  end end 
end end

function min_elt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]1];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return param[--[[ v ]]2];
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function min_elt_opt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      l = param[--[[ l ]]1];
      if (l) then do
        _param = l;
        ::continue:: ;
      end else do
        return Caml_option.some(param[--[[ v ]]2]);
      end end 
    end else do
      return ;
    end end 
  end;
end end

function max_elt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return param[--[[ v ]]2];
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function max_elt_opt(_param) do
  while(true) do
    param = _param;
    if (param) then do
      r = param[--[[ r ]]3];
      if (r) then do
        _param = r;
        ::continue:: ;
      end else do
        return Caml_option.some(param[--[[ v ]]2]);
      end end 
    end else do
      return ;
    end end 
  end;
end end

function remove_min_elt(param) do
  if (param) then do
    l = param[--[[ l ]]1];
    if (l) then do
      return bal(remove_min_elt(l), param[--[[ v ]]2], param[--[[ r ]]3]);
    end else do
      return param[--[[ r ]]3];
    end end 
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Set.remove_min_elt"
    })
  end end 
end end

function concat(t1, t2) do
  if (t1) then do
    if (t2) then do
      return join(t1, min_elt(t2), remove_min_elt(t2));
    end else do
      return t1;
    end end 
  end else do
    return t2;
  end end 
end end

function split(x, param) do
  if (param) then do
    r = param[--[[ r ]]3];
    v = param[--[[ v ]]2];
    l = param[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return --[[ tuple ]]{
              l,
              true,
              r
            };
    end else if (c < 0) then do
      match = split(x, l);
      return --[[ tuple ]]{
              match[1],
              match[2],
              join(match[3], v, r)
            };
    end else do
      match_1 = split(x, r);
      return --[[ tuple ]]{
              join(l, v, match_1[1]),
              match_1[2],
              match_1[3]
            };
    end end  end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            false,
            --[[ Empty ]]0
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
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function remove(x, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      t1 = l;
      t2 = r;
      if (t1) then do
        if (t2) then do
          return bal(t1, min_elt(t2), remove_min_elt(t2));
        end else do
          return t1;
        end end 
      end else do
        return t2;
      end end 
    end else if (c < 0) then do
      ll = remove(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal(ll, v, r);
      end end 
    end else do
      rr = remove(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function union(s1, s2) do
  if (s1) then do
    if (s2) then do
      h2 = s2[--[[ h ]]4];
      v2 = s2[--[[ v ]]2];
      h1 = s1[--[[ h ]]4];
      v1 = s1[--[[ v ]]2];
      if (h1 >= h2) then do
        if (h2 == 1) then do
          return add(v2, s1);
        end else do
          match = split(v1, s2);
          return join(union(s1[--[[ l ]]1], match[1]), v1, union(s1[--[[ r ]]3], match[3]));
        end end 
      end else if (h1 == 1) then do
        return add(v1, s2);
      end else do
        match_1 = split(v2, s1);
        return join(union(match_1[1], s2[--[[ l ]]1]), v2, union(match_1[3], s2[--[[ r ]]3]));
      end end  end 
    end else do
      return s1;
    end end 
  end else do
    return s2;
  end end 
end end

function inter(s1, s2) do
  if (s1 and s2) then do
    r1 = s1[--[[ r ]]3];
    v1 = s1[--[[ v ]]2];
    l1 = s1[--[[ l ]]1];
    match = split(v1, s2);
    l2 = match[1];
    if (match[2]) then do
      return join(inter(l1, l2), v1, inter(r1, match[3]));
    end else do
      return concat(inter(l1, l2), inter(r1, match[3]));
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function diff(s1, s2) do
  if (s1) then do
    if (s2) then do
      r1 = s1[--[[ r ]]3];
      v1 = s1[--[[ v ]]2];
      l1 = s1[--[[ l ]]1];
      match = split(v1, s2);
      l2 = match[1];
      if (match[2]) then do
        return concat(diff(l1, l2), diff(r1, match[3]));
      end else do
        return join(diff(l1, l2), v1, diff(r1, match[3]));
      end end 
    end else do
      return s1;
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function cons_enum(_s, _e) do
  while(true) do
    e = _e;
    s = _s;
    if (s) then do
      _e = --[[ More ]]{
        s[--[[ v ]]2],
        s[--[[ r ]]3],
        e
      };
      _s = s[--[[ l ]]1];
      ::continue:: ;
    end else do
      return e;
    end end 
  end;
end end

function compare(s1, s2) do
  _e1 = cons_enum(s1, --[[ End ]]0);
  _e2 = cons_enum(s2, --[[ End ]]0);
  while(true) do
    e2 = _e2;
    e1 = _e1;
    if (e1) then do
      if (e2) then do
        c = Caml_primitive.caml_string_compare(e1[1], e2[1]);
        if (c ~= 0) then do
          return c;
        end else do
          _e2 = cons_enum(e2[2], e2[3]);
          _e1 = cons_enum(e1[2], e1[3]);
          ::continue:: ;
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
end end

function equal(s1, s2) do
  return compare(s1, s2) == 0;
end end

function subset(_s1, _s2) do
  while(true) do
    s2 = _s2;
    s1 = _s1;
    if (s1) then do
      if (s2) then do
        r2 = s2[--[[ r ]]3];
        l2 = s2[--[[ l ]]1];
        r1 = s1[--[[ r ]]3];
        v1 = s1[--[[ v ]]2];
        l1 = s1[--[[ l ]]1];
        c = Caml_primitive.caml_string_compare(v1, s2[--[[ v ]]2]);
        if (c == 0) then do
          if (subset(l1, l2)) then do
            _s2 = r2;
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (c < 0) then do
          if (subset(--[[ Node ]]{
                  --[[ l ]]l1,
                  --[[ v ]]v1,
                  --[[ r : Empty ]]0,
                  --[[ h ]]0
                }, l2)) then do
            _s1 = r1;
            ::continue:: ;
          end else do
            return false;
          end end 
        end else if (subset(--[[ Node ]]{
                --[[ l : Empty ]]0,
                --[[ v ]]v1,
                --[[ r ]]r1,
                --[[ h ]]0
              }, r2)) then do
          _s1 = l1;
          ::continue:: ;
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
end end

function iter(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      iter(f, param[--[[ l ]]1]);
      Curry._1(f, param[--[[ v ]]2]);
      _param = param[--[[ r ]]3];
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function fold(f, _s, _accu) do
  while(true) do
    accu = _accu;
    s = _s;
    if (s) then do
      _accu = Curry._2(f, s[--[[ v ]]2], fold(f, s[--[[ l ]]1], accu));
      _s = s[--[[ r ]]3];
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function for_all(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[--[[ v ]]2]) and for_all(p, param[--[[ l ]]1])) then do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else do
      return true;
    end end 
  end;
end end

function exists(p, _param) do
  while(true) do
    param = _param;
    if (param) then do
      if (Curry._1(p, param[--[[ v ]]2]) or exists(p, param[--[[ l ]]1])) then do
        return true;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function filter(p, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    l_prime = filter(p, l);
    pv = Curry._1(p, v);
    r_prime = filter(p, r);
    if (pv) then do
      if (l == l_prime and r == r_prime) then do
        return t;
      end else do
        return join(l_prime, v, r_prime);
      end end 
    end else do
      return concat(l_prime, r_prime);
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function partition(p, param) do
  if (param) then do
    v = param[--[[ v ]]2];
    match = partition(p, param[--[[ l ]]1]);
    lf = match[2];
    lt = match[1];
    pv = Curry._1(p, v);
    match_1 = partition(p, param[--[[ r ]]3]);
    rf = match_1[2];
    rt = match_1[1];
    if (pv) then do
      return --[[ tuple ]]{
              join(lt, v, rt),
              concat(lf, rf)
            };
    end else do
      return --[[ tuple ]]{
              concat(lt, rt),
              join(lf, v, rf)
            };
    end end 
  end else do
    return --[[ tuple ]]{
            --[[ Empty ]]0,
            --[[ Empty ]]0
          };
  end end 
end end

function cardinal(param) do
  if (param) then do
    return (cardinal(param[--[[ l ]]1]) + 1 | 0) + cardinal(param[--[[ r ]]3]) | 0;
  end else do
    return 0;
  end end 
end end

function elements_aux(_accu, _param) do
  while(true) do
    param = _param;
    accu = _accu;
    if (param) then do
      _param = param[--[[ l ]]1];
      _accu = --[[ :: ]]{
        param[--[[ v ]]2],
        elements_aux(accu, param[--[[ r ]]3])
      };
      ::continue:: ;
    end else do
      return accu;
    end end 
  end;
end end

function elements(s) do
  return elements_aux(--[[ [] ]]0, s);
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      c = Caml_primitive.caml_string_compare(x, v);
      if (c == 0) then do
        return v;
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      if (Curry._1(f, v)) then do
        _v0 = v;
        f_1 = f;
        _param_1 = param[--[[ l ]]1];
        while(true) do
          param_1 = _param_1;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]2];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]1];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
              ::continue:: ;
            end end 
          end else do
            return v0;
          end end 
        end;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_first_opt(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      if (Curry._1(f, v)) then do
        _v0 = v;
        f_1 = f;
        _param_1 = param[--[[ l ]]1];
        while(true) do
          param_1 = _param_1;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]2];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ l ]]1];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ r ]]3];
              ::continue:: ;
            end end 
          end else do
            return Caml_option.some(v0);
          end end 
        end;
      end else do
        _param = param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_last(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      if (Curry._1(f, v)) then do
        _v0 = v;
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]2];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]1];
              ::continue:: ;
            end end 
          end else do
            return v0;
          end end 
        end;
      end else do
        _param = param[--[[ l ]]1];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function find_last_opt(f, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      if (Curry._1(f, v)) then do
        _v0 = v;
        f_1 = f;
        _param_1 = param[--[[ r ]]3];
        while(true) do
          param_1 = _param_1;
          v0 = _v0;
          if (param_1) then do
            v_1 = param_1[--[[ v ]]2];
            if (Curry._1(f_1, v_1)) then do
              _param_1 = param_1[--[[ r ]]3];
              _v0 = v_1;
              ::continue:: ;
            end else do
              _param_1 = param_1[--[[ l ]]1];
              ::continue:: ;
            end end 
          end else do
            return Caml_option.some(v0);
          end end 
        end;
      end else do
        _param = param[--[[ l ]]1];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function find_opt(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      v = param[--[[ v ]]2];
      c = Caml_primitive.caml_string_compare(x, v);
      if (c == 0) then do
        return Caml_option.some(v);
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return ;
    end end 
  end;
end end

function map(f, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    l_prime = map(f, l);
    v_prime = Curry._1(f, v);
    r_prime = map(f, r);
    if (l == l_prime and v == v_prime and r == r_prime) then do
      return t;
    end else do
      l_1 = l_prime;
      v_1 = v_prime;
      r_1 = r_prime;
      if ((l_1 == --[[ Empty ]]0 or Caml_primitive.caml_string_compare(max_elt(l_1), v_1) < 0) and (r_1 == --[[ Empty ]]0 or Caml_primitive.caml_string_compare(v_1, min_elt(r_1)) < 0)) then do
        return join(l_1, v_1, r_1);
      end else do
        return union(l_1, add(v_1, r_1));
      end end 
    end end 
  end else do
    return --[[ Empty ]]0;
  end end 
end end

function of_list(l) do
  if (l) then do
    match = l[2];
    x0 = l[1];
    if (match) then do
      match_1 = match[2];
      x1 = match[1];
      if (match_1) then do
        match_2 = match_1[2];
        x2 = match_1[1];
        if (match_2) then do
          match_3 = match_2[2];
          x3 = match_2[1];
          if (match_3) then do
            if (match_3[2]) then do
              l_1 = List.sort_uniq(__String.compare, l);
              sub = function(n, l) do
                local ___conditional___=(n);
                do
                   if ___conditional___ == 0 then do
                      return --[[ tuple ]]{
                              --[[ Empty ]]0,
                              l
                            }; end end 
                   if ___conditional___ == 1 then do
                      if (l) then do
                        return --[[ tuple ]]{
                                --[[ Node ]]{
                                  --[[ l : Empty ]]0,
                                  --[[ v ]]l[1],
                                  --[[ r : Empty ]]0,
                                  --[[ h ]]1
                                },
                                l[2]
                              };
                      end
                       end  end else 
                   if ___conditional___ == 2 then do
                      if (l) then do
                        match = l[2];
                        if (match) then do
                          return --[[ tuple ]]{
                                  --[[ Node ]]{
                                    --[[ l : Node ]]{
                                      --[[ l : Empty ]]0,
                                      --[[ v ]]l[1],
                                      --[[ r : Empty ]]0,
                                      --[[ h ]]1
                                    },
                                    --[[ v ]]match[1],
                                    --[[ r : Empty ]]0,
                                    --[[ h ]]2
                                  },
                                  match[2]
                                };
                        end
                         end 
                      end
                       end  end else 
                   if ___conditional___ == 3 then do
                      if (l) then do
                        match_1 = l[2];
                        if (match_1) then do
                          match_2 = match_1[2];
                          if (match_2) then do
                            return --[[ tuple ]]{
                                    --[[ Node ]]{
                                      --[[ l : Node ]]{
                                        --[[ l : Empty ]]0,
                                        --[[ v ]]l[1],
                                        --[[ r : Empty ]]0,
                                        --[[ h ]]1
                                      },
                                      --[[ v ]]match_1[1],
                                      --[[ r : Node ]]{
                                        --[[ l : Empty ]]0,
                                        --[[ v ]]match_2[1],
                                        --[[ r : Empty ]]0,
                                        --[[ h ]]1
                                      },
                                      --[[ h ]]2
                                    },
                                    match_2[2]
                                  };
                          end
                           end 
                        end
                         end 
                      end
                       end  end else 
                   end end end end end end
                  
                end
                nl = n / 2 | 0;
                match_3 = sub(nl, l);
                l_1 = match_3[2];
                if (l_1) then do
                  match_4 = sub((n - nl | 0) - 1 | 0, l_1[2]);
                  return --[[ tuple ]]{
                          create(match_3[1], l_1[1], match_4[1]),
                          match_4[2]
                        };
                end else do
                  error({
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]]{
                      "set.ml",
                      510,
                      18
                    }
                  })
                end end 
              end end;
              return sub(List.length(l_1), l_1)[1];
            end else do
              return add(match_3[1], add(x3, add(x2, add(x1, singleton(x0)))));
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
    return --[[ Empty ]]0;
  end end 
end end

String_set = {
  empty = --[[ Empty ]]0,
  is_empty = is_empty,
  mem = mem,
  add = add,
  singleton = singleton,
  remove = remove,
  union = union,
  inter = inter,
  diff = diff,
  compare = compare,
  equal = equal,
  subset = subset,
  iter = iter,
  map = map,
  fold = fold,
  for_all = for_all,
  exists = exists,
  filter = filter,
  partition = partition,
  cardinal = cardinal,
  elements = elements,
  min_elt = min_elt,
  min_elt_opt = min_elt_opt,
  max_elt = max_elt,
  max_elt_opt = max_elt_opt,
  choose = min_elt,
  choose_opt = min_elt_opt,
  split = split,
  find = find,
  find_opt = find_opt,
  find_first = find_first,
  find_first_opt = find_first_opt,
  find_last = find_last,
  find_last_opt = find_last_opt,
  of_list = of_list
};

Cycle = Caml_exceptions.create("Topsort_test.Cycle");

function pathsort(graph) do
  visited = {
    contents = --[[ [] ]]0
  };
  empty_path = --[[ tuple ]]{
    --[[ Empty ]]0,
    --[[ [] ]]0
  };
  _plus_great = function(node, param) do
    stack = param[2];
    set = param[1];
    if (mem(node, set)) then do
      error({
        Cycle,
        --[[ :: ]]{
          node,
          stack
        }
      })
    end
     end 
    return --[[ tuple ]]{
            add(node, set),
            --[[ :: ]]{
              node,
              stack
            }
          };
  end end;
  sort_nodes = function(path, nodes) do
    return List.iter((function(node) do
                  return sort_node(path, node);
                end end), nodes);
  end end;
  sort_node = function(path, node) do
    if (List.mem(node, visited.contents)) then do
      return 0;
    end else do
      sort_nodes(_plus_great(node, path), nexts(node, graph));
      visited.contents = --[[ :: ]]{
        node,
        visited.contents
      };
      return --[[ () ]]0;
    end end 
  end end;
  List.iter((function(param) do
          return sort_node(empty_path, param[1]);
        end end), graph);
  return visited.contents;
end end

if (not Caml_obj.caml_equal(pathsort(grwork), --[[ :: ]]{
        "wake",
        --[[ :: ]]{
          "shower",
          --[[ :: ]]{
            "dress",
            --[[ :: ]]{
              "eat",
              --[[ :: ]]{
                "washup",
                --[[ :: ]]{
                  "go",
                  --[[ [] ]]0
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      150,
      4
    }
  })
end
 end 

xpcall(function() do
  pathsort(--[[ :: ]]{
        --[[ tuple ]]{
          "go",
          "eat"
        },
        grwork
      });
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "topsort_test.ml",
      156,
      8
    }
  })
end end,function(raw_exn) do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  exit = 0;
  if (exn[1] == Cycle) then do
    match = exn[2];
    if (match and match[1] == "go") then do
      match_1 = match[2];
      if (match_1 and match_1[1] == "washup") then do
        match_2 = match_1[2];
        if (match_2 and match_2[1] == "eat") then do
          match_3 = match_2[2];
          if (not (match_3 and match_3[1] == "go" and not match_3[2])) then do
            exit = 1;
          end
           end 
        end else do
          exit = 1;
        end end 
      end else do
        exit = 1;
      end end 
    end else do
      exit = 1;
    end end 
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "topsort_test.ml",
        159,
        11
      }
    })
  end
   end 
end end)

exports = {};
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
return exports;
--[[  Not a pure module ]]
