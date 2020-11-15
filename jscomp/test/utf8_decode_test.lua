__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Stream = require "......lib.js.stream";
Caml_bytes = require "......lib.js.caml_bytes";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function classify(chr) do
  if ((chr & 128) == 0) then do
    return --[[ Single ]]Block.__(0, {chr});
  end else if ((chr & 64) == 0) then do
    return --[[ Cont ]]Block.__(1, {chr & 63});
  end else if ((chr & 32) == 0) then do
    return --[[ Leading ]]Block.__(2, {
              1,
              chr & 31
            });
  end else if ((chr & 16) == 0) then do
    return --[[ Leading ]]Block.__(2, {
              2,
              chr & 15
            });
  end else if ((chr & 8) == 0) then do
    return --[[ Leading ]]Block.__(2, {
              3,
              chr & 7
            });
  end else if ((chr & 4) == 0) then do
    return --[[ Leading ]]Block.__(2, {
              4,
              chr & 3
            });
  end else if ((chr & 2) == 0) then do
    return --[[ Leading ]]Block.__(2, {
              5,
              chr & 1
            });
  end else do
    return --[[ Invalid ]]0;
  end end  end  end  end  end  end  end 
end end

function utf8_decode(strm) do
  return Stream.slazy((function(param) do
                match = Stream.peek(strm);
                if (match ~= nil) then do
                  Stream.junk(strm);
                  match_1 = classify(match);
                  if (type(match_1) == "number") then do
                    error({
                      Stream.__Error,
                      "Invalid byte"
                    })
                  end else do
                    local ___conditional___=(match_1.tag | 0);
                    do
                       if ___conditional___ == 0--[[ Single ]] then do
                          return Stream.icons(match_1[1], utf8_decode(strm)); end end 
                       if ___conditional___ == 1--[[ Cont ]] then do
                          error({
                            Stream.__Error,
                            "Unexpected continuation byte"
                          }) end end 
                       if ___conditional___ == 2--[[ Leading ]] then do
                          follow = function(strm, _n, _c) do
                            while(true) do
                              c = _c;
                              n = _n;
                              if (n == 0) then do
                                return c;
                              end else do
                                match = classify(Stream.next(strm));
                                if (type(match) == "number") then do
                                  error({
                                    Stream.__Error,
                                    "Continuation byte expected"
                                  })
                                end else if (match.tag == --[[ Cont ]]1) then do
                                  _c = (c << 6) | match[1] & 63;
                                  _n = n - 1 | 0;
                                  ::continue:: ;
                                end else do
                                  error({
                                    Stream.__Error,
                                    "Continuation byte expected"
                                  })
                                end end  end 
                              end end 
                            end;
                          end end;
                          return Stream.icons(follow(strm, match_1[1], match_1[2]), utf8_decode(strm)); end end 
                      
                    end
                  end end 
                end
                 end 
              end end));
end end

function to_list(xs) do
  v = {
    contents = --[[ [] ]]0
  };
  Stream.iter((function(x) do
          v.contents = --[[ :: ]]{
            x,
            v.contents
          };
          return --[[ () ]]0;
        end end), xs);
  return List.rev(v.contents);
end end

function utf8_list(s) do
  return to_list(utf8_decode(Stream.of_string(s)));
end end

function decode(bytes, offset) do
  offset_1 = offset;
  match = classify(Caml_bytes.get(bytes, offset_1));
  if (type(match) == "number") then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "decode"
    })
  end else do
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 0--[[ Single ]] then do
          return --[[ tuple ]]{
                  match[1],
                  offset_1 + 1 | 0
                }; end end 
       if ___conditional___ == 1--[[ Cont ]] then do
          error({
            Caml_builtin_exceptions.invalid_argument,
            "decode"
          }) end end 
       if ___conditional___ == 2--[[ Leading ]] then do
          _n = match[1];
          _c = match[2];
          _offset = offset_1 + 1 | 0;
          while(true) do
            offset_2 = _offset;
            c = _c;
            n = _n;
            if (n == 0) then do
              return --[[ tuple ]]{
                      c,
                      offset_2
                    };
            end else do
              match_1 = classify(Caml_bytes.get(bytes, offset_2));
              if (type(match_1) == "number") then do
                error({
                  Caml_builtin_exceptions.invalid_argument,
                  "decode"
                })
              end else if (match_1.tag == --[[ Cont ]]1) then do
                _offset = offset_2 + 1 | 0;
                _c = (c << 6) | match_1[1] & 63;
                _n = n - 1 | 0;
                ::continue:: ;
              end else do
                error({
                  Caml_builtin_exceptions.invalid_argument,
                  "decode"
                })
              end end  end 
            end end 
          end; end end 
      
    end
  end end 
