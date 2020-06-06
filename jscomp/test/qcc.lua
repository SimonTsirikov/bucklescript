console = {log = print};

Sys = require "../../lib/js/sys";
Char = require "../../lib/js/char";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Bytes = require "../../lib/js/bytes";
Curry = require "../../lib/js/curry";
Printf = require "../../lib/js/printf";
__String = require "../../lib/js/string";
Caml_io = require "../../lib/js/caml_io";
Caml_obj = require "../../lib/js/caml_obj";
Caml_array = require "../../lib/js/caml_array";
Caml_bytes = require "../../lib/js/caml_bytes";
Caml_int32 = require "../../lib/js/caml_int32";
Pervasives = require "../../lib/js/pervasives";
Caml_option = require "../../lib/js/caml_option";
Caml_string = require "../../lib/js/caml_string";
Caml_external_polyfill = require "../../lib/js/caml_external_polyfill";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

dbg = {
  contents = true
};

inch = {
  contents = Pervasives.stdin
};

function bufferize(f) do
  buf = {
    contents = undefined
  };
  return --[[ tuple ]]{
          (function(param) do
              match = buf.contents;
              if (match ~= undefined) then do
                buf.contents = undefined;
                return Caml_option.valFromOption(match);
              end else do
                return Curry._1(f, --[[ () ]]0);
              end end 
            end end),
          (function(x) do
              if (buf.contents ~= undefined) then do
                error({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "qcc.ml",
                    17,
                    4
                  }
                })
              end
               end 
              buf.contents = Caml_option.some(x);
              return --[[ () ]]0;
            end end)
        };
end end

match = bufferize((function(param) do
        return Caml_external_polyfill.resolve("caml_ml_input_char")(inch.contents);
      end end));

ungetch = match[1];

getch = match[0];

function peekch(param) do
  ch = Curry._1(getch, --[[ () ]]0);
  Curry._1(ungetch, ch);
  return ch;
end end

symtab = Caml_array.caml_make_vect(100, "");

syms = {
  contents = 0
};

function find(s, _n) do
  while(true) do
    n = _n;
    if (n >= syms.contents) then do
      syms.contents = syms.contents + 1 | 0;
      return n;
    end else if (Caml_array.caml_array_get(symtab, n) == s) then do
      return n;
    end else do
      _n = n + 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function addsym(s) do
  sid = find(s, 0);
  Caml_array.caml_array_set(symtab, sid, s);
  return sid;
end end

function symstr(n) do
  if (n >= syms.contents) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "qcc.ml",
        40,
        4
      }
    })
  end
   end 
  return Caml_array.caml_array_get(symtab, n);
end end

function symitr(f) do
  for i = 0 , syms.contents - 1 | 0 , 1 do
    Curry._2(f, i, Caml_array.caml_array_get(symtab, i));
  end
  return --[[ () ]]0;
end end

glo = Bytes.make(4096, --[[ "\000" ]]0);

gpos = {
  contents = 0
};

s = Caml_bytes.caml_create_bytes(100);

function getq(param) do
  c = Curry._1(getch, --[[ () ]]0);
  if (c ~= 92 or peekch(--[[ () ]]0) ~= --[[ "n" ]]110) then do
    return c;
  end else do
    Curry._1(getch, --[[ () ]]0);
    return --[[ "\n" ]]10;
  end end 
end end

function isid(param) do
  switcher = param - 91 | 0;
  if (switcher > 5 or switcher < 0) then do
    return (switcher + 26 >>> 0) <= 57;
  end else do
    return switcher == 4;
  end end 
end end

function skip(_param) do
  while(true) do
    ch = Curry._1(getch, --[[ () ]]0);
    if (ch >= 14) then do
      if (ch ~= 32) then do
        if (ch ~= 47 or peekch(--[[ () ]]0) ~= --[[ "*" ]]42) then do
          return ch;
        end else do
          _param_1 = (Curry._1(getch, --[[ () ]]0), --[[ () ]]0);
          while(true) do
            match = Curry._1(getch, --[[ () ]]0);
            if (match ~= 42) then do
              _param_1 = --[[ () ]]0;
              ::continue:: ;
            end else if (peekch(--[[ () ]]0) == --[[ "/" ]]47) then do
              return skip((Curry._1(getch, --[[ () ]]0), --[[ () ]]0));
            end else do
              _param_1 = --[[ () ]]0;
              ::continue:: ;
            end end  end 
          end;
        end end 
      end else do
        _param = --[[ () ]]0;
        ::continue:: ;
      end end 
    end else if (ch >= 11) then do
      if (ch >= 13) then do
        _param = --[[ () ]]0;
        ::continue:: ;
      end else do
        return ch;
      end end 
    end else if (ch >= 9) then do
      _param = --[[ () ]]0;
      ::continue:: ;
    end else do
      return ch;
    end end  end  end 
  end;
end end

