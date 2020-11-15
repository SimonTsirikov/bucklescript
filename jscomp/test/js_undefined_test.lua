__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Caml_option = require "......lib.js.caml_option";
Js_undefined = require "......lib.js.js_undefined";

suites_000 = --[[ tuple ]]{
  "toOption - empty",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                nil,
                nil
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "toOption - 'a",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  --[[ () ]]0,
                  Caml_option.undefined_to_opt(--[[ () ]]0)
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "return",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    "something",
                    Caml_option.undefined_to_opt("something")
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "test - empty",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      true,
                      true
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "test - 'a",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        false,
                        false
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "bind - empty",
            (function(param) do
                return --[[ Eq ]]Block.__(0, {
                          nil,
                          Js_undefined.bind(nil, (function(v) do
                                  return v;
                                end end))
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "bind - 'a",
              (function(param) do
                  return --[[ Eq ]]Block.__(0, {
                            4,
                            Js_undefined.bind(2, (function(n) do
                                    return (n << 1);
                                  end end))
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "iter - empty",
                (function(param) do
                    hit = {
                      contents = false
                    };
                    Js_undefined.iter(nil, (function(param) do
                            hit.contents = true;
                            return --[[ () ]]0;
                          end end));
                    return --[[ Eq ]]Block.__(0, {
                              false,
                              hit.contents
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "iter - 'a",
                  (function(param) do
                      hit = {
                        contents = 0
                      };
                      Js_undefined.iter(2, (function(v) do
                              hit.contents = v;
                              return --[[ () ]]0;
                            end end));
                      return --[[ Eq ]]Block.__(0, {
                                2,
                                hit.contents
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "fromOption - None",
                    (function(param) do
                        return --[[ Eq ]]Block.__(0, {
                                  nil,
                                  Js_undefined.fromOption(nil)
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "fromOption - Some",
                      (function(param) do
                          return --[[ Eq ]]Block.__(0, {
                                    2,
                                    Js_undefined.fromOption(2)
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
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Js_undefined_test", suites);

exports = {};
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
