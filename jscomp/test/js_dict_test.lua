console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Js_dict = require "../../lib/js/js_dict";

function obj(param) do
  return {
          foo = 43,
          bar = 86
        };
end end

suites_000 = --[[ tuple ]]{
  "empty",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                {},
                Object.keys({ })
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "get",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  43,
                  Js_dict.get({
                        foo = 43,
                        bar = 86
                      }, "foo")
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "get - property not in object",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    nil,
                    Js_dict.get({
                          foo = 43,
                          bar = 86
                        }, "baz")
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "unsafe_get",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      43,
                      ({
                            foo = 43,
                            bar = 86
                          })["foo"]
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "set",
          (function(param) do
              o = {
                foo = 43,
                bar = 86
              };
              o["foo"] = 36;
              return --[[ Eq ]]Block.__(0, {
                        36,
                        Js_dict.get(o, "foo")
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "keys",
            (function(param) do
                return --[[ Eq ]]Block.__(0, {
                          {
                            "foo",
                            "bar"
                          },
                          Object.keys({
                                foo = 43,
                                bar = 86
                              })
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "entries",
              (function(param) do
                  return --[[ Eq ]]Block.__(0, {
                            {
                              --[[ tuple ]]{
                                "foo",
                                43
                              },
                              --[[ tuple ]]{
                                "bar",
                                86
                              }
                            },
                            Js_dict.entries({
                                  foo = 43,
                                  bar = 86
                                })
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "values",
                (function(param) do
                    return --[[ Eq ]]Block.__(0, {
                              {
                                43,
                                86
                              },
                              Js_dict.values({
                                    foo = 43,
                                    bar = 86
                                  })
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "fromList - []",
                  (function(param) do
                      return --[[ Eq ]]Block.__(0, {
                                { },
                                Js_dict.fromList(--[[ [] ]]0)
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "fromList",
                    (function(param) do
                        return --[[ Eq ]]Block.__(0, {
                                  {
                                    --[[ tuple ]]{
                                      "x",
                                      23
                                    },
                                    --[[ tuple ]]{
                                      "y",
                                      46
                                    }
                                  },
                                  Js_dict.entries(Js_dict.fromList(--[[ :: ]]{
                                            --[[ tuple ]]{
                                              "x",
                                              23
                                            },
                                            --[[ :: ]]{
                                              --[[ tuple ]]{
                                                "y",
                                                46
                                              },
                                              --[[ [] ]]0
                                            }
                                          }))
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "fromArray - []",
                      (function(param) do
                          return --[[ Eq ]]Block.__(0, {
                                    { },
                                    Js_dict.fromArray({})
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "fromArray",
                        (function(param) do
                            return --[[ Eq ]]Block.__(0, {
                                      {
                                        --[[ tuple ]]{
                                          "x",
                                          23
                                        },
                                        --[[ tuple ]]{
                                          "y",
                                          46
                                        }
                                      },
                                      Js_dict.entries(Js_dict.fromArray({
                                                --[[ tuple ]]{
                                                  "x",
                                                  23
                                                },
                                                --[[ tuple ]]{
                                                  "y",
                                                  46
                                                }
                                              }))
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "map",
                          (function(param) do
                              return --[[ Eq ]]Block.__(0, {
                                        {
                                          foo = "43",
                                          bar = "86"
                                        },
                                        Js_dict.map((function(i) do
                                                return String(i);
                                              end end), {
                                              foo = 43,
                                              bar = 86
                                            })
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
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Js_dict_test", suites);

exports = {}
exports.obj = obj;
exports.suites = suites;
--[[  Not a pure module ]]