function next(param) do
  match;
  xpcall(function() do
    match = skip(--[[ () ]]0);
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.end_of_file) then do
      match = undefined;
    end else do
      error(exn)
    end end 
  end end)
  if (match ~= undefined) then do
    c = match;
    if (c ~= 34) then do
      if (c >= 48) then do
        if (c < 58) then do
          _n = c - 48 | 0;
          while(true) do
            n = _n;
            match_1 = peekch(--[[ () ]]0);
            if (match_1 > 57 or match_1 < 48) then do
              return --[[ ILit ]]Block.__(1, {n});
            end else do
              _n = (Caml_int32.imul(10, n) + Curry._1(getch, --[[ () ]]0) | 0) - 48 | 0;
              ::continue:: ;
            end end 
          end;
        end
         end 
      end else if (c == 39) then do
        ch = getq(--[[ () ]]0);
        qt = Curry._1(getch, --[[ () ]]0);
        if (qt ~= --[[ "'" ]]39) then do
          error({
            Caml_builtin_exceptions.failure,
            "syntax error"
          })
        end
         end 
        return --[[ ILit ]]Block.__(1, {ch});
      end
       end  end 
    end else do
      b = gpos.contents;
      _e = gpos.contents;
      while(true) do
        e = _e;
        match_2 = peekch(--[[ () ]]0);
        if (match_2 ~= 34) then do
          glo[e] = getq(--[[ () ]]0);
          _e = e + 1 | 0;
          ::continue:: ;
        end else do
          Curry._1(getch, --[[ () ]]0);
          gpos.contents = e + 8 & -8;
          return --[[ SLit ]]Block.__(2, {
                    (b + 232 | 0) + 4194304 | 0,
                    Bytes.to_string(Bytes.sub(glo, b, e - b | 0))
                  });
        end end 
      end;
    end end 
    if (isid(c)) then do
      _n_1 = 0;
      _ch = c;
      while(true) do
        ch_1 = _ch;
        n_1 = _n_1;
        s[n_1] = ch_1;
        if (isid(peekch(--[[ () ]]0))) then do
          _ch = Curry._1(getch, --[[ () ]]0);
          _n_1 = n_1 + 1 | 0;
          ::continue:: ;
        end else do
          return --[[ Sym ]]Block.__(3, {addsym(Bytes.to_string(Bytes.sub(s, 0, n_1 + 1 | 0)))});
        end end 
      end;
    end else do
      ch_2 = c;
      _param = --[[ :: ]]{
        "++",
        --[[ :: ]]{
          "--",
          --[[ :: ]]{
            "&&",
            --[[ :: ]]{
              "||",
              --[[ :: ]]{
                "==",
                --[[ :: ]]{
                  "<=",
                  --[[ :: ]]{
                    ">=",
                    --[[ :: ]]{
                      "!=",
                      --[[ :: ]]{
                        ">>",
                        --[[ :: ]]{
                          "<<",
                          --[[ [] ]]0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      };
      while(true) do
        param_1 = _param;
        if (param_1) then do
          lop = param_1[0];
          if (Caml_string.get(lop, 0) == ch_2 and Caml_string.get(lop, 1) == peekch(--[[ () ]]0)) then do
            Curry._1(getch, --[[ () ]]0);
            return --[[ Op ]]Block.__(0, {lop});
          end else do
            _param = param_1[1];
            ::continue:: ;
          end end 
        end else do
          return --[[ Op ]]Block.__(0, {Caml_bytes.bytes_to_string(Bytes.make(1, ch_2))});
        end end 
      end;
    end end 
  end else do
    return --[[ Op ]]Block.__(0, {"EOF!"});
  end end 
end end

match_1 = bufferize(next);

unnext = match_1[1];

next_1 = match_1[0];

function nextis(t) do
  nt = Curry._1(next_1, --[[ () ]]0);
  Curry._1(unnext, nt);
  return Caml_obj.caml_equal(t, nt);
end end

obuf = Bytes.make(1048576, --[[ "\000" ]]0);

opos = {
  contents = 0
};

function out(x) do
  if (x ~= 0) then do
    out(x / 256 | 0);
    obuf[opos.contents] = Char.chr(x & 255);
    opos.contents = opos.contents + 1 | 0;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function le(n, x) do
  for i = 0 , (n / 8 | 0) - 1 | 0 , 1 do
    __byte = (x >>> (i << 3)) & 255;
    obuf[opos.contents] = Char.chr(__byte);
    opos.contents = opos.contents + 1 | 0;
  end
  return --[[ () ]]0;
end end

function get32(l) do
  return ((Caml_bytes.get(obuf, l) + (Caml_bytes.get(obuf, l + 1 | 0) << 8) | 0) + (Caml_bytes.get(obuf, l + 2 | 0) << 16) | 0) + (Caml_bytes.get(obuf, l + 3 | 0) << 24) | 0;
end end

function patch(rel, loc, n) do
  if (n >= 0) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "qcc.ml",
        157,
        2
      }
    })
  end
   end 
  if (loc ~= 0) then do
    i = opos.contents;
    loc$prime = get32(loc);
    x = rel and n - (loc + 4 | 0) | 0 or n;
    if (dbg.contents) then do
      Curry._3(Printf.eprintf(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "patching at ",
                    --[[ Int ]]Block.__(4, {
                        --[[ Int_d ]]0,
                        --[[ No_padding ]]0,
                        --[[ No_precision ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " to ",
                            --[[ Int ]]Block.__(4, {
                                --[[ Int_d ]]0,
                                --[[ No_padding ]]0,
                                --[[ No_precision ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    " (n=",
                                    --[[ Int ]]Block.__(4, {
                                        --[[ Int_d ]]0,
                                        --[[ No_padding ]]0,
                                        --[[ No_precision ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            ")\n",
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "patching at %d to %d (n=%d)\n"
              }), loc, x, n);
    end
     end 
    opos.contents = loc;
    le(32, x);
    patch(rel, loc$prime, n);
    opos.contents = i;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function load(r, n) do
  out(184 + r | 0);
  return le(32, n);
end end

function cmp(n) do
  load(0, 0);
  return out(1020608 + (n << 8) | 0);
end end

function test(n, l) do
  out(4752832);
  out(3972 + n | 0);
  loc = opos.contents;
  le(32, l);
  return loc;
end end

align = {
  contents = 0
};

function push(r) do
  align.contents = align.contents + 1 | 0;
  if (r < 8) then do
    return out(80 + r | 0);
  end else do
    return out((16720 + r | 0) - 8 | 0);
  end end 
end end

function pop(r) do
  align.contents = align.contents - 1 | 0;
  if (r < 8) then do
    return out(88 + r | 0);
  end else do
    return out((16728 + r | 0) - 8 | 0);
  end end 
end end

lval = {
  contents = --[[ tuple ]]{
    --[[ Mov ]]Block.__(0, {0}),
    --[[ Int ]]0
  }
};

function patchlval(param) do
  match = lval.contents[0];
  if (match.tag) then do
    opos.contents = opos.contents - match[0] | 0;
    return --[[ () ]]0;
  end else do
    obuf[opos.contents - match[0] | 0] = --[[ "\141" ]]141;
    return --[[ () ]]0;
  end end 
end end

function read(param) do
  if (param) then do
    out(4722614);
    le(8, 0);
    lval.contents = --[[ tuple ]]{
      --[[ Del ]]Block.__(1, {4}),
      --[[ Chr ]]1
    };
    return --[[ () ]]0;
  end else do
    out(18571);
    le(8, 0);
    lval.contents = --[[ tuple ]]{
      --[[ Del ]]Block.__(1, {3}),
      --[[ Int ]]0
    };
    return --[[ () ]]0;
  end end 
end end

globs = Caml_array.caml_make_vect(100, {
      loc = 0,
      va = -1
    });

lvls = --[[ :: ]]{
  --[[ tuple ]]{
    "*",
    0
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "/",
      0
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "%",
        0
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "+",
          1
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "-",
            1
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "<<",
              2
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                ">>",
                2
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "<",
                  3
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "<=",
                    3
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      ">",
                      3
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        ">=",
                        3
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "==",
                          4
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "!=",
                            4
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "&",
                              5
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "^",
                                6
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "|",
                                  7
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    "&&",
                                    8
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "||",
                                      9
                                    },
                                    --[[ [] ]]0
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};

inss = --[[ :: ]]{
  --[[ tuple ]]{
    "*",
    --[[ Bin ]]Block.__(0, {--[[ :: ]]{
          1208987585,
          --[[ [] ]]0
        }})
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "/",
      --[[ Bin ]]Block.__(0, {--[[ :: ]]{
            18577,
            --[[ :: ]]{
              18585,
              --[[ :: ]]{
                4782073,
                --[[ [] ]]0
              }
            }
          }})
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "%",
        --[[ Bin ]]Block.__(0, {--[[ :: ]]{
              18577,
              --[[ :: ]]{
                18585,
                --[[ :: ]]{
                  4782073,
                  --[[ :: ]]{
                    18578,
                    --[[ [] ]]0
                  }
                }
              }
            }})
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "+",
          --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                4719048,
                --[[ [] ]]0
              }})
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "-",
            --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                  18577,
                  --[[ :: ]]{
                    4729288,
                    --[[ [] ]]0
                  }
                }})
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "<<",
              --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                    18577,
                    --[[ :: ]]{
                      4772832,
                      --[[ [] ]]0
                    }
                  }})
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                ">>",
                --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                      18577,
                      --[[ :: ]]{
                        4772856,
                        --[[ [] ]]0
                      }
                    }})
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "<",
                  --[[ Cmp ]]Block.__(1, {10})
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "<=",
                    --[[ Cmp ]]Block.__(1, {12})
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      ">",
                      --[[ Cmp ]]Block.__(1, {13})
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        ">=",
                        --[[ Cmp ]]Block.__(1, {11})
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "==",
                          --[[ Cmp ]]Block.__(1, {2})
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "!=",
                            --[[ Cmp ]]Block.__(1, {3})
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "&",
                              --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                                    4727240,
                                    --[[ [] ]]0
                                  }})
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "^",
                                --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                                      4731336,
                                      --[[ [] ]]0
                                    }})
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "|",
                                  --[[ Bin ]]Block.__(0, {--[[ :: ]]{
                                        4721096,
                                        --[[ [] ]]0
                                      }})
                                },
                                --[[ [] ]]0
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};

