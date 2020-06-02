console = {log = print};

Mt = require "./mt";
Arg = require "../../lib/js/arg";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Printf = require "../../lib/js/printf";
Caml_obj = require "../../lib/js/caml_obj";

current = do
  contents: 0
end;

accum = do
  contents: --[[ [] ]]0
end;

function record(fmt) do
  return Printf.kprintf((function(s) do
                accum.contents = --[[ :: ]]{
                  s,
                  accum.contents
                };
                return --[[ () ]]0;
              end end), fmt);
end end

function f_unit(param) do
  return record(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "unit()",
                  --[[ End_of_format ]]0
                }),
              "unit()"
            });
end end

function f_bool(b) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "bool(",
                      --[[ Bool ]]Block.__(9, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "bool(%b)"
                }), b);
end end

r_set = do
  contents: false
end;

r_clear = do
  contents: true
end;

function f_string(s) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "string(",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "string(%s)"
                }), s);
end end

r_string = do
  contents: ""
end;

function f_int(i) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "int(",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "int(%d)"
                }), i);
end end

r_int = do
  contents: 0
end;

function f_float(f) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "float(",
                      --[[ Float ]]Block.__(8, {
                          --[[ Float_g ]]9,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "float(%g)"
                }), f);
end end

r_float = do
  contents: 0.0
end;

function f_symbol(s) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "symbol(",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "symbol(%s)"
                }), s);
end end

function f_rest(s) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "rest(",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "rest(%s)"
                }), s);
end end

function f_anon(s) do
  return Curry._1(record(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "anon(",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ ")" ]]41,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "anon(%s)"
                }), s);
end end

spec_000 = --[[ tuple ]]{
  "-u",
  --[[ Unit ]]Block.__(0, {f_unit}),
  "Unit (0)"
};

spec_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "-b",
    --[[ Bool ]]Block.__(1, {f_bool}),
    "Bool (1)"
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "-s",
      --[[ Set ]]Block.__(2, {r_set}),
      "Set (0)"
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "-c",
        --[[ Clear ]]Block.__(3, {r_clear}),
        "Clear (0)"
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "-str",
          --[[ String ]]Block.__(4, {f_string}),
          "String (1)"
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "-sstr",
            --[[ Set_string ]]Block.__(5, {r_string}),
            "Set_string (1)"
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "-i",
              --[[ Int ]]Block.__(6, {f_int}),
              "Int (1)"
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "-si",
                --[[ Set_int ]]Block.__(7, {r_int}),
                "Set_int (1)"
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "-f",
                  --[[ Float ]]Block.__(8, {f_float}),
                  "Float (1)"
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "-sf",
                    --[[ Set_float ]]Block.__(9, {r_float}),
                    "Set_float (1)"
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "-t",
                      --[[ Tuple ]]Block.__(10, {--[[ :: ]]{
                            --[[ Bool ]]Block.__(1, {f_bool}),
                            --[[ :: ]]{
                              --[[ String ]]Block.__(4, {f_string}),
                              --[[ :: ]]{
                                --[[ Int ]]Block.__(6, {f_int}),
                                --[[ [] ]]0
                              }
                            }
                          }}),
                      "Tuple (3)"
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "-sym",
                        --[[ Symbol ]]Block.__(11, {
                            --[[ :: ]]{
                              "a",
                              --[[ :: ]]{
                                "b",
                                --[[ :: ]]{
                                  "c",
                                  --[[ [] ]]0
                                }
                              }
                            },
                            f_symbol
                          }),
                        "Symbol (1)"
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "-rest",
                          --[[ Rest ]]Block.__(12, {f_rest}),
                          "Rest (*)"
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
};

spec = --[[ :: ]]{
  spec_000,
  spec_001
};

args1 = {
  "prog",
  "anon1",
  "-u",
  "-b",
  "true",
  "-s",
  "anon2",
  "-c",
  "-str",
  "foo",
  "-sstr",
  "bar",
  "-i",
  "19",
  "-si",
  "42",
  "-f",
  "3.14",
  "-sf",
  "2.72",
  "anon3",
  "-t",
  "false",
  "gee",
  "1436",
  "-sym",
  "c",
  "anon4",
  "-rest",
  "r1",
  "r2"
};

