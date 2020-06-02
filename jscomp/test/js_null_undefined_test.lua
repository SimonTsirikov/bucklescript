--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_option = require "../../lib/js/caml_option.lua";
Js_null_undefined = require "../../lib/js/js_null_undefined.lua";

suites_000 = --[[ tuple ]]{
  "toOption - null",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                undefined,
                undefined
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "toOption - undefined",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  undefined,
                  undefined
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "toOption - empty",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    undefined,
                    undefined
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "toOption - 'a",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      "foo",
                      Caml_option.nullable_to_opt("foo")
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "return",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        "something",
                        Caml_option.nullable_to_opt("something")
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "test - null",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          true,
                          true
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "test - undefined",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            true,
                            true
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "test - empty",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              true,
                              true
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "test - 'a",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                false,
                                false
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "bind - null",
                    (function (param) do
                        return --[[ StrictEq ]]Block.__(2, {
                                  null,
                                  Js_null_undefined.bind(null, (function (v) do
                                          return v;
                                        end end))
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "bind - undefined",
                      (function (param) do
                          return --[[ StrictEq ]]Block.__(2, {
                                    undefined,
                                    Js_null_undefined.bind(undefined, (function (v) do
                                            return v;
                                          end end))
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "bind - empty",
                        (function (param) do
                            return --[[ StrictEq ]]Block.__(2, {
                                      undefined,
                                      Js_null_undefined.bind(undefined, (function (v) do
                                              return v;
                                            end end))
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "bind - 'a",
                          (function (param) do
                              return --[[ Eq ]]Block.__(0, {
                                        4,
                                        Js_null_undefined.bind(2, (function (n) do
                                                return (n << 1);
                                              end end))
                                      });
                            end end)
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "iter - null",
                            (function (param) do
                                hit = do
                                  contents: false
                                end;
                                Js_null_undefined.iter(null, (function (param) do
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
                              "iter - undefined",
                              (function (param) do
                                  hit = do
                                    contents: false
                                  end;
                                  Js_null_undefined.iter(undefined, (function (param) do
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
                                "iter - empty",
                                (function (param) do
                                    hit = do
                                      contents: false
                                    end;
                                    Js_null_undefined.iter(undefined, (function (param) do
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
                                  (function (param) do
                                      hit = do
                                        contents: 0
                                      end;
                                      Js_null_undefined.iter(2, (function (v) do
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
                                    (function (param) do
                                        return --[[ Eq ]]Block.__(0, {
                                                  undefined,
                                                  Js_null_undefined.fromOption(undefined)
                                                });
                                      end end)
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "fromOption - Some",
                                      (function (param) do
                                          return --[[ Eq ]]Block.__(0, {
                                                    2,
                                                    Js_null_undefined.fromOption(2)
                                                  });
                                        end end)
                                    },
                                    --[[ :: ]]{
                                      --[[ tuple ]]{
                                        "null <> undefined",
                                        (function (param) do
                                            return --[[ Ok ]]Block.__(4, {true});
                                          end end)
                                      },
                                      --[[ :: ]]{
                                        --[[ tuple ]]{
                                          "null <> empty",
                                          (function (param) do
                                              return --[[ Ok ]]Block.__(4, {true});
                                            end end)
                                        },
                                        --[[ :: ]]{
                                          --[[ tuple ]]{
                                            "undefined = empty",
                                            (function (param) do
                                                return --[[ Ok ]]Block.__(4, {true});
                                              end end)
                                          },
                                          --[[ :: ]]{
                                            --[[ tuple ]]{
                                              "File \"js_null_undefined_test.ml\", line 42, characters 2-9",
                                              (function (param) do
                                                  return --[[ Ok ]]Block.__(4, {true});
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

Mt.from_pair_suites("Js_null_undefined_test", suites);

exports.suites = suites;
--[[  Not a pure module ]]