tokint = --[[ Sym ]]Block.__(3, {addsym("int")});

tokchar = --[[ Sym ]]Block.__(3, {addsym("char")});

tokret = --[[ Sym ]]Block.__(3, {addsym("return")});

tokif = --[[ Sym ]]Block.__(3, {addsym("if")});

tokelse = --[[ Sym ]]Block.__(3, {addsym("else")});

tokwhile = --[[ Sym ]]Block.__(3, {addsym("while")});

tokfor = --[[ Sym ]]Block.__(3, {addsym("for")});

tokbreak = --[[ Sym ]]Block.__(3, {addsym("break")});

function binary(stk, lvl) do
  if (lvl == -1) then do
    return unary(stk);
  end else do
    lvlof = function(o) do
      if (List.mem_assoc(o, lvls)) then do
        return List.assoc(o, lvls);
      end else do
        return -1;
      end end 
    end end;
    foldtst = function(_loc) do
      while(true) do
        loc = _loc;
        t = Curry._1(next_1, --[[ () ]]0);
        if (t.tag or lvlof(t[0]) ~= lvl) then do
          Curry._1(unnext, t);
          return loc;
        end else do
          loc$prime = test(lvl - 8 | 0, loc);
          binary(stk, lvl - 1 | 0);
          _loc = loc$prime;
          ::continue:: ;
        end end 
      end;
    end end;
    binary(stk, lvl - 1 | 0);
    if (lvl < 8) then do
      _param = --[[ () ]]0;
      while(true) do
        t = Curry._1(next_1, --[[ () ]]0);
        if (t.tag) then do
          return Curry._1(unnext, t);
        end else do
          o = t[0];
          if (lvlof(o) == lvl) then do
            push(0);
            binary(stk, lvl - 1 | 0);
            pop(1);
            match = List.assoc(o, inss);
            if (match.tag) then do
              out(4733377);
              cmp(match[0]);
            end else do
              List.iter(out, match[0]);
            end end 
            _param = --[[ () ]]0;
            ::continue:: ;
          end else do
            return Curry._1(unnext, t);
          end end 
        end end 
      end;
    end else do
      loc = foldtst(0);
      return patch(true, loc, opos.contents);
    end end 
  end end 
