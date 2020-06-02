console.log = print;

Mt = require "./mt";
Block = require "../../lib/js/block";
Js_types = require "../../lib/js/js_types";

function string_or_number(x) do
  ty = Js_types.classify(x);
  if (typeof ty == "number") then do
    local ___conditional___=(ty);
    do
       if ___conditional___ = 0--[[ JSFalse ]]
       or ___conditional___ = 1--[[ JSTrue ]] then do
          return false;end end end 
       do
      else do
        return false;
        end end
        
    end
  end else do
    local ___conditional___=(ty.tag | 0);
    do
       if ___conditional___ = 0--[[ JSNumber ]] then do
          console.log(ty[0] + 3);
          return true;end end end 
       if ___conditional___ = 1--[[ JSString ]] then do
          console.log(ty[0] .. "hei");
          return true;end end end 
       if ___conditional___ = 2--[[ JSFunction ]] then do
          console.log("Function");
          return false;end end end 
       do
      else do
        return false;
        end end
        
    end
  end end 
end end

suites_000 = --[[ tuple ]]{
  "int_type",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                "number",
                "number"
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "string_type",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  "string",
                  "string"
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "number_gadt_test",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    Js_types.test(3, --[[ Number ]]3),
                    true
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "boolean_gadt_test",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      Js_types.test(true, --[[ Boolean ]]2),
                      true
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "undefined_gadt_test",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        Js_types.test(undefined, --[[ Undefined ]]0),
                        true
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "string_on_number1",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          string_or_number("xx"),
                          true
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "string_on_number2",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            string_or_number(3.02),
                            true
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "string_on_number3",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              string_or_number((function (x) do
                                      return x;
                                    end end)),
                              false
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "string_gadt_test",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                Js_types.test("3", --[[ String ]]4),
                                true
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "string_gadt_test_neg",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, {
                                  Js_types.test(3, --[[ String ]]4),
                                  false
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "function_gadt_test",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, {
                                    Js_types.test((function (x) do
                                            return x;
                                          end end), --[[ Function ]]5),
                                    true
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "object_gadt_test",
                        (function (param) do
                            return --[[ Eq ]]Block.__(0, {
                                      Js_types.test(do
                                            x: 3
                                          end, --[[ Object ]]6),
                                      true
                                    });
                          end end)
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
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Typeof_test", suites);

exports.string_or_number = string_or_number;
exports.suites = suites;
--[[  Not a pure module ]]
