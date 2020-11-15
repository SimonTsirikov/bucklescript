__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Js_math = require "......lib.js.js_math";

suites_000 = --[[ tuple ]]{
  "_E",
  (function(param) do
      return --[[ ApproxThreshold ]]Block.__(6, {
                0.001,
                2.718,
                __Math.E
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "_LN2",
    (function(param) do
        return --[[ ApproxThreshold ]]Block.__(6, {
                  0.001,
                  0.693,
                  __Math.LN2
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "_LN10",
      (function(param) do
          return --[[ ApproxThreshold ]]Block.__(6, {
                    0.001,
                    2.303,
                    __Math.LN10
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "_LOG2E",
        (function(param) do
            return --[[ ApproxThreshold ]]Block.__(6, {
                      0.001,
                      1.443,
                      __Math.LOG2E
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "_LOG10E",
          (function(param) do
              return --[[ ApproxThreshold ]]Block.__(6, {
                        0.001,
                        0.434,
                        __Math.LOG10E
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "_PI",
            (function(param) do
                return --[[ ApproxThreshold ]]Block.__(6, {
                          0.00001,
                          3.14159,
                          __Math.PI
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "_SQRT1_2",
              (function(param) do
                  return --[[ ApproxThreshold ]]Block.__(6, {
                            0.001,
                            0.707,
                            __Math.SQRT1_2
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "_SQRT2",
                (function(param) do
                    return --[[ ApproxThreshold ]]Block.__(6, {
                              0.001,
                              1.414,
                              __Math.SQRT2
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "abs_int",
                  (function(param) do
                      return --[[ Eq ]]Block.__(0, {
                                4,
                                __Math.abs(-4)
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "abs_float",
                    (function(param) do
                        return --[[ Eq ]]Block.__(0, {
                                  1.2,
                                  __Math.abs(-1.2)
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "acos",
                      (function(param) do
                          return --[[ ApproxThreshold ]]Block.__(6, {
                                    0.001,
                                    1.159,
                                    __Math.acos(0.4)
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "acosh",
                        (function(param) do
                            return --[[ ApproxThreshold ]]Block.__(6, {
                                      0.001,
                                      0.622,
                                      __Math.acosh(1.2)
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "asin",
                          (function(param) do
                              return --[[ ApproxThreshold ]]Block.__(6, {
                                        0.001,
                                        0.411,
                                        __Math.asin(0.4)
                                      });
                            end end)
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "asinh",
                            (function(param) do
                                return --[[ ApproxThreshold ]]Block.__(6, {
                                          0.001,
                                          0.390,
                                          __Math.asinh(0.4)
                                        });
                              end end)
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "atan",
                              (function(param) do
                                  return --[[ ApproxThreshold ]]Block.__(6, {
                                            0.001,
                                            0.380,
                                            __Math.atan(0.4)
                                          });
                                end end)
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "atanh",
                                (function(param) do
                                    return --[[ ApproxThreshold ]]Block.__(6, {
                                              0.001,
                                              0.423,
                                              __Math.atanh(0.4)
                                            });
                                  end end)
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "atan2",
                                  (function(param) do
                                      return --[[ ApproxThreshold ]]Block.__(6, {
                                                0.001,
                                                0.588,
                                                __Math.atan2(0.4, 0.6)
                                              });
                                    end end)
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    "cbrt",
                                    (function(param) do
                                        return --[[ Eq ]]Block.__(0, {
                                                  2,
                                                  __Math.cbrt(8)
                                                });
                                      end end)
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "unsafe_ceil_int",
                                      (function(param) do
                                          return --[[ Eq ]]Block.__(0, {
                                                    4,
                                                    __Math.ceil(3.2)
                                                  });
                                        end end)
                                    },
                                    --[[ :: ]]{
                                      --[[ tuple ]]{
                                        "ceil_int",
                                        (function(param) do
                                            return --[[ Eq ]]Block.__(0, {
                                                      4,
                                                      Js_math.ceil_int(3.2)
                                                    });
                                          end end)
                                      },
                                      --[[ :: ]]{
                                        --[[ tuple ]]{
                                          "ceil_float",
                                          (function(param) do
                                              return --[[ Eq ]]Block.__(0, {
                                                        4,
                                                        __Math.ceil(3.2)
                                                      });
                                            end end)
                                        },
                                        --[[ :: ]]{
                                          --[[ tuple ]]{
                                            "cos",
                                            (function(param) do
                                                return --[[ ApproxThreshold ]]Block.__(6, {
                                                          0.001,
                                                          0.921,
                                                          __Math.cos(0.4)
                                                        });
                                              end end)
                                          },
                                          --[[ :: ]]{
                                            --[[ tuple ]]{
                                              "cosh",
                                              (function(param) do
                                                  return --[[ ApproxThreshold ]]Block.__(6, {
                                                            0.001,
                                                            1.081,
                                                            __Math.cosh(0.4)
                                                          });
                                                end end)
                                            },
                                            --[[ :: ]]{
                                              --[[ tuple ]]{
                                                "exp",
                                                (function(param) do
                                                    return --[[ ApproxThreshold ]]Block.__(6, {
                                                              0.001,
                                                              1.491,
                                                              __Math.exp(0.4)
                                                            });
                                                  end end)
                                              },
                                              --[[ :: ]]{
                                                --[[ tuple ]]{
                                                  "expm1",
                                                  (function(param) do
                                                      return --[[ ApproxThreshold ]]Block.__(6, {
                                                                0.001,
                                                                0.491,
                                                                __Math.expm1(0.4)
                                                              });
                                                    end end)
                                                },
                                                --[[ :: ]]{
                                                  --[[ tuple ]]{
                                                    "unsafe_floor_int",
                                                    (function(param) do
                                                        return --[[ Eq ]]Block.__(0, {
                                                                  3,
                                                                  __Math.floor(3.2)
                                                                });
                                                      end end)
                                                  },
                                                  --[[ :: ]]{
                                                    --[[ tuple ]]{
                                                      "floor_int",
                                                      (function(param) do
                                                          return --[[ Eq ]]Block.__(0, {
                                                                    3,
                                                                    Js_math.floor_int(3.2)
                                                                  });
                                                        end end)
                                                    },
                                                    --[[ :: ]]{
                                                      --[[ tuple ]]{
                                                        "floor_float",
                                                        (function(param) do
                                                            return --[[ Eq ]]Block.__(0, {
                                                                      3,
                                                                      __Math.floor(3.2)
                                                                    });
                                                          end end)
                                                      },
                                                      --[[ :: ]]{
                                                        --[[ tuple ]]{
                                                          "fround",
                                                          (function(param) do
                                                              return --[[ Approx ]]Block.__(5, {
                                                                        3.2,
                                                                        __Math.fround(3.2)
                                                                      });
                                                            end end)
                                                        },
                                                        --[[ :: ]]{
                                                          --[[ tuple ]]{
                                                            "hypot",
                                                            (function(param) do
                                                                return --[[ ApproxThreshold ]]Block.__(6, {
                                                                          0.001,
                                                                          0.721,
                                                                          __Math.hypot(0.4, 0.6)
                                                                        });
                                                              end end)
                                                          },
                                                          --[[ :: ]]{
                                                            --[[ tuple ]]{
                                                              "hypotMany",
                                                              (function(param) do
                                                                  return --[[ ApproxThreshold ]]Block.__(6, {
                                                                            0.001,
                                                                            1.077,
                                                                            __Math.hypot(0.4, 0.6, 0.8)
                                                                          });
                                                                end end)
                                                            },
                                                            --[[ :: ]]{
                                                              --[[ tuple ]]{
                                                                "imul",
                                                                (function(param) do
                                                                    return --[[ Eq ]]Block.__(0, {
                                                                              8,
                                                                              __Math.imul(4, 2)
                                                                            });
                                                                  end end)
                                                              },
                                                              --[[ :: ]]{
                                                                --[[ tuple ]]{
                                                                  "log",
                                                                  (function(param) do
                                                                      return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                0.001,
                                                                                -0.916,
                                                                                __Math.log(0.4)
                                                                              });
                                                                    end end)
                                                                },
                                                                --[[ :: ]]{
                                                                  --[[ tuple ]]{
                                                                    "log1p",
                                                                    (function(param) do
                                                                        return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                  0.001,
                                                                                  0.336,
                                                                                  __Math.log1p(0.4)
                                                                                });
                                                                      end end)
                                                                  },
                                                                  --[[ :: ]]{
                                                                    --[[ tuple ]]{
                                                                      "log10",
                                                                      (function(param) do
                                                                          return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                    0.001,
                                                                                    -0.397,
                                                                                    __Math.log10(0.4)
                                                                                  });
                                                                        end end)
                                                                    },
                                                                    --[[ :: ]]{
                                                                      --[[ tuple ]]{
                                                                        "log2",
                                                                        (function(param) do
                                                                            return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                      0.001,
                                                                                      -1.321,
                                                                                      __Math.log2(0.4)
                                                                                    });
                                                                          end end)
                                                                      },
                                                                      --[[ :: ]]{
                                                                        --[[ tuple ]]{
                                                                          "max_int",
                                                                          (function(param) do
                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                        4,
                                                                                        __Math.max(2, 4)
                                                                                      });
                                                                            end end)
                                                                        },
                                                                        --[[ :: ]]{
                                                                          --[[ tuple ]]{
                                                                            "maxMany_int",
                                                                            (function(param) do
                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                          4,
                                                                                          __Math.max(2, 4, 3)
                                                                                        });
                                                                              end end)
                                                                          },
                                                                          --[[ :: ]]{
                                                                            --[[ tuple ]]{
                                                                              "max_float",
                                                                              (function(param) do
                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                            4.2,
                                                                                            __Math.max(2.7, 4.2)
                                                                                          });
                                                                                end end)
                                                                            },
                                                                            --[[ :: ]]{
                                                                              --[[ tuple ]]{
                                                                                "maxMany_float",
                                                                                (function(param) do
                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                              4.2,
                                                                                              __Math.max(2.7, 4.2, 3.9)
                                                                                            });
                                                                                  end end)
                                                                              },
                                                                              --[[ :: ]]{
                                                                                --[[ tuple ]]{
                                                                                  "min_int",
                                                                                  (function(param) do
                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                2,
                                                                                                __Math.min(2, 4)
                                                                                              });
                                                                                    end end)
                                                                                },
                                                                                --[[ :: ]]{
                                                                                  --[[ tuple ]]{
                                                                                    "minMany_int",
                                                                                    (function(param) do
                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                  2,
                                                                                                  __Math.min(2, 4, 3)
                                                                                                });
                                                                                      end end)
                                                                                  },
                                                                                  --[[ :: ]]{
                                                                                    --[[ tuple ]]{
                                                                                      "min_float",
                                                                                      (function(param) do
                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                    2.7,
                                                                                                    __Math.min(2.7, 4.2)
                                                                                                  });
                                                                                        end end)
                                                                                    },
                                                                                    --[[ :: ]]{
                                                                                      --[[ tuple ]]{
                                                                                        "minMany_float",
                                                                                        (function(param) do
                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                      2.7,
                                                                                                      __Math.min(2.7, 4.2, 3.9)
                                                                                                    });
                                                                                          end end)
                                                                                      },
                                                                                      --[[ :: ]]{
                                                                                        --[[ tuple ]]{
                                                                                          "random",
                                                                                          (function(param) do
                                                                                              a = __Math.random();
                                                                                              return --[[ Ok ]]Block.__(4, {a >= 0 and a < 1});
                                                                                            end end)
                                                                                        },
                                                                                        --[[ :: ]]{
                                                                                          --[[ tuple ]]{
                                                                                            "random_int",
                                                                                            (function(param) do
                                                                                                a = Js_math.random_int(1, 3);
                                                                                                return --[[ Ok ]]Block.__(4, {a >= 1 and a < 3});
                                                                                              end end)
                                                                                          },
                                                                                          --[[ :: ]]{
                                                                                            --[[ tuple ]]{
                                                                                              "unsafe_round",
                                                                                              (function(param) do
                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                            3,
                                                                                                            __Math.round(3.2)
                                                                                                          });
                                                                                                end end)
                                                                                            },
                                                                                            --[[ :: ]]{
                                                                                              --[[ tuple ]]{
                                                                                                "round",
                                                                                                (function(param) do
                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                              3,
                                                                                                              __Math.round(3.2)
                                                                                                            });
                                                                                                  end end)
                                                                                              },
                                                                                              --[[ :: ]]{
                                                                                                --[[ tuple ]]{
                                                                                                  "sign_int",
                                                                                                  (function(param) do
                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                -1,
                                                                                                                __Math.sign(-4)
                                                                                                              });
                                                                                                    end end)
                                                                                                },
                                                                                                --[[ :: ]]{
                                                                                                  --[[ tuple ]]{
                                                                                                    "sign_float",
                                                                                                    (function(param) do
                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                  -1,
                                                                                                                  __Math.sign(-4.2)
                                                                                                                });
                                                                                                      end end)
                                                                                                  },
                                                                                                  --[[ :: ]]{
                                                                                                    --[[ tuple ]]{
                                                                                                      "sign_float -0",
                                                                                                      (function(param) do
                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                    -0,
                                                                                                                    __Math.sign(-0)
                                                                                                                  });
                                                                                                        end end)
                                                                                                    },
                                                                                                    --[[ :: ]]{
                                                                                                      --[[ tuple ]]{
                                                                                                        "sin",
                                                                                                        (function(param) do
                                                                                                            return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                                                      0.001,
                                                                                                                      0.389,
                                                                                                                      __Math.sin(0.4)
                                                                                                                    });
                                                                                                          end end)
                                                                                                      },
                                                                                                      --[[ :: ]]{
                                                                                                        --[[ tuple ]]{
                                                                                                          "sinh",
                                                                                                          (function(param) do
                                                                                                              return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                                                        0.001,
                                                                                                                        0.410,
                                                                                                                        __Math.sinh(0.4)
                                                                                                                      });
                                                                                                            end end)
                                                                                                        },
                                                                                                        --[[ :: ]]{
                                                                                                          --[[ tuple ]]{
                                                                                                            "sqrt",
                                                                                                            (function(param) do
                                                                                                                return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                                                          0.001,
                                                                                                                          0.632,
                                                                                                                          __Math.sqrt(0.4)
                                                                                                                        });
                                                                                                              end end)
                                                                                                          },
                                                                                                          --[[ :: ]]{
                                                                                                            --[[ tuple ]]{
                                                                                                              "tan",
                                                                                                              (function(param) do
                                                                                                                  return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                                                            0.001,
                                                                                                                            0.422,
                                                                                                                            __Math.tan(0.4)
                                                                                                                          });
                                                                                                                end end)
                                                                                                            },
                                                                                                            --[[ :: ]]{
                                                                                                              --[[ tuple ]]{
                                                                                                                "tanh",
                                                                                                                (function(param) do
                                                                                                                    return --[[ ApproxThreshold ]]Block.__(6, {
                                                                                                                              0.001,
                                                                                                                              0.379,
                                                                                                                              __Math.tanh(0.4)
                                                                                                                            });
                                                                                                                  end end)
                                                                                                              },
                                                                                                              --[[ :: ]]{
                                                                                                                --[[ tuple ]]{
                                                                                                                  "unsafe_trunc",
                                                                                                                  (function(param) do
                                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                                4,
                                                                                                                                __Math.trunc(4.2156)
                                                                                                                              });
                                                                                                                    end end)
                                                                                                                },
                                                                                                                --[[ :: ]]{
                                                                                                                  --[[ tuple ]]{
                                                                                                                    "trunc",
                                                                                                                    (function(param) do
                                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                                  4,
                                                                                                                                  __Math.trunc(4.2156)
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
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Js_math_test", suites);

exports = {};
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