end end

function unary(stk) do
  match = Curry._1(next_1, --[[ () ]]0);
  local ___conditional___=(match.tag | 0);
  do
     if ___conditional___ == 0--[[ Op ]] then do
        o = match[0];
        local ___conditional___=(o);
        do
           if ___conditional___ == "&" then do
              unary(stk);
              return patchlval(--[[ () ]]0); end end 
           if ___conditional___ == "(" then do
              expr(stk);
              Curry._1(next_1, --[[ () ]]0);
              return postfix(stk); end end 
           if ___conditional___ == "*" then do
              Curry._1(next_1, --[[ () ]]0);
              t = Curry._1(next_1, --[[ () ]]0);
              match_1;
              if (Caml_obj.caml_equal(t, tokint)) then do
                match_1 = Caml_obj.caml_equal(Curry._1(next_1, --[[ () ]]0), --[[ Op ]]Block.__(0, {"*"})) and --[[ tuple ]]{
                    --[[ Int ]]0,
                    1
                  } or --[[ tuple ]]{
                    --[[ Int ]]0,
                    5
                  };
              end else if (Caml_obj.caml_equal(t, tokchar)) then do
                match_1 = --[[ tuple ]]{
                  --[[ Chr ]]1,
                  2
                };
              end else do
                error({
                  Caml_builtin_exceptions.failure,
                  "[cast] expected"
                })
              end end  end 
              for k = 1 , match_1[1] , 1 do
                Curry._1(next_1, --[[ () ]]0);
              end
              unary(stk);
              return read(match_1[0]); end end 
          unops = --[[ :: ]]{
              --[[ tuple ]]{
                "+",
                0
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "-",
                  4782040
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "~",
                    4782032
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "!",
                      4752832
                    },
                    --[[ [] ]]0
                  }
                }
              }
            };
            unary(stk);
            if (not List.mem_assoc(o, unops)) then do
              s = Curry._1(Printf.sprintf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "unknown operator ",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ End_of_format ]]0
                              })
                          }),
                        "unknown operator %s"
                      }), o);
              error({
                Caml_builtin_exceptions.failure,
                s
              })
            end
             end 
            out(List.assoc(o, unops));
            if (o == "!") then do
              return cmp(2);
            end else do
              return 0;
            end end 
            
        end end end 
     if ___conditional___ == 1--[[ ILit ]] then do
        return load(0, match[0]); end end 
     if ___conditional___ == 2--[[ SLit ]] then do
        out(18616);
        return le(64, match[0]); end end 
     if ___conditional___ == 3--[[ Sym ]] then do
        i = match[0];
        if (List.mem_assoc(i, stk)) then do
          l = List.assoc(i, stk);
          if (l <= -256) then do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "qcc.ml",
                295,
                6
              }
            })
          end
           end 
          out(4754245);
          out(l & 255);
          lval.contents = --[[ tuple ]]{
            --[[ Mov ]]Block.__(0, {3}),
            --[[ Int ]]0
          };
        end else do
          out(18616);
          g = Caml_array.caml_array_get(globs, i);
          loc = opos.contents;
          le(64, g.loc);
          Caml_array.caml_array_set(globs, i, {
                loc = loc,
                va = g.va
              });
          read(--[[ Int ]]0);
        end end 
        return postfix(stk); end end 
    
  end
end end

function postfix(stk) do
  t = Curry._1(next_1, --[[ () ]]0);
  if (t.tag) then do
    return Curry._1(unnext, t);
  end else do
    op = t[0];
    local ___conditional___=(op);
    do
       if ___conditional___ == "(" then do
          emitargs = function(_l, _rl) do
            while(true) do
              rl = _rl;
              l = _l;
              if (nextis(--[[ Op ]]Block.__(0, {")"}))) then do
                Curry._1(next_1, --[[ () ]]0);
                return List.iter(pop, l);
              end else do
                expr(stk);
                push(0);
                if (nextis(--[[ Op ]]Block.__(0, {","}))) then do
                  Curry._1(next_1, --[[ () ]]0);
                end
                 end 
                _rl = List.tl(rl);
                _l = --[[ :: ]]{
                  List.hd(rl),
                  l
                };
                ::continue:: ;
              end end 
            end;
          end end;
          patchlval(--[[ () ]]0);
          push(0);
          emitargs(--[[ [] ]]0, --[[ :: ]]{
                7,
                --[[ :: ]]{
                  6,
                  --[[ :: ]]{
                    2,
                    --[[ :: ]]{
                      1,
                      --[[ :: ]]{
                        8,
                        --[[ :: ]]{
                          9,
                          --[[ [] ]]0
                        }
                      }
                    }
                  }
                }
              });
          pop(0);
          if (align.contents % 2 ~= 0) then do
            out(1216605192);
          end
           end 
          out(65488);
          if (align.contents % 2 ~= 0) then do
            return out(1216594952);
          end else do
            return 0;
          end end  end end 
       if ___conditional___ == "++"
       or ___conditional___ == "--"
       end
      return Curry._1(unnext, t);
        
    end
    patchlval(--[[ () ]]0);
    out(4753857);
    read(lval.contents[1]);
    return out(List.assoc(--[[ tuple ]]{
                    op,
                    lval.contents[1]
                  }, --[[ :: ]]{
                    --[[ tuple ]]{
                      --[[ tuple ]]{
                        "++",
                        --[[ Int ]]0
                      },
                      4783873
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        --[[ tuple ]]{
                          "--",
                          --[[ Int ]]0
                        },
                        4783881
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          --[[ tuple ]]{
                            "++",
                            --[[ Chr ]]1
                          },
                          65025
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            --[[ tuple ]]{
                              "--",
                              --[[ Chr ]]1
                            },
                            65033
                          },
                          --[[ [] ]]0
                        }
                      }
                    }
                  }));
  end end 
