--[['use strict';]]

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Ext_string_test = require "./ext_string_test";

suites_000 = --[[ tuple ]]{
  "split",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                Ext_string_test.split(true, "hihi", --[[ "i" ]]105),
                --[[ :: ]]{
                  "h",
                  --[[ :: ]]{
                    "h",
                    --[[ :: ]]{
                      "",
                      --[[ [] ]]0
                    }
                  }
                }
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "split_non_empty",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  Ext_string_test.split(undefined, "hihi", --[[ "i" ]]105),
                  --[[ :: ]]{
                    "h",
                    --[[ :: ]]{
                      "h",
                      --[[ [] ]]0
                    }
                  }
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "split_empty",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    Ext_string_test.split(true, "", --[[ "i" ]]105),
                    --[[ [] ]]0
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "split_normal",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      Ext_string_test.split(true, "h i i", --[[ " " ]]32),
                      --[[ :: ]]{
                        "h",
                        --[[ :: ]]{
                          "i",
                          --[[ :: ]]{
                            "i",
                            --[[ [] ]]0
                          }
                        }
                      }
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "split_by",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        List.filter((function (s) do
                                  return s ~= "";
                                end end))(Ext_string_test.split_by(undefined, (function (x) do
                                    if (x == --[[ " " ]]32) then do
                                      return true;
                                    end else do
                                      return x == --[[ "\t" ]]9;
                                    end end 
                                  end end), "h hgso hgso \t hi")),
                        --[[ :: ]]{
                          "h",
                          --[[ :: ]]{
                            "hgso",
                            --[[ :: ]]{
                              "hgso",
                              --[[ :: ]]{
                                "hi",
                                --[[ [] ]]0
                              }
                            }
                          }
                        }
                      });
            end end)
        },
        --[[ [] ]]0
      }
    }
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("A_string_test", suites);

split = Ext_string_test.split;

split_by = Ext_string_test.split_by;

exports.split = split;
exports.split_by = split_by;
exports.suites = suites;
--[[  Not a pure module ]]
