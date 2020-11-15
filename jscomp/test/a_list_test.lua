__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Ext_list_test = require "..ext_list_test";

suites_000 = --[[ tuple ]]{
  "drop",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                Ext_list_test.drop(3, --[[ :: ]]{
                      0,
                      --[[ :: ]]{
                        1,
                        --[[ :: ]]{
                          2,
                          --[[ [] ]]0
                        }
                      }
                    }),
                --[[ [] ]]0
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "drop1",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  Ext_list_test.drop(2, --[[ :: ]]{
                        0,
                        --[[ :: ]]{
                          1,
                          --[[ :: ]]{
                            2,
                            --[[ [] ]]0
                          }
                        }
                      }),
                  --[[ :: ]]{
                    2,
                    --[[ [] ]]0
                  }
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "flat_map",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    --[[ :: ]]{
                      0,
                      --[[ :: ]]{
                        0,
                        --[[ :: ]]{
                          1,
                          --[[ :: ]]{
                            1,
                            --[[ :: ]]{
                              0,
                              --[[ [] ]]0
                            }
                          }
                        }
                      }
                    },
                    Ext_list_test.flat_map((function(x) do
                            if (x % 2 == 0) then do
                              return --[[ :: ]]{
                                      0,
                                      --[[ [] ]]0
                                    };
                            end else do
                              return --[[ :: ]]{
                                      1,
                                      --[[ :: ]]{
                                        1,
                                        --[[ [] ]]0
                                      }
                                    };
                            end end 
                          end end), --[[ :: ]]{
                          0,
                          --[[ :: ]]{
                            0,
                            --[[ :: ]]{
                              3,
                              --[[ :: ]]{
                                0,
                                --[[ [] ]]0
                              }
                            }
                          }
                        })
                  });
        end end)
    },
    --[[ [] ]]0
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("A_list_test", suites);

exports = {};
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