end end

function expr(stk) do
  binary(stk, 10);
  _param = --[[ () ]]0;
  while(true) do
    t = Curry._1(next_1, --[[ () ]]0);
    if (t.tag or t[0] ~= "=") then do
      return Curry._1(unnext, t);
    end else do
      patchlval(--[[ () ]]0);
      ty = lval.contents[1];
      push(0);
      expr(stk);
      pop(1);
      if (ty == --[[ Int ]]0) then do
        out(4753665);
      end else do
        out(34817);
      end end 
      _param = --[[ () ]]0;
      ::continue:: ;
    end end 
  end;
end end

function decl(g, _n, _stk) do
  while(true) do
    stk = _stk;
    n = _n;
    t = Curry._1(next_1, --[[ () ]]0);
    if (Caml_obj.caml_equal(t, tokint)) then do
      top = stk and stk[0][1] or 0;
      vars = (function(top)do
      return function vars(_n, _stk) do
        while(true) do
          stk = _stk;
          n = _n;
          while(nextis(--[[ Op ]]Block.__(0, {"*"}))) do
            Curry._1(next_1, --[[ () ]]0);
          end;
          if (nextis(--[[ Op ]]Block.__(0, {";"}))) then do
            return --[[ tuple ]]{
                    n,
                    stk
                  };
          end else do
            match = Curry._1(next_1, --[[ () ]]0);
            if (match.tag == --[[ Sym ]]3) then do
              s = match[0];
              n$prime = n + 1 | 0;
              stk$prime;
              if (g) then do
                glo = Caml_array.caml_array_get(globs, s);
                if (glo.va >= 0) then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "symbol defined twice"
                  })
                end
                 end 
                va = (gpos.contents + 232 | 0) + 4194304 | 0;
                Caml_array.caml_array_set(globs, s, {
                      loc = glo.loc,
                      va = va
                    });
                gpos.contents = gpos.contents + 8 | 0;
                stk$prime = stk;
              end else do
                stk$prime = --[[ :: ]]{
                  --[[ tuple ]]{
                    s,
                    top - (n$prime << 3) | 0
                  },
                  stk
                };
              end end 
              if (nextis(--[[ Op ]]Block.__(0, {","}))) then do
                Curry._1(next_1, --[[ () ]]0);
                _stk = stk$prime;
                _n = n$prime;
                ::continue:: ;
              end else do
                return --[[ tuple ]]{
                        n$prime,
                        stk$prime
                      };
              end end 
            end else do
              error({
                Caml_builtin_exceptions.failure,
                "[var] expected in [decl]"
              })
            end end 
          end end 
        end;
      end end
      end end)(top);
      match = vars(0, stk);
      Curry._1(next_1, --[[ () ]]0);
      if (dbg.contents) then do
        Curry._1(Printf.eprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "end of decl (",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " vars)\n",
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "end of decl (%d vars)\n"
                }), n);
      end
       end 
      _stk = match[1];
      _n = n + match[0] | 0;
      ::continue:: ;
    end else do
      Curry._1(unnext, t);
      if (not g and n ~= 0) then do
        if ((n << 3) >= 256) then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "qcc.ml",
              436,
              6
            }
          })
        end
         end 
        out(4752364);
        out((n << 3));
        align.contents = align.contents + n | 0;
      end
       end 
      if (dbg.contents and not g) then do
        console.error("end of blk decls");
      end
       end 
      return --[[ tuple ]]{
              n,
              stk
            };
    end end 
  end;
end end

retl = {
  contents = 0
};