args2 = {
  "prog",
  "anon1",
  "-u",
  "-b=true",
  "-s",
  "anon2",
  "-c",
  "-str=foo",
  "-sstr=bar",
  "-i=19",
  "-si=42",
  "-f=3.14",
  "-sf=2.72",
  "anon3",
  "-t",
  "false",
  "gee",
  "1436",
  "-sym=c",
  "anon4",
  "-rest",
  "r1",
  "r2"
};

function error(s) do
  return Curry._1(Printf.printf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "error (",
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ")\n",
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "error (%s)\n"
                }), s);
end end

function check(r, v, msg) do
  if (Caml_obj.caml_notequal(r.contents, v)) then do
    return error(msg);
  end else do
    return 0;
  end end 
end end

function test(argv) do
  current.contents = 0;
  r_set.contents = false;
  r_clear.contents = true;
  r_string.contents = "";
  r_int.contents = 0;
  r_float.contents = 0.0;
  accum.contents = --[[ [] ]]0;
  Arg.parse_argv(current, argv, spec, f_anon, "usage");
  result = List.rev(accum.contents);
  reference = --[[ :: ]]{
    "anon(anon1)",
    --[[ :: ]]{
      "unit()",
      --[[ :: ]]{
        "bool(true)",
        --[[ :: ]]{
          "anon(anon2)",
          --[[ :: ]]{
            "string(foo)",
            --[[ :: ]]{
              "int(19)",
              --[[ :: ]]{
                "float(3.14)",
                --[[ :: ]]{
                  "anon(anon3)",
                  --[[ :: ]]{
                    "bool(false)",
                    --[[ :: ]]{
                      "string(gee)",
                      --[[ :: ]]{
                        "int(1436)",
                        --[[ :: ]]{
                          "symbol(c)",
                          --[[ :: ]]{
                            "anon(anon4)",
                            --[[ :: ]]{
                              "rest(r1)",
                              --[[ :: ]]{
                                "rest(r2)",
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
  };
  if (Caml_obj.caml_notequal(result, reference)) then do
    f = function(x, y) do
      return Curry._3(Printf.printf(--[[ Format ]]{
                      --[[ String ]]Block.__(2, {
                          --[[ Lit_padding ]]Block.__(0, {
                              --[[ Right ]]1,
                              20
                            }),
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ " " ]]32,
                              --[[ Char ]]Block.__(0, {--[[ Char_literal ]]Block.__(12, {
                                      --[[ " " ]]32,
                                      --[[ String ]]Block.__(2, {
                                          --[[ Lit_padding ]]Block.__(0, {
                                              --[[ Left ]]0,
                                              20
                                            }),
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ "\n" ]]10,
                                              --[[ Flush ]]Block.__(10, {--[[ End_of_format ]]0})
                                            })
                                        })
                                    })})
                            })
                        }),
                      "%20s %c %-20s\n%!"
                    }), x, x == y and --[[ "=" ]]61 or --[[ "#" ]]35, y);
    end end;
    List.iter2(f, result, reference);
  end
   end 
  check(r_set, true, "Set");
  check(r_clear, false, "Clear");
  check(r_string, "bar", "Set_string");
  check(r_int, 42, "Set_int");
  return check(r_float, 2.72, "Set_float");
end end

test(args1);

test(args2);

Mt.from_pair_suites("Libarg_test", --[[ [] ]]0);

suites = --[[ [] ]]0;

exports = {}
exports.current = current;
exports.accum = accum;
exports.record = record;
exports.f_unit = f_unit;
exports.f_bool = f_bool;
exports.r_set = r_set;
exports.r_clear = r_clear;
exports.f_string = f_string;
exports.r_string = r_string;
exports.f_int = f_int;
exports.r_int = r_int;
exports.f_float = f_float;
exports.r_float = r_float;
exports.f_symbol = f_symbol;
exports.f_rest = f_rest;
exports.f_anon = f_anon;
exports.spec = spec;
exports.args1 = args1;
exports.args2 = args2;
exports.error = error;
exports.check = check;
exports.test = test;
exports.suites = suites;
--[[  Not a pure module ]]