end end

function eq_list(cmp, _xs, _ys) do
  while(true) do
    ys = _ys;
    xs = _xs;
    if (xs) then do
      if (ys and Curry._2(cmp, xs[1], ys[1])) then do
        _ys = ys[2];
        _xs = xs[2];
        ::continue:: ;
      end else do
        return false;
      end end 
    end else if (ys) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[2];
  x = param[1];
  test_id.contents = test_id.contents + 1 | 0;
  __console.log(--[[ tuple ]]{
        x,
        y
      });
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

List.iter((function(param) do
        return eq("File \"utf8_decode_test.ml\", line 107, characters 7-14", --[[ tuple ]]{
                    true,
                    eq_list((function(prim, prim_1) do
                            return prim == prim_1;
                          end end), to_list(utf8_decode(Stream.of_string(param[1]))), param[2])
                  });
      end end), --[[ :: ]]{
      --[[ tuple ]]{
        "\xe4\xbd\xa0\xe5\xa5\xbdBuckleScript,\xe6\x9c\x80\xe5\xa5\xbd\xe7\x9a\x84JS\xe8\xaf\xad\xe8\xa8\x80",
        --[[ :: ]]{
          20320,
          --[[ :: ]]{
            22909,
            --[[ :: ]]{
              66,
              --[[ :: ]]{
                117,
                --[[ :: ]]{
                  99,
                  --[[ :: ]]{
                    107,
                    --[[ :: ]]{
                      108,
                      --[[ :: ]]{
                        101,
                        --[[ :: ]]{
                          83,
                          --[[ :: ]]{
                            99,
                            --[[ :: ]]{
                              114,
                              --[[ :: ]]{
                                105,
                                --[[ :: ]]{
                                  112,
                                  --[[ :: ]]{
                                    116,
                                    --[[ :: ]]{
                                      44,
                                      --[[ :: ]]{
                                        26368,
                                        --[[ :: ]]{
                                          22909,
                                          --[[ :: ]]{
                                            30340,
                                            --[[ :: ]]{
                                              74,
                                              --[[ :: ]]{
                                                83,
                                                --[[ :: ]]{
                                                  35821,
                                                  --[[ :: ]]{
                                                    35328,
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
              }
            }
          }
        }
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "hello \xe4\xbd\xa0\xe5\xa5\xbd\xef\xbc\x8c\xe4\xb8\xad\xe5\x8d\x8e\xe6\xb0\x91\xe6\x97\x8f hei",
          --[[ :: ]]{
            104,
            --[[ :: ]]{
              101,
              --[[ :: ]]{
                108,
                --[[ :: ]]{
                  108,
                  --[[ :: ]]{
                    111,
                    --[[ :: ]]{
                      32,
                      --[[ :: ]]{
                        20320,
                        --[[ :: ]]{
                          22909,
                          --[[ :: ]]{
                            65292,
                            --[[ :: ]]{
                              20013,
                              --[[ :: ]]{
                                21326,
                                --[[ :: ]]{
                                  27665,
                                  --[[ :: ]]{
                                    26063,
                                    --[[ :: ]]{
                                      32,
                                      --[[ :: ]]{
                                        104,
                                        --[[ :: ]]{
                                          101,
                                          --[[ :: ]]{
                                            105,
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
        },
        --[[ [] ]]0
      }
    });

Mt.from_pair_suites("Utf8_decode_test", suites.contents);

exports = {};
exports.classify = classify;
exports.utf8_decode = utf8_decode;
exports.to_list = to_list;
exports.utf8_list = utf8_list;
exports.decode = decode;
exports.eq_list = eq_list;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
return exports;
--[[  Not a pure module ]]