function stmt(brk, stk) do
  pexpr = function(stk) do
    Curry._1(next_1, --[[ () ]]0);
    expr(stk);
    Curry._1(next_1, --[[ () ]]0);
    return --[[ () ]]0;
  end end;
  t = Curry._1(next_1, --[[ () ]]0);
  if (Caml_obj.caml_equal(t, tokif)) then do
    pexpr(stk);
    loc = test(0, 0);
    stmt(brk, stk);
    loc_1;
    if (nextis(tokelse)) then do
      Curry._1(next_1, --[[ () ]]0);
      out(233);
      l = opos.contents;
      le(32, 0);
      patch(true, loc, opos.contents);
      stmt(brk, stk);
      loc_1 = l;
    end else do
      loc_1 = loc;
    end end 
    return patch(true, loc_1, opos.contents);
  end else if (Caml_obj.caml_equal(t, tokwhile) or Caml_obj.caml_equal(t, tokfor)) then do
    bl = {
      contents = 0
    };
    ba = align.contents;
    match;
    if (Caml_obj.caml_equal(t, tokwhile)) then do
      loc_2 = opos.contents;
      pexpr(stk);
      bl.contents = test(0, 0);
      match = --[[ tuple ]]{
        0,
        loc_2
      };
    end else do
      Curry._1(next_1, --[[ () ]]0);
      if (not nextis(--[[ Op ]]Block.__(0, {";"}))) then do
        expr(stk);
      end
       end 
      Curry._1(next_1, --[[ () ]]0);
      top = opos.contents;
      if (nextis(--[[ Op ]]Block.__(0, {";"}))) then do
        bl.contents = 0;
      end else do
        expr(stk);
        bl.contents = test(0, 0);
      end end 
      Curry._1(next_1, --[[ () ]]0);
      out(233);
      bdy = opos.contents;
      le(32, 0);
      itr = opos.contents;
      expr(stk);
      Curry._1(next_1, --[[ () ]]0);
      out(233);
      le(32, (top - opos.contents | 0) - 4 | 0);
      match = --[[ tuple ]]{
        bdy,
        itr
      };
    end end 
    patch(true, match[0], opos.contents);
    stmt(--[[ tuple ]]{
          bl,
          ba
        }, stk);
    out(233);
    le(32, (match[1] - opos.contents | 0) - 4 | 0);
    return patch(true, bl.contents, opos.contents);
  end else if (Caml_obj.caml_equal(t, tokret)) then do
    if (not nextis(--[[ Op ]]Block.__(0, {";"}))) then do
      expr(stk);
    end
     end 
    Curry._1(next_1, --[[ () ]]0);
    out(233);
    loc_3 = opos.contents;
    le(32, retl.contents);
    retl.contents = loc_3;
    return --[[ () ]]0;
  end else if (Caml_obj.caml_equal(t, tokbreak)) then do
    Curry._1(next_1, --[[ () ]]0);
    brkl = brk[0];
    n = align.contents - brk[1] | 0;
    if (n < 0) then do
      error({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "qcc.ml",
          515,
          4
        }
      })
    end
     end 
    if (n ~= 0) then do
      out(4752324);
      out((n << 3));
    end
     end 
    out(233);
    loc_4 = opos.contents;
    le(32, brkl.contents);
    brkl.contents = loc_4;
    return --[[ () ]]0;
  end else if (not t.tag) then do
    local ___conditional___=(t[0]);
    do
       if ___conditional___ == ";" then do
          return --[[ () ]]0; end end 
       if ___conditional___ == "{" then do
          return block(brk, stk); end end 
      
    end
  end
   end  end  end  end  end 
  Curry._1(unnext, t);
  expr(stk);
  Curry._1(next_1, --[[ () ]]0);
  return --[[ () ]]0;
end end

function block(brk, stk) do
  match = decl(false, 0, stk);
  stk$prime = match[1];
  n = match[0];
  while(not nextis(--[[ Op ]]Block.__(0, {"}"}))) do
    stmt(brk, stk$prime);
  end;
  Curry._1(next_1, --[[ () ]]0);
  if (n ~= 0) then do
    out(4752324);
    out((n << 3));
    align.contents = align.contents - n | 0;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function top(_param) do
  while(true) do
    if (nextis(--[[ Op ]]Block.__(0, {"EOF!"}))) then do
      return 0;
    end else if (nextis(tokint)) then do
      decl(true, 0, --[[ [] ]]0);
      _param = --[[ () ]]0;
      ::continue:: ;
    end else do
      match = Curry._1(next_1, --[[ () ]]0);
      if (match.tag == --[[ Sym ]]3) then do
        f = match[0];
        g = Caml_array.caml_array_get(globs, f);
        if (g.va >= 0) then do
          error({
            Caml_builtin_exceptions.failure,
            "symbol defined twice"
          })
        end
         end 
        Caml_array.caml_array_set(globs, f, {
              loc = g.loc,
              va = opos.contents
            });
        emitargs = function(_regs, _n, _stk) do
          while(true) do
            stk = _stk;
            n = _n;
            regs = _regs;
            match = Curry._1(next_1, --[[ () ]]0);
            local ___conditional___=(match.tag | 0);
            do
               if ___conditional___ == 0--[[ Op ]] then do
                  if (match[0] == ")") then do
                    return stk;
                  end else do
                    error({
                      Caml_builtin_exceptions.failure,
                      "[var] or ) expected"
                    })
                  end end  end end 
               if ___conditional___ == 1--[[ ILit ]]
               or ___conditional___ == 2--[[ SLit ]] then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "[var] or ) expected"
                  }) end end 
               if ___conditional___ == 3--[[ Sym ]] then do
                  r = List.hd(regs);
                  push(r);
                  if (nextis(--[[ Op ]]Block.__(0, {","}))) then do
                    Curry._1(next_1, --[[ () ]]0);
                  end
                   end 
                  stk$prime_000 = --[[ tuple ]]{
                    match[0],
                    ((-n | 0) << 3)
                  };
                  stk$prime = --[[ :: ]]{
                    stk$prime_000,
                    stk
                  };
                  _stk = stk$prime;
                  _n = n + 1 | 0;
                  _regs = List.tl(regs);
                  ::continue:: ; end end 
              
            end
          end;
        end end;
        Curry._1(next_1, --[[ () ]]0);
        align.contents = 0;
        out(85);
        out(4753893);
        stk = emitargs(--[[ :: ]]{
              7,
              --[[ :: ]]{
                6,
                --[[ :: ]]{
                  2,
                  --[[ :: ]]{
                    1,
                    --[[ :: ]]{
                      8,
                      --[[ :: ]]{
                        9,
                        --[[ [] ]]0
                      }
                    }
                  }
                }
              }
            }, 1, --[[ [] ]]0);
        while(Caml_obj.caml_notequal(Curry._1(next_1, --[[ () ]]0), --[[ Op ]]Block.__(0, {"{"}))) do
          
        end;
        retl.contents = 0;
        block(--[[ tuple ]]{
              {
                contents = 0
              },
              0
            }, stk);
        patch(true, retl.contents, opos.contents);
        out(51651);
        if (dbg.contents) then do
          Curry._1(Printf.eprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "done with function ",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ Char_literal ]]Block.__(12, {
                                --[[ "\n" ]]10,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    "done with function %s\n"
                  }), symstr(f));
        end
         end 
        _param = --[[ () ]]0;
        ::continue:: ;
      end else do
        error({
          Caml_builtin_exceptions.failure,
          "[decl] or [fun] expected"
        })
      end end 
    end end  end 
  end;
