__console = {log = print};

Mt = require "..mt";
__Array = require "......lib.js.array";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";

function mkI8(a) do
  return new __Int8Array(a);
end end

function via(make, f, arr) do
  return __Array.from(Curry._1(f, Curry._1(make, arr)));
end end

function viaInt8(f, arr) do
  return (function(param, param_1) do
      return __Array.from(Curry._1(param, new __Int8Array(param_1)));
    end end);
end end

x = new __Int8Array({
      1,
      2,
      3
    });

suites_000 = --[[ tuple ]]{
  "array_buffer - make",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                5,
                new __ArrayBuffer(5).byteLength
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "array_buffer - byteLength",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  5,
                  new __ArrayBuffer(5).byteLength
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "array_buffer - slice",
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    2,
                    new __ArrayBuffer(5).slice(2, 4).byteLength
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "array_buffer - sliceFrom",
        (function(param) do
            return --[[ Eq ]]Block.__(0, {
                      3,
                      new __ArrayBuffer(5).slice(2).byteLength
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "typed_array - unsafe_get",
          (function(param) do
              return --[[ Eq ]]Block.__(0, {
                        4,
                        new __Int8Array({
                                1,
                                2,
                                3,
                                4,
                                5
                              })[3]
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "typed_array - unsafe_set",
            (function(param) do
                a = new __Int8Array({
                      1,
                      2,
                      3,
                      4,
                      5
                    });
                a[3] = 14;
                return --[[ Eq ]]Block.__(0, {
                          14,
                          a[3]
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "typed_array - buffer",
              (function(param) do
                  return --[[ Eq ]]Block.__(0, {
                            new __Int8Array({
                                  3,
                                  4,
                                  5
                                }),
                            new __Int8Array(new __Int8Array({
                                      1,
                                      2,
                                      3,
                                      4,
                                      5
                                    }).buffer, 2)
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "typed_array - byteLength",
                (function(param) do
                    return --[[ Eq ]]Block.__(0, {
                              10,
                              new __Int16Array({
                                    1,
                                    2,
                                    3,
                                    4,
                                    5
                                  }).byteLength
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "typed_array - byteOffset",
                  (function(param) do
                      return --[[ Eq ]]Block.__(0, {
                                0,
                                new __Int8Array({
                                      1,
                                      2,
                                      3,
                                      4,
                                      5
                                    }).byteOffset
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "typed_array - setArray",
                    (function(param) do
                        f = function(a) do
                          a.set({
                                9,
                                8,
                                7
                              });
                          return a;
                        end end;
                        return --[[ Eq ]]Block.__(0, {
                                  new __Int8Array({
                                        9,
                                        8,
                                        7,
                                        4,
                                        5
                                      }),
                                  f(new __Int8Array({
                                            1,
                                            2,
                                            3,
                                            4,
                                            5
                                          }))
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "typed_array - setArrayOffset",
                      (function(param) do
                          f = function(a) do
                            a.set({
                                  9,
                                  8,
                                  7
                                }, 2);
                            return a;
                          end end;
                          return --[[ Eq ]]Block.__(0, {
                                    new __Int8Array({
                                          1,
                                          2,
                                          9,
                                          8,
                                          7
                                        }),
                                    f(new __Int8Array({
                                              1,
                                              2,
                                              3,
                                              4,
                                              5
                                            }))
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "typed_array - length",
                        (function(param) do
                            return --[[ Eq ]]Block.__(0, {
                                      5,
                                      new __Int8Array({
                                            1,
                                            2,
                                            3,
                                            4,
                                            5
                                          }).length
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "typed_array - copyWithin",
                          (function(param) do
                              return --[[ Eq ]]Block.__(0, {
                                        new __Int8Array({
                                              1,
                                              2,
                                              3,
                                              1,
                                              2
                                            }),
                                        new __Int8Array({
                                                1,
                                                2,
                                                3,
                                                4,
                                                5
                                              }).copyWithin(-2)
                                      });
                            end end)
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "typed_array - copyWithinFrom",
                            (function(param) do
                                return --[[ Eq ]]Block.__(0, {
                                          new __Int8Array({
                                                4,
                                                5,
                                                3,
                                                4,
                                                5
                                              }),
                                          new __Int8Array({
                                                  1,
                                                  2,
                                                  3,
                                                  4,
                                                  5
                                                }).copyWithin(0, 3)
                                        });
                              end end)
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "typed_array - copyWithinFromRange",
                              (function(param) do
                                  return --[[ Eq ]]Block.__(0, {
                                            new __Int8Array({
                                                  4,
                                                  2,
                                                  3,
                                                  4,
                                                  5
                                                }),
                                            new __Int8Array({
                                                    1,
                                                    2,
                                                    3,
                                                    4,
                                                    5
                                                  }).copyWithin(0, 3, 4)
                                          });
                                end end)
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "typed_array - fillInPlace",
                                (function(param) do
                                    return --[[ Eq ]]Block.__(0, {
                                              new __Int8Array({
                                                    4,
                                                    4,
                                                    4
                                                  }),
                                              new __Int8Array({
                                                      1,
                                                      2,
                                                      3
                                                    }).fill(4)
                                            });
                                  end end)
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "typed_array - fillFromInPlace",
                                  (function(param) do
                                      return --[[ Eq ]]Block.__(0, {
                                                new __Int8Array({
                                                      1,
                                                      4,
                                                      4
                                                    }),
                                                new __Int8Array({
                                                        1,
                                                        2,
                                                        3
                                                      }).fill(4, 1)
                                              });
                                    end end)
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    "typed_array - fillRangeInPlace",
                                    (function(param) do
                                        return --[[ Eq ]]Block.__(0, {
                                                  new __Int8Array({
                                                        1,
                                                        4,
                                                        3
                                                      }),
                                                  new __Int8Array({
                                                          1,
                                                          2,
                                                          3
                                                        }).fill(4, 1, 2)
                                                });
                                      end end)
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "typed_array - reverseInPlace",
                                      (function(param) do
                                          return --[[ Eq ]]Block.__(0, {
                                                    new __Int8Array({
                                                          3,
                                                          2,
                                                          1
                                                        }),
                                                    new __Int8Array({
                                                            1,
                                                            2,
                                                            3
                                                          }).reverse()
                                                  });
                                        end end)
                                    },
                                    --[[ :: ]]{
                                      --[[ tuple ]]{
                                        "typed_array - sortInPlace",
                                        (function(param) do
                                            return --[[ Eq ]]Block.__(0, {
                                                      new __Int8Array({
                                                            1,
                                                            2,
                                                            3
                                                          }),
                                                      new __Int8Array({
                                                              3,
                                                              1,
                                                              2
                                                            }).sort()
                                                    });
                                          end end)
                                      },
                                      --[[ :: ]]{
                                        --[[ tuple ]]{
                                          "typed_array - sortInPlaceWith",
                                          (function(param) do
                                              return --[[ Eq ]]Block.__(0, {
                                                        new __Int8Array({
                                                              3,
                                                              2,
                                                              1
                                                            }),
                                                        new __Int8Array({
                                                                3,
                                                                1,
                                                                2
                                                              }).sort((function(a, b) do
                                                                return b - a | 0;
                                                              end end))
                                                      });
                                            end end)
                                        },
                                        --[[ :: ]]{
                                          --[[ tuple ]]{
                                            "typed_array - includes",
                                            (function(param) do
                                                return --[[ Eq ]]Block.__(0, {
                                                          true,
                                                          new __Int8Array({
                                                                  1,
                                                                  2,
                                                                  3
                                                                }).includes(3)
                                                        });
                                              end end)
                                          },
                                          --[[ :: ]]{
                                            --[[ tuple ]]{
                                              "typed_array - indexOf",
                                              (function(param) do
                                                  return --[[ Eq ]]Block.__(0, {
                                                            1,
                                                            new __Int8Array({
                                                                    1,
                                                                    2,
                                                                    3
                                                                  }).indexOf(2)
                                                          });
                                                end end)
                                            },
                                            --[[ :: ]]{
                                              --[[ tuple ]]{
                                                "typed_array - indexOfFrom",
                                                (function(param) do
                                                    return --[[ Eq ]]Block.__(0, {
                                                              3,
                                                              new __Int8Array({
                                                                      1,
                                                                      2,
                                                                      3,
                                                                      2
                                                                    }).indexOf(2, 2)
                                                            });
                                                  end end)
                                              },
                                              --[[ :: ]]{
                                                --[[ tuple ]]{
                                                  "typed_array - join",
                                                  (function(param) do
                                                      return --[[ Eq ]]Block.__(0, {
                                                                "1,2,3",
                                                                new __Int8Array({
                                                                        1,
                                                                        2,
                                                                        3
                                                                      }).join()
                                                              });
                                                    end end)
                                                },
                                                --[[ :: ]]{
                                                  --[[ tuple ]]{
                                                    "typed_array - joinWith",
                                                    (function(param) do
                                                        return --[[ Eq ]]Block.__(0, {
                                                                  "1;2;3",
                                                                  new __Int8Array({
                                                                          1,
                                                                          2,
                                                                          3
                                                                        }).join(";")
                                                                });
                                                      end end)
                                                  },
                                                  --[[ :: ]]{
                                                    --[[ tuple ]]{
                                                      "typed_array - lastIndexOf",
                                                      (function(param) do
                                                          return --[[ Eq ]]Block.__(0, {
                                                                    1,
                                                                    new __Int8Array({
                                                                            1,
                                                                            2,
                                                                            3
                                                                          }).lastIndexOf(2)
                                                                  });
                                                        end end)
                                                    },
                                                    --[[ :: ]]{
                                                      --[[ tuple ]]{
                                                        "typed_array - lastIndexOfFrom",
                                                        (function(param) do
                                                            return --[[ Eq ]]Block.__(0, {
                                                                      1,
                                                                      new __Int8Array({
                                                                              1,
                                                                              2,
                                                                              3,
                                                                              2
                                                                            }).lastIndexOf(2, 2)
                                                                    });
                                                          end end)
                                                      },
                                                      --[[ :: ]]{
                                                        --[[ tuple ]]{
                                                          "typed_array - slice",
                                                          (function(param) do
                                                              return --[[ Eq ]]Block.__(0, {
                                                                        new __Int8Array({
                                                                              2,
                                                                              3
                                                                            }),
                                                                        new __Int8Array({
                                                                                1,
                                                                                2,
                                                                                3,
                                                                                4,
                                                                                5
                                                                              }).slice(1, 3)
                                                                      });
                                                            end end)
                                                        },
                                                        --[[ :: ]]{
                                                          --[[ tuple ]]{
                                                            "typed_array - copy",
                                                            (function(param) do
                                                                return --[[ Eq ]]Block.__(0, {
                                                                          new __Int8Array({
                                                                                1,
                                                                                2,
                                                                                3,
                                                                                4,
                                                                                5
                                                                              }),
                                                                          new __Int8Array({
                                                                                  1,
                                                                                  2,
                                                                                  3,
                                                                                  4,
                                                                                  5
                                                                                }).slice()
                                                                        });
                                                              end end)
                                                          },
                                                          --[[ :: ]]{
                                                            --[[ tuple ]]{
                                                              "typed_array - sliceFrom",
                                                              (function(param) do
                                                                  return --[[ Eq ]]Block.__(0, {
                                                                            new __Int8Array({
                                                                                  3,
                                                                                  4,
                                                                                  5
                                                                                }),
                                                                            new __Int8Array({
                                                                                    1,
                                                                                    2,
                                                                                    3,
                                                                                    4,
                                                                                    5
                                                                                  }).slice(2)
                                                                          });
                                                                end end)
                                                            },
                                                            --[[ :: ]]{
                                                              --[[ tuple ]]{
                                                                "typed_array - subarray",
                                                                (function(param) do
                                                                    return --[[ Eq ]]Block.__(0, {
                                                                              new __Int8Array({
                                                                                    2,
                                                                                    3
                                                                                  }),
                                                                              new __Int8Array({
                                                                                      1,
                                                                                      2,
                                                                                      3,
                                                                                      4,
                                                                                      5
                                                                                    }).subarray(1, 3)
                                                                            });
                                                                  end end)
                                                              },
                                                              --[[ :: ]]{
                                                                --[[ tuple ]]{
                                                                  "typed_array - subarrayFrom",
                                                                  (function(param) do
                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                new __Int8Array({
                                                                                      3,
                                                                                      4,
                                                                                      5
                                                                                    }),
                                                                                new __Int8Array({
                                                                                        1,
                                                                                        2,
                                                                                        3,
                                                                                        4,
                                                                                        5
                                                                                      }).subarray(2)
                                                                              });
                                                                    end end)
                                                                },
                                                                --[[ :: ]]{
                                                                  --[[ tuple ]]{
                                                                    "typed_array - toString",
                                                                    (function(param) do
                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                  "1,2,3",
                                                                                  new __Int8Array({
                                                                                          1,
                                                                                          2,
                                                                                          3
                                                                                        }).toString()
                                                                                });
                                                                      end end)
                                                                  },
                                                                  --[[ :: ]]{
                                                                    --[[ tuple ]]{
                                                                      "typed_array - toLocaleString",
                                                                      (function(param) do
                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                    "1,2,3",
                                                                                    new __Int8Array({
                                                                                            1,
                                                                                            2,
                                                                                            3
                                                                                          }).toLocaleString()
                                                                                  });
                                                                        end end)
                                                                    },
                                                                    --[[ :: ]]{
                                                                      --[[ tuple ]]{
                                                                        "typed_array - every",
                                                                        (function(param) do
                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                      true,
                                                                                      new __Int8Array({
                                                                                              1,
                                                                                              2,
                                                                                              3
                                                                                            }).every((function(n) do
                                                                                              return n > 0;
                                                                                            end end))
                                                                                    });
                                                                          end end)
                                                                      },
                                                                      --[[ :: ]]{
                                                                        --[[ tuple ]]{
                                                                          "typed_array - everyi",
                                                                          (function(param) do
                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                        false,
                                                                                        new __Int8Array({
                                                                                                1,
                                                                                                2,
                                                                                                3
                                                                                              }).every((function(param, i) do
                                                                                                return i > 0;
                                                                                              end end))
                                                                                      });
                                                                            end end)
                                                                        },
                                                                        --[[ :: ]]{
                                                                          --[[ tuple ]]{
                                                                            "typed_array - filter",
                                                                            (function(param) do
                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                          new __Int8Array({
                                                                                                2,
                                                                                                4
                                                                                              }),
                                                                                          new __Int8Array({
                                                                                                  1,
                                                                                                  2,
                                                                                                  3,
                                                                                                  4
                                                                                                }).filter((function(n) do
                                                                                                  return n % 2 == 0;
                                                                                                end end))
                                                                                        });
                                                                              end end)
                                                                          },
                                                                          --[[ :: ]]{
                                                                            --[[ tuple ]]{
                                                                              "typed_array - filteri",
                                                                              (function(param) do
                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                            new __Int8Array({
                                                                                                  1,
                                                                                                  3
                                                                                                }),
                                                                                            new __Int8Array({
                                                                                                    1,
                                                                                                    2,
                                                                                                    3,
                                                                                                    4
                                                                                                  }).filter((function(param, i) do
                                                                                                    return i % 2 == 0;
                                                                                                  end end))
                                                                                          });
                                                                                end end)
                                                                            },
                                                                            --[[ :: ]]{
                                                                              --[[ tuple ]]{
                                                                                "typed_array - find",
                                                                                (function(param) do
                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                              2,
                                                                                              new __Int8Array({
                                                                                                      1,
                                                                                                      2,
                                                                                                      3,
                                                                                                      4
                                                                                                    }).find((function(n) do
                                                                                                      return n % 2 == 0;
                                                                                                    end end))
                                                                                            });
                                                                                  end end)
                                                                              },
                                                                              --[[ :: ]]{
                                                                                --[[ tuple ]]{
                                                                                  "typed_array - findi",
                                                                                  (function(param) do
                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                1,
                                                                                                new __Int8Array({
                                                                                                        1,
                                                                                                        2,
                                                                                                        3,
                                                                                                        4
                                                                                                      }).find((function(param, i) do
                                                                                                        return i % 2 == 0;
                                                                                                      end end))
                                                                                              });
                                                                                    end end)
                                                                                },
                                                                                --[[ :: ]]{
                                                                                  --[[ tuple ]]{
                                                                                    "typed_array - findIndex",
                                                                                    (function(param) do
                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                  1,
                                                                                                  new __Int8Array({
                                                                                                          1,
                                                                                                          2,
                                                                                                          3,
                                                                                                          4
                                                                                                        }).findIndex((function(n) do
                                                                                                          return n % 2 == 0;
                                                                                                        end end))
                                                                                                });
                                                                                      end end)
                                                                                  },
                                                                                  --[[ :: ]]{
                                                                                    --[[ tuple ]]{
                                                                                      "typed_array - findIndexi",
                                                                                      (function(param) do
                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                    0,
                                                                                                    new __Int8Array({
                                                                                                            1,
                                                                                                            2,
                                                                                                            3,
                                                                                                            4
                                                                                                          }).findIndex((function(param, i) do
                                                                                                            return i % 2 == 0;
                                                                                                          end end))
                                                                                                  });
                                                                                        end end)
                                                                                    },
                                                                                    --[[ :: ]]{
                                                                                      --[[ tuple ]]{
                                                                                        "typed_array - forEach",
                                                                                        (function(param) do
                                                                                            sum = {
                                                                                              contents = 0
                                                                                            };
                                                                                            new __Int8Array({
                                                                                                    1,
                                                                                                    2,
                                                                                                    3
                                                                                                  }).forEach((function(n) do
                                                                                                    sum.contents = sum.contents + n | 0;
                                                                                                    return --[[ () ]]0;
                                                                                                  end end));
                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                      6,
                                                                                                      sum.contents
                                                                                                    });
                                                                                          end end)
                                                                                      },
                                                                                      --[[ :: ]]{
                                                                                        --[[ tuple ]]{
                                                                                          "typed_array - forEachi",
                                                                                          (function(param) do
                                                                                              sum = {
                                                                                                contents = 0
                                                                                              };
                                                                                              new __Int8Array({
                                                                                                      1,
                                                                                                      2,
                                                                                                      3
                                                                                                    }).forEach((function(param, i) do
                                                                                                      sum.contents = sum.contents + i | 0;
                                                                                                      return --[[ () ]]0;
                                                                                                    end end));
                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                        3,
                                                                                                        sum.contents
                                                                                                      });
                                                                                            end end)
                                                                                        },
                                                                                        --[[ :: ]]{
                                                                                          --[[ tuple ]]{
                                                                                            "typed_array - map",
                                                                                            (function(param) do
                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                          new __Int8Array({
                                                                                                                2,
                                                                                                                4,
                                                                                                                6,
                                                                                                                8
                                                                                                              }),
                                                                                                          new __Int8Array({
                                                                                                                  1,
                                                                                                                  2,
                                                                                                                  3,
                                                                                                                  4
                                                                                                                }).map((function(n) do
                                                                                                                  return (n << 1);
                                                                                                                end end))
                                                                                                        });
                                                                                              end end)
                                                                                          },
                                                                                          --[[ :: ]]{
                                                                                            --[[ tuple ]]{
                                                                                              "typed_array - map",
                                                                                              (function(param) do
                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                            new __Int8Array({
                                                                                                                  0,
                                                                                                                  2,
                                                                                                                  4,
                                                                                                                  6
                                                                                                                }),
                                                                                                            new __Int8Array({
                                                                                                                    1,
                                                                                                                    2,
                                                                                                                    3,
                                                                                                                    4
                                                                                                                  }).map((function(param, i) do
                                                                                                                    return (i << 1);
                                                                                                                  end end))
                                                                                                          });
                                                                                                end end)
                                                                                            },
                                                                                            --[[ :: ]]{
                                                                                              --[[ tuple ]]{
                                                                                                "typed_array - reduce",
                                                                                                (function(param) do
                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                              -10,
                                                                                                              new __Int8Array({
                                                                                                                      1,
                                                                                                                      2,
                                                                                                                      3,
                                                                                                                      4
                                                                                                                    }).reduce((function(acc, n) do
                                                                                                                      return acc - n | 0;
                                                                                                                    end end), 0)
                                                                                                            });
                                                                                                  end end)
                                                                                              },
                                                                                              --[[ :: ]]{
                                                                                                --[[ tuple ]]{
                                                                                                  "typed_array - reducei",
                                                                                                  (function(param) do
                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                -6,
                                                                                                                new __Int8Array({
                                                                                                                        1,
                                                                                                                        2,
                                                                                                                        3,
                                                                                                                        4
                                                                                                                      }).reduce((function(acc, param, i) do
                                                                                                                        return acc - i | 0;
                                                                                                                      end end), 0)
                                                                                                              });
                                                                                                    end end)
                                                                                                },
                                                                                                --[[ :: ]]{
                                                                                                  --[[ tuple ]]{
                                                                                                    "typed_array - reduceRight",
                                                                                                    (function(param) do
                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                  -10,
                                                                                                                  new __Int8Array({
                                                                                                                          1,
                                                                                                                          2,
                                                                                                                          3,
                                                                                                                          4
                                                                                                                        }).reduceRight((function(acc, n) do
                                                                                                                          return acc - n | 0;
                                                                                                                        end end), 0)
                                                                                                                });
                                                                                                      end end)
                                                                                                  },
                                                                                                  --[[ :: ]]{
                                                                                                    --[[ tuple ]]{
                                                                                                      "typed_array - reduceRighti",
                                                                                                      (function(param) do
                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                    -6,
                                                                                                                    new __Int8Array({
                                                                                                                            1,
                                                                                                                            2,
                                                                                                                            3,
                                                                                                                            4
                                                                                                                          }).reduceRight((function(acc, param, i) do
                                                                                                                            return acc - i | 0;
                                                                                                                          end end), 0)
                                                                                                                  });
                                                                                                        end end)
                                                                                                    },
                                                                                                    --[[ :: ]]{
                                                                                                      --[[ tuple ]]{
                                                                                                        "typed_array - some",
                                                                                                        (function(param) do
                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                      false,
                                                                                                                      new __Int8Array({
                                                                                                                              1,
                                                                                                                              2,
                                                                                                                              3,
                                                                                                                              4
                                                                                                                            }).some((function(n) do
                                                                                                                              return n <= 0;
                                                                                                                            end end))
                                                                                                                    });
                                                                                                          end end)
                                                                                                      },
                                                                                                      --[[ :: ]]{
                                                                                                        --[[ tuple ]]{
                                                                                                          "typed_array - somei",
                                                                                                          (function(param) do
                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                        true,
                                                                                                                        new __Int8Array({
                                                                                                                                1,
                                                                                                                                2,
                                                                                                                                3,
                                                                                                                                4
                                                                                                                              }).some((function(param, i) do
                                                                                                                                return i <= 0;
                                                                                                                              end end))
                                                                                                                      });
                                                                                                            end end)
                                                                                                        },
                                                                                                        --[[ :: ]]{
                                                                                                          --[[ tuple ]]{
                                                                                                            "int8_array - _BYTES_PER_ELEMENT",
                                                                                                            (function(param) do
                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                          1,
                                                                                                                          __Int8Array.BYTES_PER_ELEMENT
                                                                                                                        });
                                                                                                              end end)
                                                                                                          },
                                                                                                          --[[ :: ]]{
                                                                                                            --[[ tuple ]]{
                                                                                                              "int8_array - make",
                                                                                                              (function(param) do
                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                            3,
                                                                                                                            new __Int8Array({
                                                                                                                                  1,
                                                                                                                                  2,
                                                                                                                                  3
                                                                                                                                }).byteLength
                                                                                                                          });
                                                                                                                end end)
                                                                                                            },
                                                                                                            --[[ :: ]]{
                                                                                                              --[[ tuple ]]{
                                                                                                                "int8_array - fromBuffer",
                                                                                                                (function(param) do
                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                              32,
                                                                                                                              new __Int8Array(new __ArrayBuffer(32)).byteLength
                                                                                                                            });
                                                                                                                  end end)
                                                                                                              },
                                                                                                              --[[ :: ]]{
                                                                                                                --[[ tuple ]]{
                                                                                                                  "int8_array - fromBufferOffset",
                                                                                                                  (function(param) do
                                                                                                                      buffer = new __ArrayBuffer(32);
                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                24,
                                                                                                                                new __Int8Array(buffer, 8).byteLength
                                                                                                                              });
                                                                                                                    end end)
                                                                                                                },
                                                                                                                --[[ :: ]]{
                                                                                                                  --[[ tuple ]]{
                                                                                                                    "int8_array - fromBufferRange",
                                                                                                                    (function(param) do
                                                                                                                        buffer = new __ArrayBuffer(32);
                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                  2,
                                                                                                                                  new __Int8Array(buffer, 8, 2).byteLength
                                                                                                                                });
                                                                                                                      end end)
                                                                                                                  },
                                                                                                                  --[[ :: ]]{
                                                                                                                    --[[ tuple ]]{
                                                                                                                      "int8_array - fromLength",
                                                                                                                      (function(param) do
                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                    3,
                                                                                                                                    new __Int8Array(3).byteLength
                                                                                                                                  });
                                                                                                                        end end)
                                                                                                                    },
                                                                                                                    --[[ :: ]]{
                                                                                                                      --[[ tuple ]]{
                                                                                                                        "int8_array - unsafe_set - typed_array sanity check",
                                                                                                                        (function(param) do
                                                                                                                            a = new __Int8Array({
                                                                                                                                  1,
                                                                                                                                  2,
                                                                                                                                  3,
                                                                                                                                  4,
                                                                                                                                  5
                                                                                                                                });
                                                                                                                            a[3] = 14;
                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                      14,
                                                                                                                                      a[3]
                                                                                                                                    });
                                                                                                                          end end)
                                                                                                                      },
                                                                                                                      --[[ :: ]]{
                                                                                                                        --[[ tuple ]]{
                                                                                                                          "uint8_array - _BYTES_PER_ELEMENT",
                                                                                                                          (function(param) do
                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                        1,
                                                                                                                                        __Uint8Array.BYTES_PER_ELEMENT
                                                                                                                                      });
                                                                                                                            end end)
                                                                                                                        },
                                                                                                                        --[[ :: ]]{
                                                                                                                          --[[ tuple ]]{
                                                                                                                            "uint8_array - make",
                                                                                                                            (function(param) do
                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                          3,
                                                                                                                                          new __Uint8Array({
                                                                                                                                                1,
                                                                                                                                                2,
                                                                                                                                                3
                                                                                                                                              }).byteLength
                                                                                                                                        });
                                                                                                                              end end)
                                                                                                                          },
                                                                                                                          --[[ :: ]]{
                                                                                                                            --[[ tuple ]]{
                                                                                                                              "uint8_array - fromBuffer",
                                                                                                                              (function(param) do
                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                            32,
                                                                                                                                            new __Uint8Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                          });
                                                                                                                                end end)
                                                                                                                            },
                                                                                                                            --[[ :: ]]{
                                                                                                                              --[[ tuple ]]{
                                                                                                                                "uint8_array - fromBufferOffset",
                                                                                                                                (function(param) do
                                                                                                                                    buffer = new __ArrayBuffer(32);
                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                              24,
                                                                                                                                              new __Uint8Array(buffer, 8).byteLength
                                                                                                                                            });
                                                                                                                                  end end)
                                                                                                                              },
                                                                                                                              --[[ :: ]]{
                                                                                                                                --[[ tuple ]]{
                                                                                                                                  "uint8_array - fromBufferRange",
                                                                                                                                  (function(param) do
                                                                                                                                      buffer = new __ArrayBuffer(32);
                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                2,
                                                                                                                                                new __Uint8Array(buffer, 8, 2).byteLength
                                                                                                                                              });
                                                                                                                                    end end)
                                                                                                                                },
                                                                                                                                --[[ :: ]]{
                                                                                                                                  --[[ tuple ]]{
                                                                                                                                    "uint8_array - fromLength",
                                                                                                                                    (function(param) do
                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                  3,
                                                                                                                                                  new __Uint8Array(3).byteLength
                                                                                                                                                });
                                                                                                                                      end end)
                                                                                                                                  },
                                                                                                                                  --[[ :: ]]{
                                                                                                                                    --[[ tuple ]]{
                                                                                                                                      "uint8_array - unsafe_set - typed_array sanity check",
                                                                                                                                      (function(param) do
                                                                                                                                          a = new __Uint8Array({
                                                                                                                                                1,
                                                                                                                                                2,
                                                                                                                                                3,
                                                                                                                                                4,
                                                                                                                                                5
                                                                                                                                              });
                                                                                                                                          a[3] = 14;
                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                    14,
                                                                                                                                                    a[3]
                                                                                                                                                  });
                                                                                                                                        end end)
                                                                                                                                    },
                                                                                                                                    --[[ :: ]]{
                                                                                                                                      --[[ tuple ]]{
                                                                                                                                        "uint8clamped_array - _BYTES_PER_ELEMENT",
                                                                                                                                        (function(param) do
                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                      1,
                                                                                                                                                      __Uint8ClampedArray.BYTES_PER_ELEMENT
                                                                                                                                                    });
                                                                                                                                          end end)
                                                                                                                                      },
                                                                                                                                      --[[ :: ]]{
                                                                                                                                        --[[ tuple ]]{
                                                                                                                                          "uint8clamped_array - make",
                                                                                                                                          (function(param) do
                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                        3,
                                                                                                                                                        new __Uint8ClampedArray({
                                                                                                                                                              1,
                                                                                                                                                              2,
                                                                                                                                                              3
                                                                                                                                                            }).byteLength
                                                                                                                                                      });
                                                                                                                                            end end)
                                                                                                                                        },
                                                                                                                                        --[[ :: ]]{
                                                                                                                                          --[[ tuple ]]{
                                                                                                                                            "uint8clamped_array - fromBuffer",
                                                                                                                                            (function(param) do
                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                          32,
                                                                                                                                                          new __Uint8ClampedArray(new __ArrayBuffer(32)).byteLength
                                                                                                                                                        });
                                                                                                                                              end end)
                                                                                                                                          },
                                                                                                                                          --[[ :: ]]{
                                                                                                                                            --[[ tuple ]]{
                                                                                                                                              "uint8clamped_array - fromBufferOffset",
                                                                                                                                              (function(param) do
                                                                                                                                                  buffer = new __ArrayBuffer(32);
                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                            24,
                                                                                                                                                            new __Uint8ClampedArray(buffer, 8).byteLength
                                                                                                                                                          });
                                                                                                                                                end end)
                                                                                                                                            },
                                                                                                                                            --[[ :: ]]{
                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                "uint8clamped_array - fromBufferRange",
                                                                                                                                                (function(param) do
                                                                                                                                                    buffer = new __ArrayBuffer(32);
                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                              2,
                                                                                                                                                              new __Uint8ClampedArray(buffer, 8, 2).byteLength
                                                                                                                                                            });
                                                                                                                                                  end end)
                                                                                                                                              },
                                                                                                                                              --[[ :: ]]{
                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                  "uint8clamped_array - fromLength",
                                                                                                                                                  (function(param) do
                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                3,
                                                                                                                                                                new __Uint8ClampedArray(3).byteLength
                                                                                                                                                              });
                                                                                                                                                    end end)
                                                                                                                                                },
                                                                                                                                                --[[ :: ]]{
                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                    "uint8clamped_array - unsafe_set - typed_array sanity check",
                                                                                                                                                    (function(param) do
                                                                                                                                                        a = new __Uint8ClampedArray({
                                                                                                                                                              1,
                                                                                                                                                              2,
                                                                                                                                                              3,
                                                                                                                                                              4,
                                                                                                                                                              5
                                                                                                                                                            });
                                                                                                                                                        a[3] = 14;
                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                  14,
                                                                                                                                                                  a[3]
                                                                                                                                                                });
                                                                                                                                                      end end)
                                                                                                                                                  },
                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                      "int16_array - _BYTES_PER_ELEMENT",
                                                                                                                                                      (function(param) do
                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                    2,
                                                                                                                                                                    __Int16Array.BYTES_PER_ELEMENT
                                                                                                                                                                  });
                                                                                                                                                        end end)
                                                                                                                                                    },
                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                        "int16_array - make",
                                                                                                                                                        (function(param) do
                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                      6,
                                                                                                                                                                      new __Int16Array({
                                                                                                                                                                            1,
                                                                                                                                                                            2,
                                                                                                                                                                            3
                                                                                                                                                                          }).byteLength
                                                                                                                                                                    });
                                                                                                                                                          end end)
                                                                                                                                                      },
                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                          "int16_array - fromBuffer",
                                                                                                                                                          (function(param) do
                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                        32,
                                                                                                                                                                        new __Int16Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                      });
                                                                                                                                                            end end)
                                                                                                                                                        },
                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                            "int16_array - fromBufferOffset",
                                                                                                                                                            (function(param) do
                                                                                                                                                                buffer = new __ArrayBuffer(32);
                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                          24,
                                                                                                                                                                          new __Int16Array(buffer, 8).byteLength
                                                                                                                                                                        });
                                                                                                                                                              end end)
                                                                                                                                                          },
                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                              "int16_array - fromBufferRange",
                                                                                                                                                              (function(param) do
                                                                                                                                                                  buffer = new __ArrayBuffer(32);
                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                            4,
                                                                                                                                                                            new __Int16Array(buffer, 8, 2).byteLength
                                                                                                                                                                          });
                                                                                                                                                                end end)
                                                                                                                                                            },
                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                "int16_array - fromLength",
                                                                                                                                                                (function(param) do
                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                              6,
                                                                                                                                                                              new __Int16Array(3).byteLength
                                                                                                                                                                            });
                                                                                                                                                                  end end)
                                                                                                                                                              },
                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                  "int16_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                  (function(param) do
                                                                                                                                                                      a = new __Int16Array({
                                                                                                                                                                            1,
                                                                                                                                                                            2,
                                                                                                                                                                            3,
                                                                                                                                                                            4,
                                                                                                                                                                            5
                                                                                                                                                                          });
                                                                                                                                                                      a[3] = 14;
                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                14,
                                                                                                                                                                                a[3]
                                                                                                                                                                              });
                                                                                                                                                                    end end)
                                                                                                                                                                },
                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                    "uint16_array - _BYTES_PER_ELEMENT",
                                                                                                                                                                    (function(param) do
                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                  2,
                                                                                                                                                                                  __Uint16Array.BYTES_PER_ELEMENT
                                                                                                                                                                                });
                                                                                                                                                                      end end)
                                                                                                                                                                  },
                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                      "uint16_array - make",
                                                                                                                                                                      (function(param) do
                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                    6,
                                                                                                                                                                                    new __Uint16Array({
                                                                                                                                                                                          1,
                                                                                                                                                                                          2,
                                                                                                                                                                                          3
                                                                                                                                                                                        }).byteLength
                                                                                                                                                                                  });
                                                                                                                                                                        end end)
                                                                                                                                                                    },
                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                        "uint16_array - fromBuffer",
                                                                                                                                                                        (function(param) do
                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                      32,
                                                                                                                                                                                      new __Uint16Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                    });
                                                                                                                                                                          end end)
                                                                                                                                                                      },
                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                          "uint16_array - fromBufferOffset",
                                                                                                                                                                          (function(param) do
                                                                                                                                                                              buffer = new __ArrayBuffer(32);
                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                        24,
                                                                                                                                                                                        new __Uint16Array(buffer, 8).byteLength
                                                                                                                                                                                      });
                                                                                                                                                                            end end)
                                                                                                                                                                        },
                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                            "uint16_array - fromBufferRange",
                                                                                                                                                                            (function(param) do
                                                                                                                                                                                buffer = new __ArrayBuffer(32);
                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                          4,
                                                                                                                                                                                          new __Uint16Array(buffer, 8, 2).byteLength
                                                                                                                                                                                        });
                                                                                                                                                                              end end)
                                                                                                                                                                          },
                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                              "uint16_array - fromLength",
                                                                                                                                                                              (function(param) do
                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                            6,
                                                                                                                                                                                            new __Uint16Array(3).byteLength
                                                                                                                                                                                          });
                                                                                                                                                                                end end)
                                                                                                                                                                            },
                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                "uint16_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                                (function(param) do
                                                                                                                                                                                    a = new __Uint16Array({
                                                                                                                                                                                          1,
                                                                                                                                                                                          2,
                                                                                                                                                                                          3,
                                                                                                                                                                                          4,
                                                                                                                                                                                          5
                                                                                                                                                                                        });
                                                                                                                                                                                    a[3] = 14;
                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                              14,
                                                                                                                                                                                              a[3]
                                                                                                                                                                                            });
                                                                                                                                                                                  end end)
                                                                                                                                                                              },
                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                  "int32_array - _BYTES_PER_ELEMENT",
                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                4,
                                                                                                                                                                                                __Int32Array.BYTES_PER_ELEMENT
                                                                                                                                                                                              });
                                                                                                                                                                                    end end)
                                                                                                                                                                                },
                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                    "int32_array - make",
                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                  12,
                                                                                                                                                                                                  new __Int32Array(__Array.map((function(prim) do
                                                                                                                                                                                                              return prim;
                                                                                                                                                                                                            end end), {
                                                                                                                                                                                                            1,
                                                                                                                                                                                                            2,
                                                                                                                                                                                                            3
                                                                                                                                                                                                          })).byteLength
                                                                                                                                                                                                });
                                                                                                                                                                                      end end)
                                                                                                                                                                                  },
                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                      "int32_array - fromBuffer",
                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                    32,
                                                                                                                                                                                                    new __Int32Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                  });
                                                                                                                                                                                        end end)
                                                                                                                                                                                    },
                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                        "int32_array - fromBufferOffset",
                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                            buffer = new __ArrayBuffer(32);
                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                      24,
                                                                                                                                                                                                      new __Int32Array(buffer, 8).byteLength
                                                                                                                                                                                                    });
                                                                                                                                                                                          end end)
                                                                                                                                                                                      },
                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                          "int32_array - fromBufferRange",
                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                              buffer = new __ArrayBuffer(32);
                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                        8,
                                                                                                                                                                                                        new __Int32Array(buffer, 8, 2).byteLength
                                                                                                                                                                                                      });
                                                                                                                                                                                            end end)
                                                                                                                                                                                        },
                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                            "int32_array - fromLength",
                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                          12,
                                                                                                                                                                                                          new __Int32Array(3).byteLength
                                                                                                                                                                                                        });
                                                                                                                                                                                              end end)
                                                                                                                                                                                          },
                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                              "int32_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                  a = new __Int32Array(__Array.map((function(prim) do
                                                                                                                                                                                                              return prim;
                                                                                                                                                                                                            end end), {
                                                                                                                                                                                                            1,
                                                                                                                                                                                                            2,
                                                                                                                                                                                                            3,
                                                                                                                                                                                                            4,
                                                                                                                                                                                                            5
                                                                                                                                                                                                          }));
                                                                                                                                                                                                  a[3] = 14;
                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                            14,
                                                                                                                                                                                                            a[3]
                                                                                                                                                                                                          });
                                                                                                                                                                                                end end)
                                                                                                                                                                                            },
                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                "uint32_array - _BYTES_PER_ELEMENT",
                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                              4,
                                                                                                                                                                                                              __Uint32Array.BYTES_PER_ELEMENT
                                                                                                                                                                                                            });
                                                                                                                                                                                                  end end)
                                                                                                                                                                                              },
                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                  "uint32_array - make",
                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                12,
                                                                                                                                                                                                                new __Uint32Array({
                                                                                                                                                                                                                      1,
                                                                                                                                                                                                                      2,
                                                                                                                                                                                                                      3
                                                                                                                                                                                                                    }).byteLength
                                                                                                                                                                                                              });
                                                                                                                                                                                                    end end)
                                                                                                                                                                                                },
                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                    "uint32_array - fromBuffer",
                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                  32,
                                                                                                                                                                                                                  new __Uint32Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                                });
                                                                                                                                                                                                      end end)
                                                                                                                                                                                                  },
                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                      "uint32_array - fromBufferOffset",
                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                          buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                    24,
                                                                                                                                                                                                                    new __Uint32Array(buffer, 8).byteLength
                                                                                                                                                                                                                  });
                                                                                                                                                                                                        end end)
                                                                                                                                                                                                    },
                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                        "uint32_array - fromBufferRange",
                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                            buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                      8,
                                                                                                                                                                                                                      new __Uint32Array(buffer, 8, 2).byteLength
                                                                                                                                                                                                                    });
                                                                                                                                                                                                          end end)
                                                                                                                                                                                                      },
                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                          "uint32_array - fromLength",
                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                        12,
                                                                                                                                                                                                                        new __Uint32Array(3).byteLength
                                                                                                                                                                                                                      });
                                                                                                                                                                                                            end end)
                                                                                                                                                                                                        },
                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                            "uint32_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                a = new __Uint32Array({
                                                                                                                                                                                                                      1,
                                                                                                                                                                                                                      2,
                                                                                                                                                                                                                      3,
                                                                                                                                                                                                                      4,
                                                                                                                                                                                                                      5
                                                                                                                                                                                                                    });
                                                                                                                                                                                                                a[3] = 14;
                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                          14,
                                                                                                                                                                                                                          a[3]
                                                                                                                                                                                                                        });
                                                                                                                                                                                                              end end)
                                                                                                                                                                                                          },
                                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                                              "float32_array - _BYTES_PER_ELEMENT",
                                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                            4,
                                                                                                                                                                                                                            __Float32Array.BYTES_PER_ELEMENT
                                                                                                                                                                                                                          });
                                                                                                                                                                                                                end end)
                                                                                                                                                                                                            },
                                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                                "float32_array - make",
                                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                              12,
                                                                                                                                                                                                                              new __Float32Array({
                                                                                                                                                                                                                                    1,
                                                                                                                                                                                                                                    2,
                                                                                                                                                                                                                                    3
                                                                                                                                                                                                                                  }).byteLength
                                                                                                                                                                                                                            });
                                                                                                                                                                                                                  end end)
                                                                                                                                                                                                              },
                                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                                  "float32_array - fromBuffer",
                                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                32,
                                                                                                                                                                                                                                new __Float32Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                                              });
                                                                                                                                                                                                                    end end)
                                                                                                                                                                                                                },
                                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                                    "float32_array - fromBufferOffset",
                                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                                        buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                  24,
                                                                                                                                                                                                                                  new __Float32Array(buffer, 8).byteLength
                                                                                                                                                                                                                                });
                                                                                                                                                                                                                      end end)
                                                                                                                                                                                                                  },
                                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                                      "float32_array - fromBufferRange",
                                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                                          buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                    8,
                                                                                                                                                                                                                                    new __Float32Array(buffer, 8, 2).byteLength
                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                        end end)
                                                                                                                                                                                                                    },
                                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                                        "float32_array - fromLength",
                                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                      12,
                                                                                                                                                                                                                                      new __Float32Array(3).byteLength
                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                          end end)
                                                                                                                                                                                                                      },
                                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                                          "float32_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                                              a = new __Float32Array({
                                                                                                                                                                                                                                    1,
                                                                                                                                                                                                                                    2,
                                                                                                                                                                                                                                    3,
                                                                                                                                                                                                                                    4,
                                                                                                                                                                                                                                    5
                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                              a[3] = 14;
                                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                        14,
                                                                                                                                                                                                                                        a[3]
                                                                                                                                                                                                                                      });
                                                                                                                                                                                                                            end end)
                                                                                                                                                                                                                        },
                                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                                            "float64_array - _BYTES_PER_ELEMENT",
                                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                          8,
                                                                                                                                                                                                                                          __Float64Array.BYTES_PER_ELEMENT
                                                                                                                                                                                                                                        });
                                                                                                                                                                                                                              end end)
                                                                                                                                                                                                                          },
                                                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                                                              "float64_array - make",
                                                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                            24,
                                                                                                                                                                                                                                            new __Float64Array({
                                                                                                                                                                                                                                                  1,
                                                                                                                                                                                                                                                  2,
                                                                                                                                                                                                                                                  3
                                                                                                                                                                                                                                                }).byteLength
                                                                                                                                                                                                                                          });
                                                                                                                                                                                                                                end end)
                                                                                                                                                                                                                            },
                                                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                                                "float64_array - fromBuffer",
                                                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                              32,
                                                                                                                                                                                                                                              new __Float64Array(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                  end end)
                                                                                                                                                                                                                              },
                                                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                                                  "float64_array - fromBufferOffset",
                                                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                                                      buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                24,
                                                                                                                                                                                                                                                new __Float64Array(buffer, 8).byteLength
                                                                                                                                                                                                                                              });
                                                                                                                                                                                                                                    end end)
                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                                                    "float64_array - fromBufferRange",
                                                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                                                        buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                  16,
                                                                                                                                                                                                                                                  new __Float64Array(buffer, 8, 2).byteLength
                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                      end end)
                                                                                                                                                                                                                                  },
                                                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                                                      "float64_array - fromLength",
                                                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                    24,
                                                                                                                                                                                                                                                    new __Float64Array(3).byteLength
                                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                                        end end)
                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                                                        "float64_array - unsafe_set - typed_array sanity check",
                                                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                                                            a = new __Float64Array({
                                                                                                                                                                                                                                                  1,
                                                                                                                                                                                                                                                  2,
                                                                                                                                                                                                                                                  3,
                                                                                                                                                                                                                                                  4,
                                                                                                                                                                                                                                                  5
                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                            a[3] = 14;
                                                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                      14,
                                                                                                                                                                                                                                                      a[3]
                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                          end end)
                                                                                                                                                                                                                                      },
                                                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                                                          "DataView - make, byteLength",
                                                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                        32,
                                                                                                                                                                                                                                                        new __DataView(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                                                                      });
                                                                                                                                                                                                                                            end end)
                                                                                                                                                                                                                                        },
                                                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                                                            "DataView - fromBuffer",
                                                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                          32,
                                                                                                                                                                                                                                                          new __DataView(new __ArrayBuffer(32)).byteLength
                                                                                                                                                                                                                                                        });
                                                                                                                                                                                                                                              end end)
                                                                                                                                                                                                                                          },
                                                                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                                                                              "DataView - fromBufferOffset",
                                                                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                                                                  buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                            24,
                                                                                                                                                                                                                                                            new __DataView(buffer, 8).byteLength
                                                                                                                                                                                                                                                          });
                                                                                                                                                                                                                                                end end)
                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                                                                "DataView - fromBufferRange",
                                                                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                                                                    buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                              4,
                                                                                                                                                                                                                                                              new __DataView(buffer, 8, 4).byteLength
                                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                                  end end)
                                                                                                                                                                                                                                              },
                                                                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                                                                  "DataView - buffer",
                                                                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                                                                      buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                buffer,
                                                                                                                                                                                                                                                                new __DataView(buffer).buffer
                                                                                                                                                                                                                                                              });
                                                                                                                                                                                                                                                    end end)
                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                                                                    "DataView - byteOffset",
                                                                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                                                                        buffer = new __ArrayBuffer(32);
                                                                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                  8,
                                                                                                                                                                                                                                                                  new __DataView(buffer, 8).byteOffset
                                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                                      end end)
                                                                                                                                                                                                                                                  },
                                                                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                                                                      "DataView - setInt8, getInt8",
                                                                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                                                                          buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                          view = new __DataView(buffer);
                                                                                                                                                                                                                                                          view.setInt8(0, 1);
                                                                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                    1,
                                                                                                                                                                                                                                                                    view.getInt8(0)
                                                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                                                        end end)
                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                                                                        "DataView - setUint8, getUint8",
                                                                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                                                                            buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                            view = new __DataView(buffer);
                                                                                                                                                                                                                                                            view.setUint8(0, 128);
                                                                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                      128,
                                                                                                                                                                                                                                                                      view.getUint8(0)
                                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                                          end end)
                                                                                                                                                                                                                                                      },
                                                                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                                                                          "DataView - setInt16, getInt16",
                                                                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                                                                              buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                              view = new __DataView(buffer);
                                                                                                                                                                                                                                                              view.setInt16(0, 257);
                                                                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                        257,
                                                                                                                                                                                                                                                                        view.getInt16(0)
                                                                                                                                                                                                                                                                      });
                                                                                                                                                                                                                                                            end end)
                                                                                                                                                                                                                                                        },
                                                                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                                                                            "DataView - getInt16LittleEndian",
                                                                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                                                                buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                view = new __DataView(buffer);
                                                                                                                                                                                                                                                                view.setInt16(0, 25000, 1);
                                                                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                          25000,
                                                                                                                                                                                                                                                                          view.getInt16(0, 1)
                                                                                                                                                                                                                                                                        });
                                                                                                                                                                                                                                                              end end)
                                                                                                                                                                                                                                                          },
                                                                                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                                                                                              "DataView - setInt16LittleEndian",
                                                                                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                                                                                  buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                  view = new __DataView(buffer);
                                                                                                                                                                                                                                                                  view.setInt16(0, 25000, 1);
                                                                                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                            -22431,
                                                                                                                                                                                                                                                                            view.getInt16(0)
                                                                                                                                                                                                                                                                          });
                                                                                                                                                                                                                                                                end end)
                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                                                                                "DataView - setUint16, getUint16",
                                                                                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                                                                                    buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                    view = new __DataView(buffer);
                                                                                                                                                                                                                                                                    view.setUint16(0, 32768);
                                                                                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                              32768,
                                                                                                                                                                                                                                                                              view.getUint16(0)
                                                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                                                  end end)
                                                                                                                                                                                                                                                              },
                                                                                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                                                                                  "DataView - getUint16LittleEndian",
                                                                                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                                                                                      buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                      view = new __DataView(buffer);
                                                                                                                                                                                                                                                                      view.setUint16(0, 32768, 1);
                                                                                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                32768,
                                                                                                                                                                                                                                                                                view.getUint16(0, 1)
                                                                                                                                                                                                                                                                              });
                                                                                                                                                                                                                                                                    end end)
                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                                                                                    "DataView - setUint16LittleEndian",
                                                                                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                                                                                        buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                        view = new __DataView(buffer);
                                                                                                                                                                                                                                                                        view.setUint16(0, 32768, 1);
                                                                                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                  128,
                                                                                                                                                                                                                                                                                  view.getUint16(0)
                                                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                                                      end end)
                                                                                                                                                                                                                                                                  },
                                                                                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                                                                                      "DataView - setInt32, getInt32",
                                                                                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                                                                                          buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                          view = new __DataView(buffer);
                                                                                                                                                                                                                                                                          view.setInt32(0, 65537);
                                                                                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                    65537,
                                                                                                                                                                                                                                                                                    view.getInt32(0)
                                                                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                                                                        end end)
                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                                                                                        "DataView - getInt32LittleEndian",
                                                                                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                                                                                            buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                            view = new __DataView(buffer);
                                                                                                                                                                                                                                                                            view.setInt32(0, 65537, 1);
                                                                                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                      65537,
                                                                                                                                                                                                                                                                                      view.getInt32(0, 1)
                                                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                                                          end end)
                                                                                                                                                                                                                                                                      },
                                                                                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                                                                                          "DataView - setInt32LittleEndian",
                                                                                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                                                                                              buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                              view = new __DataView(buffer);
                                                                                                                                                                                                                                                                              view.setInt32(0, 65537, 1);
                                                                                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                        16777472,
                                                                                                                                                                                                                                                                                        view.getInt32(0)
                                                                                                                                                                                                                                                                                      });
                                                                                                                                                                                                                                                                            end end)
                                                                                                                                                                                                                                                                        },
                                                                                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                                                                                            "DataView - setUint32, getUint32",
                                                                                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                                                                                buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                view.setUint32(0, 65537);
                                                                                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                          65537,
                                                                                                                                                                                                                                                                                          view.getUint32(0)
                                                                                                                                                                                                                                                                                        });
                                                                                                                                                                                                                                                                              end end)
                                                                                                                                                                                                                                                                          },
                                                                                                                                                                                                                                                                          --[[ :: ]]{
                                                                                                                                                                                                                                                                            --[[ tuple ]]{
                                                                                                                                                                                                                                                                              "DataView - getUint32LittleEndian",
                                                                                                                                                                                                                                                                              (function(param) do
                                                                                                                                                                                                                                                                                  buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                  view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                  view.setUint32(0, 65537, 1);
                                                                                                                                                                                                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                            65537,
                                                                                                                                                                                                                                                                                            view.getUint32(0, 1)
                                                                                                                                                                                                                                                                                          });
                                                                                                                                                                                                                                                                                end end)
                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                            --[[ :: ]]{
                                                                                                                                                                                                                                                                              --[[ tuple ]]{
                                                                                                                                                                                                                                                                                "DataView - setUint32LittleEndian",
                                                                                                                                                                                                                                                                                (function(param) do
                                                                                                                                                                                                                                                                                    buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                    view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                    view.setUint32(0, 65537, 1);
                                                                                                                                                                                                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                              16777472,
                                                                                                                                                                                                                                                                                              view.getUint32(0)
                                                                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                                                                  end end)
                                                                                                                                                                                                                                                                              },
                                                                                                                                                                                                                                                                              --[[ :: ]]{
                                                                                                                                                                                                                                                                                --[[ tuple ]]{
                                                                                                                                                                                                                                                                                  "DataView - setFloat32, getFloat32",
                                                                                                                                                                                                                                                                                  (function(param) do
                                                                                                                                                                                                                                                                                      buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                      view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                      view.setFloat32(0, 65537.0);
                                                                                                                                                                                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                65537.0,
                                                                                                                                                                                                                                                                                                view.getFloat32(0)
                                                                                                                                                                                                                                                                                              });
                                                                                                                                                                                                                                                                                    end end)
                                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                                --[[ :: ]]{
                                                                                                                                                                                                                                                                                  --[[ tuple ]]{
                                                                                                                                                                                                                                                                                    "DataView - getFloat32LittleEndian",
                                                                                                                                                                                                                                                                                    (function(param) do
                                                                                                                                                                                                                                                                                        buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                        view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                        view.setFloat32(0, 65537.0, 1);
                                                                                                                                                                                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                  65537.0,
                                                                                                                                                                                                                                                                                                  view.getFloat32(0, 1)
                                                                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                                                                      end end)
                                                                                                                                                                                                                                                                                  },
                                                                                                                                                                                                                                                                                  --[[ :: ]]{
                                                                                                                                                                                                                                                                                    --[[ tuple ]]{
                                                                                                                                                                                                                                                                                      "DataView - setFloat32LittleEndian",
                                                                                                                                                                                                                                                                                      (function(param) do
                                                                                                                                                                                                                                                                                          buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                          view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                          view.setFloat32(0, 1.0, 1);
                                                                                                                                                                                                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                    4.600602988224807e-41,
                                                                                                                                                                                                                                                                                                    view.getFloat32(0)
                                                                                                                                                                                                                                                                                                  });
                                                                                                                                                                                                                                                                                        end end)
                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                    --[[ :: ]]{
                                                                                                                                                                                                                                                                                      --[[ tuple ]]{
                                                                                                                                                                                                                                                                                        "DataView - setFloat64, getFloat64",
                                                                                                                                                                                                                                                                                        (function(param) do
                                                                                                                                                                                                                                                                                            buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                            view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                            view.setFloat64(0, 1e200);
                                                                                                                                                                                                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                      1e200,
                                                                                                                                                                                                                                                                                                      view.getFloat64(0)
                                                                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                                                                          end end)
                                                                                                                                                                                                                                                                                      },
                                                                                                                                                                                                                                                                                      --[[ :: ]]{
                                                                                                                                                                                                                                                                                        --[[ tuple ]]{
                                                                                                                                                                                                                                                                                          "DataView - getFloat64LittleEndian",
                                                                                                                                                                                                                                                                                          (function(param) do
                                                                                                                                                                                                                                                                                              buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                              view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                              view.setFloat64(0, 1e200, 1);
                                                                                                                                                                                                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                        1e200,
                                                                                                                                                                                                                                                                                                        view.getFloat64(0, 1)
                                                                                                                                                                                                                                                                                                      });
                                                                                                                                                                                                                                                                                            end end)
                                                                                                                                                                                                                                                                                        },
                                                                                                                                                                                                                                                                                        --[[ :: ]]{
                                                                                                                                                                                                                                                                                          --[[ tuple ]]{
                                                                                                                                                                                                                                                                                            "DataView - setFloat64LittleEndian",
                                                                                                                                                                                                                                                                                            (function(param) do
                                                                                                                                                                                                                                                                                                buffer = new __ArrayBuffer(8);
                                                                                                                                                                                                                                                                                                view = new __DataView(buffer);
                                                                                                                                                                                                                                                                                                view.setFloat64(0, 1.0, 1);
                                                                                                                                                                                                                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                                                                                                                                                                                                                          3.03865e-319,
                                                                                                                                                                                                                                                                                                          view.getFloat64(0)
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

Mt.from_pair_suites("Js_typed_array_test", suites);

exports = {};
exports.mkI8 = mkI8;
exports.via = via;
exports.viaInt8 = viaInt8;
exports.x = x;
exports.suites = suites;
return exports;
--[[ x Not a pure module ]]
