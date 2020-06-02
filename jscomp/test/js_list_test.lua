--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Js_list = require "../../lib/js/js_list.lua";
Js_vector = require "../../lib/js/js_vector.lua";
Caml_int32 = require "../../lib/js/caml_int32.lua";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
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

eq("File \"js_list_test.ml\", line 11, characters 7-14", Js_list.flatten(--[[ :: ]]{
          --[[ :: ]]{
            1,
            --[[ :: ]]{
              2,
              --[[ [] ]]0
            }
          },
          --[[ :: ]]{
            --[[ :: ]]{
              3,
              --[[ [] ]]0
            },
            --[[ :: ]]{
              --[[ [] ]]0,
              --[[ :: ]]{
                --[[ :: ]]{
                  1,
                  --[[ :: ]]{
                    2,
                    --[[ :: ]]{
                      3,
                      --[[ [] ]]0
                    }
                  }
                },
                --[[ [] ]]0
              }
            }
          }
        }), --[[ :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ :: ]]{
          3,
          --[[ :: ]]{
            1,
            --[[ :: ]]{
              2,
              --[[ :: ]]{
                3,
                --[[ [] ]]0
              }
            }
          }
        }
      }
    });

eq("File \"js_list_test.ml\", line 14, characters 7-14", Js_list.filterMap((function (x) do
            if (x % 2 == 0) then do
              return x;
            end
             end 
          end end), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ :: ]]{
                  5,
                  --[[ :: ]]{
                    6,
                    --[[ :: ]]{
                      7,
                      --[[ [] ]]0
                    }
                  }
                }
              }
            }
          }
        }), --[[ :: ]]{
      2,
      --[[ :: ]]{
        4,
        --[[ :: ]]{
          6,
          --[[ [] ]]0
        }
      }
    });

eq("File \"js_list_test.ml\", line 17, characters 7-14", Js_list.filterMap((function (x) do
            if (x % 2 == 0) then do
              return x;
            end
             end 
          end end), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ :: ]]{
                  5,
                  --[[ :: ]]{
                    6,
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }), --[[ :: ]]{
      2,
      --[[ :: ]]{
        4,
        --[[ :: ]]{
          6,
          --[[ [] ]]0
        }
      }
    });

eq("File \"js_list_test.ml\", line 20, characters 7-14", Js_list.countBy((function (x) do
            return x % 2 == 0;
          end end), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ :: ]]{
                  5,
                  --[[ :: ]]{
                    6,
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }), 3);

function f(i) do
  return i;
end end

v = Js_vector.toList(Js_vector.init(100000, f));

eq("File \"js_list_test.ml\", line 23, characters 7-14", Js_list.countBy((function (x) do
            return x % 2 == 0;
          end end), v), 50000);

vv = Js_list.foldRight((function (x, y) do
        return --[[ :: ]]{
                x,
                y
              };
      end end), v, --[[ [] ]]0);

eq("File \"js_list_test.ml\", line 27, characters 7-14", true, Js_list.equal((function (x, y) do
            return x == y;
          end end), v, vv));

vvv = Js_list.filter((function (x) do
        return x % 10 == 0;
      end end), vv);

eq("File \"js_list_test.ml\", line 31, characters 7-14", Js_list.length(vvv), 10000);

function f$1(x) do
  return Caml_int32.imul(x, 10);
end end

eq("File \"js_list_test.ml\", line 32, characters 7-14", true, Js_list.equal((function (x, y) do
            return x == y;
          end end), vvv, Js_vector.toList(Js_vector.init(10000, f$1))));

Mt.from_pair_suites("Js_list_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