end end

elfhdr = Bytes.of_string(__String.concat("", --[[ :: ]]{
          "\x7fELF\x02\x01\x01\0",
          --[[ :: ]]{
            "\0\0\0\0\0\0\0\0",
            --[[ :: ]]{
              "\x02\0",
              --[[ :: ]]{
                ">\0",
                --[[ :: ]]{
                  "\x01\0\0\0",
                  --[[ :: ]]{
                    "\0\0\0\0\0\0\0\0",
                    --[[ :: ]]{
                      "@\0\0\0\0\0\0\0",
                      --[[ :: ]]{
                        "\0\0\0\0\0\0\0\0",
                        --[[ :: ]]{
                          "\0\0\0\0",
                          --[[ :: ]]{
                            "@\0",
                            --[[ :: ]]{
                              "8\0",
                              --[[ :: ]]{
                                "\x03\0",
                                --[[ :: ]]{
                                  "@\0",
                                  --[[ :: ]]{
                                    "\0\0",
                                    --[[ :: ]]{
                                      "\0\0",
                                      --[[ [] ]]0
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }));

function elfphdr(ty, off, sz, align) do
  le(32, ty);
  le(32, 7);
  le(64, off);
  le(64, off + 4194304 | 0);
  le(64, off + 4194304 | 0);
  le(64, sz);
  le(64, sz);
  return le(64, align);
end end

function elfgen(outf) do
  entry = opos.contents;
  main = addsym("main");
  gmain = Caml_array.caml_array_get(globs, main);
  out(1217084452);
  out(-1921768440);
  out(18616);
  le(64, gmain.loc);
  Caml_array.caml_array_set(globs, main, {
        loc = opos.contents - 8 | 0,
        va = gmain.va
      });
  out(65488);
  out(35271);
  load(0, 60);
  out(3845);
  off = 232 + gpos.contents | 0;
  itr = function(f) do
    return symitr((function(i, s) do
                  g = Caml_array.caml_array_get(globs, i);
                  if (g.va < 0 and g.loc ~= 0) then do
                    return Curry._3(f, s, #s, g.loc);
                  end else do
                    return 0;
                  end end 
                end end));
  end end;
  va = function(x) do
    return (x + off | 0) + 4194304 | 0;
  end end;
  patchloc = function(i, param) do
    g = Caml_array.caml_array_get(globs, i);
    if (g.va >= 0 and g.va < 4194304) then do
      return patch(false, g.loc, va(g.va));
    end else if (g.va >= 0) then do
      return patch(false, g.loc, g.va);
    end else do
      return 0;
    end end  end 
  end end;
  symitr(patchloc);
  strtab = opos.contents;
  opos.contents = opos.contents + 1 | 0;
  __String.blit("/lib64/ld-linux-x86-64.so.2\0libc.so.6", 0, obuf, opos.contents, 37);
  opos.contents = (opos.contents + 37 | 0) + 1 | 0;
  itr((function(s, sl, param) do
          __String.blit(s, 0, obuf, opos.contents, sl);
          opos.contents = (opos.contents + sl | 0) + 1 | 0;
          return --[[ () ]]0;
        end end));
  opos.contents = opos.contents + 7 & -8;
  symtab = opos.contents;
  n = {
    contents = 39
  };
  opos.contents = opos.contents + 24 | 0;
  itr((function(param, sl, param_1) do
          le(32, n.contents);
          le(32, 16);
          le(64, 0);
          le(64, 0);
          n.contents = (n.contents + sl | 0) + 1 | 0;
          return --[[ () ]]0;
        end end));
  rel = opos.contents;
  n_1 = {
    contents = 1
  };
  itr((function(param, param_1, l) do
          genrel = function(_l) do
            while(true) do
              l = _l;
              if (l ~= 0) then do
                le(64, va(l));
                le(64, 1 + (n_1.contents << 32) | 0);
                le(64, 0);
                _l = get32(l);
                ::continue:: ;
              end else do
                return 0;
              end end 
            end;
          end end;
          genrel(l);
          n_1.contents = n_1.contents + 1 | 0;
          return --[[ () ]]0;
        end end));
  hash = opos.contents;
  n_2 = ((rel - symtab | 0) / 24 | 0) - 1 | 0;
  le(32, 1);
  le(32, n_2 + 1 | 0);
  le(32, n_2 > 0 and 1 or 0);
  for i = 1 , n_2 , 1 do
    le(32, i);
  end
  le(32, 0);
  dyn = opos.contents;
  List.iter((function(param) do
          return le(64, param);
        end end), --[[ :: ]]{
        1,
        --[[ :: ]]{
          29,
          --[[ :: ]]{
            4,
            --[[ :: ]]{
              va(hash),
              --[[ :: ]]{
                5,
                --[[ :: ]]{
                  va(strtab),
                  --[[ :: ]]{
                    6,
                    --[[ :: ]]{
                      va(symtab),
                      --[[ :: ]]{
                        7,
                        --[[ :: ]]{
                          va(rel),
                          --[[ :: ]]{
                            8,
                            --[[ :: ]]{
                              hash - rel | 0,
                              --[[ :: ]]{
                                9,
                                --[[ :: ]]{
                                  24,
                                  --[[ :: ]]{
                                    10,
                                    --[[ :: ]]{
                                      symtab - strtab | 0,
                                      --[[ :: ]]{
                                        11,
                                        --[[ :: ]]{
                                          24,
                                          --[[ :: ]]{
                                            0,
                                            --[[ [] ]]0
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      });
  tend = opos.contents;
  Bytes.blit(obuf, 0, obuf, off, tend);
  Bytes.blit(glo, 0, obuf, 232, gpos.contents);
  Bytes.blit(elfhdr, 0, obuf, 0, 64);
  opos.contents = 64;
  elfphdr(3, (strtab + 1 | 0) + off | 0, 28, 1);
  elfphdr(1, 0, tend + off | 0, 2097152);
  elfphdr(2, dyn + off | 0, tend - dyn | 0, 8);
  if (opos.contents ~= 232) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "qcc.ml",
        698,
        2
      }
    })
  end
   end 
  patch(false, 24, va(entry));
  return Pervasives.output_bytes(outf, Bytes.sub(obuf, 0, tend + off | 0));
end end

function main(param) do
  ppsym = function(param) do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Op ]] then do
          return Curry._1(Printf.printf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Operator '",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      "'\n",
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "Operator '%s'\n"
                        }), param[0]); end end 
       if ___conditional___ == 1--[[ ILit ]] then do
          return Curry._1(Printf.printf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Int literal ",
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "\n" ]]10,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "Int literal %d\n"
                        }), param[0]); end end 
       if ___conditional___ == 2--[[ SLit ]] then do
          return Curry._1(Printf.printf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Str literal ",
                              --[[ Caml_string ]]Block.__(3, {
                                  --[[ No_padding ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "\n" ]]10,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "Str literal %S\n"
                        }), param[1]); end end 
       if ___conditional___ == 3--[[ Sym ]] then do
          i = param[0];
          return Curry._2(Printf.printf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Symbol '",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      "' (",
                                      --[[ Int ]]Block.__(4, {
                                          --[[ Int_d ]]0,
                                          --[[ No_padding ]]0,
                                          --[[ No_precision ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              ")\n",
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    })
                                })
                            }),
                          "Symbol '%s' (%d)\n"
                        }), symstr(i), i); end end 
      
    end
  end end;
  f = #Sys.argv < 2 and "-blk" or Caml_array.caml_array_get(Sys.argv, 1);
  local ___conditional___=(f);
  do
     if ___conditional___ == "-blk" then do
        partial_arg_000 = {
          contents = 0
        };
        partial_arg = --[[ tuple ]]{
          partial_arg_000,
          0
        };
        c = function(param) do
          return block(partial_arg, param);
        end end;
        stk = --[[ [] ]]0;
        opos.contents = 0;
        Curry._1(c, stk);
        return Pervasives.print_bytes(Bytes.sub(obuf, 0, opos.contents)); end end 
     if ___conditional___ == "-lex" then do
        _param = --[[ () ]]0;
        while(true) do
          tok = Curry._1(next_1, --[[ () ]]0);
          if (tok.tag) then do
            ppsym(tok);
            _param = --[[ () ]]0;
            ::continue:: ;
          end else if (tok[0] == "EOF!") then do
            return Printf.printf(--[[ Format ]]{
                        --[[ String_literal ]]Block.__(11, {
                            "End of input stream\n",
                            --[[ End_of_format ]]0
                          }),
                        "End of input stream\n"
                      });
          end else do
            ppsym(tok);
            _param = --[[ () ]]0;
            ::continue:: ;
          end end  end 
        end; end end 
    oc = Pervasives.open_out("a.out");
      inch.contents = Pervasives.open_in_bin(f);
      top(--[[ () ]]0);
      elfgen(oc);
      Caml_io.caml_ml_flush(oc);
      return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
      
  end
end end

main(--[[ () ]]0);

base = 4194304;

textoff = 232;

exports = {}
exports.dbg = dbg;
exports.inch = inch;
exports.bufferize = bufferize;
exports.getch = getch;
exports.ungetch = ungetch;
exports.peekch = peekch;
exports.addsym = addsym;
exports.symstr = symstr;
exports.symitr = symitr;
exports.glo = glo;
exports.gpos = gpos;
exports.base = base;
exports.textoff = textoff;
exports.next = next_1;
exports.unnext = unnext;
exports.nextis = nextis;
exports.obuf = obuf;
exports.opos = opos;
exports.out = out;
exports.le = le;
exports.get32 = get32;
exports.patch = patch;
exports.load = load;
exports.cmp = cmp;
exports.test = test;
exports.align = align;
exports.push = push;
exports.pop = pop;
exports.lval = lval;
exports.patchlval = patchlval;
exports.read = read;
exports.globs = globs;
exports.lvls = lvls;
exports.inss = inss;
exports.tokint = tokint;
exports.tokchar = tokchar;
exports.tokret = tokret;
exports.tokif = tokif;
exports.tokelse = tokelse;
exports.tokwhile = tokwhile;
exports.tokfor = tokfor;
exports.tokbreak = tokbreak;
exports.binary = binary;
exports.unary = unary;
exports.postfix = postfix;
exports.expr = expr;
exports.decl = decl;
exports.retl = retl;
exports.stmt = stmt;
exports.block = block;
exports.top = top;
exports.elfhdr = elfhdr;
exports.elfphdr = elfphdr;
exports.elfgen = elfgen;
exports.main = main;
--[[ match Not a pure module ]]
